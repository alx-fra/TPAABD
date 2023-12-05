CREATE OR REPLACE PROCEDURE a_emite_fatura(
    num_de_telefone IN VARCHAR,
    ano_mes IN VARCHAR
)
AS
  v_cod_contrato contrato.cod_contrato%TYPE;
  v_cod_plano contrato.cod_plano%TYPE;
  v_montante NUMBER := 0;
  v_montanteAux NUMBER :=0;
  v_cod_fatura fatura.cod_fatura%TYPE;
  v_data_inicio DATE := to_date(ano_mes, 'yyyy-mm');
  v_data_fim DATE;
  v_num_sms NUMBER := 0;
  v_custo_sms tarifario.preco_unidade%TYPE;
BEGIN
  -- verifica se o numero de telefone existe na tabela contrato e é válido
  SELECT cod_contrato
  INTO v_cod_contrato
  FROM contrato
  WHERE nr_telemovel = num_de_telefone
    AND estado_numero = 'Disponivel';

  IF v_cod_contrato IS NULL THEN
    RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
  END IF;

  -- obter cod plano se for pos-pago
  SELECT cod_plano
  INTO v_cod_plano
  FROM plano
  WHERE cod_plano = (SELECT cod_plano FROM contrato WHERE cod_contrato = v_cod_contrato)
    AND (UPPER(tipo_plano) = 'POS PAGO SIMPLES' OR UPPER(tipo_plano) = 'POS PAGO PLAFOND');

  -- ver se ja exite uma fatura esse ano_mes
  SELECT COUNT(*)
  INTO v_montante
  FROM fatura
  WHERE cod_contrato = v_cod_contrato
    AND TRUNC(data_inicio, 'MM') = TRUNC(v_data_inicio, 'MM');

  IF v_montante > 0 THEN
    RAISE_APPLICATION_ERROR(-20510, 'Fatura já foi emitida.');
  END IF;

  -- adicionar ao montante os preços das chamadas terminadas desse contrato
  SELECT SUM(b_custo_da_chamada(i.cod_interacao))
  INTO v_montante
  FROM interacao i
  INNER JOIN contrato c ON i.cod_contrato = c.cod_contrato
  INNER JOIN chamada ch ON i.cod_interacao = ch.cod_interacao
  INNER JOIN eventos e ON i.cod_interacao = e.cod_interacao
  WHERE c.cod_contrato = v_cod_contrato
    AND e.estado = 'Terminada'
    AND EXTRACT(MONTH FROM ch.instante_final) = EXTRACT(MONTH FROM v_data_inicio)
    AND EXTRACT(YEAR FROM ch.instante_final) = EXTRACT(YEAR FROM v_data_inicio);

  IF v_montante IS NULL THEN
    v_montante := 0;
  END IF;

  -- ver numero de SMS enviados
  SELECT COUNT(*)
  INTO v_num_sms
  FROM interacao i
  INNER JOIN contrato c ON i.cod_contrato = c.cod_contrato
  INNER JOIN sms s ON i.cod_interacao = s.cod_interacao
  INNER JOIN eventos e ON i.cod_interacao = e.cod_interacao
  INNER JOIN tarifario t ON c.cod_plano = t.cod_plano
  WHERE c.cod_contrato = v_cod_contrato
    AND t.tipo = 'SMS'
    AND t.estado = 'Ativo'
    AND e.estado = 'Enviada'
    AND i.instante_inicial = v_data_inicio;

  -- obter custo de cada SMS
  SELECT preco_unidade
  INTO v_custo_sms
  FROM tarifario
  WHERE tipo = 'SMS'
    AND estado = 'Ativo'
    AND cod_plano = v_cod_plano;

  -- somar ao montante o custo dos SMS enviados
  v_montante := v_montante + (v_num_sms * v_custo_sms);

  -- adicionar o preço do plano
  SELECT valor
  INTO v_montanteAux
  FROM plano
  WHERE cod_plano = v_cod_plano;
  
  v_montante := v_montante + v_montanteAux;

  -- proximo codigo de fatura
  SELECT NVL(MAX(cod_fatura), 0) + 1
  INTO v_cod_fatura
  FROM fatura;

  -- data final fatura(data maxima de pagamento)
  SELECT CASE
           WHEN tipo_faturacao = 'Anual' THEN ADD_MONTHS(v_data_inicio, 12)
           WHEN tipo_faturacao = 'Mensal' THEN ADD_MONTHS(v_data_inicio, 1)
		   WHEN tipo_faturacao = 'Trimestral' THEN ADD_MONTHS(v_data_inicio, 3)
         END
  INTO v_data_fim
  FROM plano
  WHERE cod_plano = v_cod_plano;

  -- nova fatura
  INSERT INTO fatura (cod_fatura,cod_contrato, montante, data_inicio, data_final, estado)
  VALUES (v_cod_fatura, v_cod_contrato, v_montante, v_data_inicio, v_data_fim, 'PENDENTE');

  -- tabela INTERACOES_FATURAVEIS com chamadas
  FOR chamada IN (SELECT i.cod_interacao, (ch.instante_final - i.instante_inicial) * 24 * 60 AS duracao
                  FROM interacao i
                  INNER JOIN contrato c ON i.cod_contrato = c.cod_contrato
                  INNER JOIN chamada ch ON i.cod_interacao = ch.cod_interacao
                  INNER JOIN eventos e ON i.cod_interacao = e.cod_interacao
                  WHERE c.cod_contrato = v_cod_contrato
                  AND e.estado = 'Terminada'
                  AND EXTRACT(MONTH FROM ch.instante_final) = EXTRACT(MONTH FROM v_data_inicio)
                  AND EXTRACT(YEAR FROM ch.instante_final) = EXTRACT(YEAR FROM v_data_inicio))
  LOOP
    INSERT INTO INTERACOES_FATURAVEIS (CUSTO, TIPO_INTERACAO, COD_FATURAVEL, COD_INTERACAO, COD_FATURA, DURACAO)
    VALUES (b_custo_da_chamada(chamada.cod_interacao), 'Chamada',
            (SELECT NVL(MAX(COD_FATURAVEL), 0) + 1 FROM INTERACOES_FATURAVEIS),
            chamada.cod_interacao, v_cod_fatura, ROUND(chamada.duracao,2));
  END LOOP;

  -- tabela INTERACOES_FATURAVEIS com SMS
  FOR sms IN (SELECT i.cod_interacao
              FROM interacao i
              INNER JOIN contrato c ON i.cod_contrato = c.cod_contrato
              INNER JOIN sms s ON i.cod_interacao = s.cod_interacao
              INNER JOIN eventos e ON i.cod_interacao = e.cod_interacao
              INNER JOIN tarifario t ON c.cod_plano = t.cod_plano
              WHERE c.cod_contrato = v_cod_contrato
                AND t.tipo = 'SMS'
                AND t.estado = 'Ativo'
                AND e.estado = 'Enviada'
                AND EXTRACT(MONTH FROM i.instante_inicial) = EXTRACT(MONTH FROM v_data_inicio)
                AND EXTRACT(YEAR FROM i.instante_inicial) = EXTRACT(YEAR FROM v_data_inicio))
  LOOP
    INSERT INTO INTERACOES_FATURAVEIS (CUSTO, TIPO_INTERACAO, COD_FATURAVEL, COD_INTERACAO, COD_FATURA, DURACAO)
    VALUES (v_custo_sms, 'SMS',
            (SELECT NVL(MAX(COD_FATURAVEL), 0) + 1 FROM INTERACOES_FATURAVEIS),
            sms.cod_interacao, v_cod_fatura, 0);
  END LOOP;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20502, 'Número de telefone inexistente ou plano inválido.');
  WHEN OTHERS THEN
    ROLLBACK;
END a_emite_fatura;
/




CREATE OR REPLACE FUNCTION b_custo_da_chamada(
    idChamada NUMBER)
  RETURN NUMBER
IS
  v_custo NUMBER;
BEGIN
  SELECT ((ch.instante_final - i.instante_inicial) * 24 * 60 * t.preco_unidade)
  INTO v_custo
  FROM interacao i
  JOIN chamada ch
  ON i.cod_interacao = ch.cod_interacao
  JOIN contrato c
  ON i.cod_contrato = c.cod_contrato
  JOIN plano p
  ON c.cod_plano = p.cod_plano
  JOIN tarifario t
  ON p.cod_plano        = t.cod_plano
  WHERE i.cod_interacao = idChamada
  AND t.tipo = 'Voz'
  AND t.estado = 'Ativo';
  IF v_custo IS NULL THEN
    RAISE_APPLICATION_ERROR(-20514, 'ID da chamada inválido.');
  END IF;
RETURN v_custo;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20514, 'ID da chamada inválido.');
END;
/




create or replace FUNCTION c_preco_por_minuto (
    num_origem VARCHAR,
    num_destino VARCHAR
) RETURN NUMBER AS
    v_cod_plano CONTRATO.COD_PLANO%TYPE;
    v_preco_unidade TARIFARIO.PRECO_UNIDADE%TYPE;
    v_preco_minuto NUMBER;
    v_estado_numero CONTRATO.ESTADO_NUMERO%TYPE;
    cod NUMBER;
BEGIN

SELECT COUNT(COD_CONTRATO) into cod from contrato where NR_TELEMOVEL = num_origem;
IF cod =0 THEN
        RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
    END IF;
  SELECT c.ESTADO_NUMERO INTO v_estado_numero
    FROM CONTRATO c
    WHERE c.NR_TELEMOVEL = num_origem;
    
    IF v_estado_numero <> 'Disponivel' THEN
        RAISE_APPLICATION_ERROR(-20511, 'Número inativo.');
    END IF;
    
    SELECT COD_PLANO INTO v_cod_plano
    FROM CONTRATO
    WHERE NR_TELEMOVEL = num_origem;
    
    SELECT PRECO_UNIDADE INTO v_preco_unidade
    FROM TARIFARIO
    WHERE COD_PLANO = v_cod_plano
    AND ESTADO = 'Ativo'
    AND TIPO = 'Voz'
    AND UNIDADE = 'Minuto';
    
    RETURN v_preco_unidade;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20502  ,'Inválido Número de telefone.' );
END;
/



CREATE OR REPLACE FUNCTION d_tipo_de_chamada_voz(
    num_telefone VARCHAR)
  RETURN VARCHAR2
IS
  v_tipo_chamada VARCHAR2(100);
  v_exists NUMBER := 0;
BEGIN

  IF NOT REGEXP_LIKE(num_telefone, '^\d+$') THEN
    RAISE_APPLICATION_ERROR(-20502, 'Número de telefone inválido.');
  END IF;

  -- rede
  SELECT REDE
  INTO v_tipo_chamada
  FROM CLASSIFICACAO
  WHERE nr_destino = num_telefone
  AND ROWNUM = 1;

    
  IF v_tipo_chamada IS NULL THEN
    -- se nr existe
    SELECT 1 INTO v_exists
    FROM contrato
    WHERE nr_telemovel = to_number(num_telefone);
    
    IF v_exists = 0 THEN
      RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
    END IF;
    
    -- tarifario ativo
    SELECT 1 INTO v_exists
    FROM contrato c
    JOIN plano p ON c.cod_plano = p.cod_plano
    JOIN tarifario t ON p.cod_plano = t.cod_plano
    WHERE c.nr_telemovel = to_number(num_telefone)
    AND t.estado = 'Inativo'
    AND ROWNUM = 1;
    
    IF v_exists = 1 THEN
      RAISE_APPLICATION_ERROR(-20505, 'Tarifário não ativo.');
    END IF;
    
    -- numero 
    SELECT 1 INTO v_exists
    FROM contrato
    WHERE nr_telemovel = to_number(num_telefone)
    AND estado_numero = 'Inexistente'
    AND ROWNUM = 1;
    
    IF v_exists = 1 THEN
      RAISE_APPLICATION_ERROR(-20511, 'Número inativo.');
    END IF;
    
    -- Gama está indefinida
    RAISE_APPLICATION_ERROR(-20515, 'Gama de números indefinida.');
  END IF;
  
  RETURN v_tipo_chamada;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20515, 'Gama de números indefinida.');
END;
/




CREATE OR REPLACE FUNCTION e_numero_normalizado (
    num_telefone VARCHAR
) RETURN VARCHAR AS
    v_numero_normalizado VARCHAR(20);
BEGIN
    v_numero_normalizado := REGEXP_REPLACE(num_telefone, '[^[:digit:]]', '');

    v_numero_normalizado := REGEXP_REPLACE(v_numero_normalizado, '^00351', '');

    RETURN v_numero_normalizado;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20502, 'Inválido Número de telefone.');
END;
/





CREATE OR REPLACE PROCEDURE f_envia_SMS(
    num_de_origem  VARCHAR2,
    num_de_destino VARCHAR2,
    mensagem       VARCHAR2 )
AS
  cod_interacao NUMBER;
  cod_evento    NUMBER;
  nr NUMBER;
  cod_contrato NUMBER;
  sald NUMBER;
  estado CONTRATO.ESTADO_NUMERO%TYPE;
  x NUMBER;
BEGIN
  SELECT COUNT(COD_CONTRATO) INTO nr FROM CONTRATO WHERE NR_TELEMOVEL = num_de_origem and ESTADO_NUMERO <> 'Inexistente';
  IF nr = 0 THEN
    RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
      END IF;
  SELECT ESTADO_NUMERO INTO estado FROM CONTRATO WHERE NR_TELEMOVEL = num_de_origem and ESTADO_NUMERO <> 'Inexistente';

  IF estado <> 'Disponivel' THEN
        RAISE_APPLICATION_ERROR(-20511, 'Número inativo.');
  END IF;
  select COUNT(*) into x FROM CLASSIFICACAO WHERE NR_DESTINO = num_de_destino;
  IF x=0 THEN
  --IDEAL SERIA CRIAR UMA NOVA LINHA NA TABELA COM O NR_DESTINO CASO ELE FOSSE VÁLIDO, NO ENTANTO OS NRS VARIAM EM TODOS OS PAISES (EM TAMANHO, ou seja, é dificil de invalidar um numero)
      RAISE_APPLICATION_ERROR(-20502, 'Inválido Número de telefone.');
  END IF;
  
  SELECT SALDO into sald FROM CONTRATO WHERE COD_CONTRATO =nr;
  
  IF sald = 0 then
        RAISE_APPLICATION_ERROR(-20508, 'Telefone sem saldo.');
END IF;
  SELECT MAX(COD_INTERACAO) + 1 INTO cod_interacao FROM INTERACAO;
  IF cod_interacao IS NULL THEN
    cod_interacao  := 1;
  END IF;
  SELECT MAX(COD_EVENTO) + 1 INTO cod_evento FROM EVENTOS;
  IF cod_evento IS NULL THEN
    cod_evento  := 1;
  END IF;
  
  INSERT
  INTO INTERACAO
    (COD_CONTRATO,
      COD_INTERACAO,
      COD_FATURAVEL,
      NR_DESTINO,
      INSTANTE_INICIAL,
      ESTADO
    )
    VALUES
    (nr,
      cod_interacao,
      null,
      num_de_destino,
      SYSTIMESTAMP,
      'enviada'
    );
  INSERT
  INTO EVENTOS
    (
      COD_EVENTO,
      INSTANTE,
      ESTADO,
      COD_INTERACAO
    )
    VALUES
    (
      cod_evento,
      SYSTIMESTAMP,
      'enviada',
      cod_interacao
    );
  INSERT INTO SMS
    (COD_INTERACAO, MENSAGEM
    ) VALUES
    (cod_interacao, mensagem
    );
END;
/





CREATE OR REPLACE PROCEDURE g_estabelece_chamada(
    num_de_origem VARCHAR,
    num_de_destino VARCHAR
)
IS
  v_cod_interacao NUMBER;
  v_cod_contrato NUMBER;
  v_cod_evento NUMBER;
  v_tipo_rede VARCHAR2(100);
BEGIN
  -- ver se o nr de origem pode fazer a chamada
  v_tipo_rede := h_pode_realizar_a_chamada(num_de_origem, num_de_destino);
  
  IF v_tipo_rede IS NULL THEN
    RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
  ELSIF v_tipo_rede = 'Inválido Número de telefone.' THEN
    RAISE_APPLICATION_ERROR(-20502, 'Inválido Número de telefone.');
  ELSIF v_tipo_rede = 'Telefone sem saldo.' THEN
    RAISE_APPLICATION_ERROR(-20508, 'Telefone sem saldo.');
  ELSIF v_tipo_rede = 'Número inativo.' THEN
    RAISE_APPLICATION_ERROR(-20511, 'Número inativo.');
  END IF;
  
  -- cod_contrato
  SELECT cod_contrato INTO v_cod_contrato
  FROM contrato
  WHERE nr_telemovel = num_de_origem
  AND ROWNUM = 1;
  
  -- cod_interacao
  SELECT MAX(cod_interacao) + 1 INTO v_cod_interacao
  FROM interacao;
  
  -- INTERACAO
  INSERT INTO interacao (
    cod_interacao,
    cod_faturavel,
    nr_destino,
    cod_contrato,
    instante_inicial,
    estado
  ) VALUES (
    v_cod_interacao,
    NULL,
    num_de_destino,
    v_cod_contrato,
    SYSDATE,
    'Iniciada'
  );
  
  -- CHAMADA
  INSERT INTO chamada (
    cod_interacao,
    instante_final
  ) VALUES (
    v_cod_interacao,
    NULL
  );
  
  -- cod_evento
  SELECT MAX(cod_evento) + 1 INTO v_cod_evento
  FROM eventos;
  
  -- EVENTOS
  INSERT INTO eventos (
    instante,
    estado,
    cod_evento,
    cod_interacao
  ) VALUES (
    SYSDATE,
    'Iniciada',
    v_cod_evento,
    v_cod_interacao
  );
  
  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/




CREATE OR REPLACE FUNCTION h_pode_realizar_a_chamada(
    num_de_origem VARCHAR,
    num_de_destino VARCHAR
) RETURN VARCHAR2
IS
    v_tipo_rede_destino VARCHAR2(100);
    v_saldo_contrato contrato.saldo%type;
    v_estado_contrato contrato.estado_numero%type;
    v_estado_tarifario tarifario.estado%type;
BEGIN
    
        
    -- ver se o numero de origem existe na tabela contrato
    SELECT c.estado_numero, c.saldo
    INTO v_estado_contrato, v_saldo_contrato
    FROM contrato c
    WHERE c.nr_telemovel = num_de_origem;

    IF v_estado_contrato IS NULL THEN
        RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
    END IF;
    
    -- ver se o numero de origem e valido
    IF NOT REGEXP_LIKE(num_de_origem, '^\d+$') THEN
        RAISE_APPLICATION_ERROR(-20502, 'Inválido Número de telefone.');
    END IF;

    -- ver se o numero de origem tem saldo
    IF v_saldo_contrato IS NOT NULL AND v_saldo_contrato <= 0 THEN
        RAISE_APPLICATION_ERROR(-20508, 'Telefone sem saldo.');
    END IF;

    -- ver se o numero(contrato) esta ativo
    IF v_estado_contrato <> 'Disponivel' THEN
        RAISE_APPLICATION_ERROR(-20511, 'Número inativo.');
    END IF;

    -- tipo de rede do nr de destino
    v_tipo_rede_destino := d_tipo_de_chamada_voz(num_de_destino);

    RETURN v_tipo_rede_destino;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
    WHEN OTHERS THEN
        RAISE;
END;
/




CREATE OR REPLACE TRIGGER i_atualiza_saldo
AFTER UPDATE OF instante_final ON chamada
FOR EACH ROW
DECLARE
    v_duracao_minutos NUMBER;
    v_preco_unidade NUMBER;
    v_estado_interacao interacao.estado%TYPE;
    v_instante_inicial interacao.instante_inicial%TYPE;
    v_cod_contrato contrato.cod_contrato%TYPE;
    v_cod_plano contrato.cod_plano%TYPE;
BEGIN
    -- estado e instante_inicial da interacao da chamada
    SELECT estado, instante_inicial, cod_contrato
    INTO v_estado_interacao, v_instante_inicial, v_cod_contrato
    FROM interacao
    WHERE cod_interacao = :NEW.cod_interacao;

    IF v_estado_interacao = 'Terminada' THEN
        -- duração
        v_duracao_minutos := ROUND((:NEW.instante_final - v_instante_inicial) * 24 * 60);

        -- cod_plano
        SELECT cod_plano
        INTO v_cod_plano
        FROM contrato
        WHERE cod_contrato = v_cod_contrato;

        -- preco(minuto)
        SELECT preco_unidade
        INTO v_preco_unidade
        FROM tarifario
        WHERE tipo = 'Voz'
        AND unidade = 'Minuto'
        AND cod_plano = v_cod_plano;

        -- atualizar
        UPDATE contrato
        SET saldo = saldo - (v_preco_unidade * v_duracao_minutos)
        WHERE cod_contrato = v_cod_contrato;
    END IF;
END;
/




CREATE OR REPLACE FUNCTION j_get_saldo(
    numero VARCHAR,
    tipo   VARCHAR DEFAULT 'valor')
  RETURN NUMBER
AS
  saldo_disponivel NUMBER;
  nr               NUMBER;
  codplano         NUMBER;
  tipoplano PLANO.TIPO_PLANO%TYPE;
  retornar NUMBER;
BEGIN
  SELECT COUNT(COD_CONTRATO)
  INTO nr
  FROM CONTRATO
  WHERE NR_TELEMOVEL = numero
  AND ESTADO_NUMERO <> 'Inexistente';
  IF nr              = 0 THEN
    RAISE_APPLICATION_ERROR(-20501, 'Número de telefone inexistente.');
  END IF;
SELECT c.SALDO,
  c.COD_PLANO
INTO saldo_disponivel,
  codplano
FROM CONTRATO c
WHERE c.NR_TELEMOVEL = numero;
SELECT TIPO_PLANO INTO tipoplano FROM PLANO WHERE COD_PLANO = codplano;
IF tipoplano = 'POS PAGO SIMPLES                ' AND tipo <> 'valor' THEN
  RETURN 0;
END IF;
IF tipo = 'valor' THEN
  RETURN saldo_disponivel;
ELSIF tipo     = 'voz' THEN
  IF TIPOPLANO = 'POS PAGO PLAFOND                ' THEN
    SELECT MINUTOS
    INTO retornar
    FROM PLANO_POS_PAGO_PLAFOND
    WHERE COD_PLANO = codplano;
    RETURN retornar;
  ELSE
    SELECT MINUTOS
    INTO retornar
    FROM PLANO_PRE_PAGO
    WHERE COD_PLANO = codplano;
    RETURN retornar;
  END IF;
ELSIF tipo     = 'SMS' THEN
  IF TIPOPLANO = 'POS PAGO PLAFOND                ' THEN
    SELECT SMS
    INTO retornar
    FROM PLANO_POS_PAGO_PLAFOND
    WHERE COD_PLANO = codplano;
    RETURN retornar;
  ELSE
    SELECT SMS
    INTO retornar
    FROM PLANO_PRE_PAGO
    WHERE COD_PLANO = codplano;
    RETURN retornar;
  END IF;
ELSE
  RAISE_APPLICATION_ERROR(-20519, 'Tipo de saldo inválido.');
END IF;

END;
/




CREATE OR REPLACE PROCEDURE k_novo_contrato (
  nif VARCHAR2,
  nome VARCHAR2,
  plano VARCHAR2,
  periodo_meses NUMBER
)
AS
  nr_telefone   NUMBER;
  cod_plano     NUMBER;
  cod_contrato  NUMBER;
  cod_interacao NUMBER;
  data_inicio   DATE := SYSDATE;
  data_fim      DATE;
  primeiro_nome VARCHAR2(64);
  mensagem      VARCHAR2(256);
  cod_cliente NUMBER;
  x NUMBER;
BEGIN
--nao foi feita a validação do nome, por ser mais conveniente a testar: select NOME into name from cliente where CONTRIBUINTE= NIF;IF name <> nome then 'nome invalido';
SELECT COUNT(COD_CLIENTE) INTO cod_cliente FROM CLIENTE WHERE CONTRIBUINTE = NIF;

IF cod_cliente =0 THEN
    RAISE_APPLICATION_ERROR(-20518, 'NIF inválido');
  END IF;
  
  SELECT MAX(NR_TELEMOVEL) + 1
  INTO nr_telefone
  FROM CONTRATO;


  SELECT count(COD_PLANO)
  INTO x
  FROM PLANO
  WHERE DESIGNACAO = plano;

  IF x =0 THEN
    RAISE_APPLICATION_ERROR(-20516, 'Plano inexistente.');
  END IF;
  
  SELECT COD_PLANO
  INTO cod_plano
  FROM PLANO
  WHERE DESIGNACAO = plano;
  
  data_fim := ADD_MONTHS(data_inicio, periodo_meses);

  SELECT MAX(COD_CONTRATO) + 1
  INTO cod_contrato
  FROM CONTRATO;

  IF cod_contrato IS NULL THEN
    cod_contrato := 1;
  END IF;

  INSERT INTO CONTRATO (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    SALDO,
    MOTIVO_FINAL_CONTRATO,
    COD_CONTRATO
  ) VALUES (
    nr_telefone,
    cod_cliente,
    cod_plano,
    'Ativo',
    data_inicio,
    data_fim,
    periodo_meses,
    0,
    NULL,
    cod_contrato
  );

  SELECT MAX(COD_INTERACAO) + 1
  INTO cod_interacao
  FROM INTERACAO;

  IF cod_interacao IS NULL THEN
    cod_interacao := 1;
  END IF;

  -- Inserir na tabela INTERACAO
  INSERT INTO INTERACAO (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  ) VALUES (
    cod_interacao,
    NULL,
    null,--teria de existir na tabela classificacao, neste momento, como estao inseridos os dados, na tabela classificacao nao ha nenhum dos numeros que têm contratos, daí estar null(se estivessem inseridos corretamente seria nr_telefone
    cod_contrato,
    SYSTIMESTAMP,
    'Enviada'
  );

  primeiro_nome := SUBSTR(nome, 1, INSTR(nome, ' ') - 1);
  mensagem := 'Bem vindo ' || primeiro_nome;

  INSERT INTO SMS (COD_INTERACAO, MENSAGEM)
  VALUES (cod_interacao, mensagem);

END;
/




CREATE OR REPLACE TRIGGER l_carrega_cartao_prepago
AFTER INSERT ON CARREGAMENTO
FOR EACH ROW
DECLARE
  v_data_inicio_fatura DATE;
  v_data_final_fatura DATE;
  cod_fatura NUMBER;
  codplano NUMBER;
  tipoplano PLANO.TIPO_PLANO%TYPE;
BEGIN
  SELECT C.COD_PLANO
  INTO   codplano
  FROM   CONTRATO C
  WHERE  C.COD_CONTRATO = :NEW.COD_CONTRATO;

  select TIPO_PLANO into tipoplano FROM PLANO WHERE COD_PLANO =codplano;
  IF tipoplano = 'PRE PAGO' THEN
    UPDATE CONTRATO
    SET SALDO = SALDO + :NEW.MONTANTE
    WHERE COD_CONTRATO = :NEW.COD_CONTRATO;

SELECT SYSDATE + INTERVAL '1' DAY * (NR_DIAS),
       SYSDATE
INTO   v_data_final_fatura, v_data_inicio_fatura
FROM   PLANO_PRE_PAGO
WHERE  COD_PLANO = codplano;


  SELECT MAX(COD_FATURA) + 1
  INTO cod_fatura
  FROM FATURA;

  IF cod_fatura IS NULL THEN
    cod_fatura := 1;
  END IF;

    INSERT INTO FATURA (COD_FATURA, COD_CONTRATO, MONTANTE, DATA_INICIO, DATA_FINAL, ESTADO)
    VALUES (cod_fatura, :NEW.COD_CONTRATO, :NEW.MONTANTE, v_data_inicio_fatura, v_data_final_fatura, 'Pendente');
    
  END IF;
END;
/




CREATE OR REPLACE FUNCTION M_FUNC_2021138219 (
  data_inicio IN DATE,
  data_fim IN DATE,
  tipo IN plano.tipo_plano%type
) RETURN NUMBER
IS
  total_contratos NUMBER;
  media NUMBER;
BEGIN
  SELECT COUNT(*) INTO total_contratos
  FROM contrato c
  INNER JOIN plano p ON c.cod_plano = p.cod_plano
  WHERE c.data_inicio >= data_inicio
    AND c.data_inicio <= data_fim
    AND p.tipo_plano = tipo
    AND p.estado = 'Ativo';

  SELECT round(total_contratos / MONTHS_BETWEEN(data_fim, data_inicio),4) INTO media
  FROM dual;

  RETURN media;
END;
/




CREATE OR REPLACE FUNCTION M_FUNC_2021155627(
    p_cod_plano IN NUMBER,
    p_data IN DATE
) RETURN NUMBER IS
    v_total_contratos NUMBER := 0;
    x NUMBER;
BEGIN
SELECT COUNT(*)into x FROM PLANO WHERE COD_PLANO = p_cod_plano;
 IF x = 0 THEN
 RAISE_APPLICATION_ERROR(-20516,'Plano inexistente.');
 END IF;
    SELECT COUNT(*) INTO v_total_contratos
    FROM CONTRATO
    WHERE COD_PLANO = p_cod_plano
        AND p_data BETWEEN DATA_INICIO AND NVL(DATA_FIM, SYSDATE);

    RETURN v_total_contratos;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/




CREATE OR REPLACE PROCEDURE N_PROC_2021138219(
    p_cod_contrato IN contrato.cod_contrato%TYPE,
    p_nova_data_fim IN contrato.data_fim%TYPE
)
IS
    v_cod_plano contrato.cod_plano%TYPE;
    v_qtd_tarifarios NUMBER;
BEGIN

    SELECT cod_plano
    INTO v_cod_plano
    FROM contrato
    WHERE cod_contrato = p_cod_contrato;


    SELECT COUNT(*)
    INTO v_qtd_tarifarios
    FROM tarifario
    WHERE cod_plano = v_cod_plano;


    IF v_cod_plano IS NOT NULL AND v_qtd_tarifarios > 0 THEN
        UPDATE contrato
        SET data_fim = p_nova_data_fim
        WHERE cod_contrato = p_cod_contrato;
        
        COMMIT;

    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20509,'Contrato inexistente.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20520,'Erro ao atualizar a data de fim do contrato');
END;
/




CREATE OR REPLACE PROCEDURE N_PROC_2021155627(
    p_meses_antigos IN NUMBER
) IS
    v_saldo_total NUMBER := 0;
    v_mes VARCHAR2(10);
BEGIN
    DELETE FROM saldos;

    FOR i IN 1..p_meses_antigos LOOP
        v_mes := TO_CHAR(ADD_MONTHS(SYSDATE, -i), 'MM/YYYY');

        SELECT SUM(SALDO) INTO v_saldo_total
        FROM CONTRATO
        WHERE EXTRACT(MONTH FROM DATA_INICIO) <= EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -i))
            AND (EXTRACT(MONTH FROM DATA_FIM) >= EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -i))
                 OR EXTRACT(MONTH FROM DATA_FIM) IS NULL)
            AND EXTRACT(YEAR FROM DATA_INICIO) <= EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -i))
            AND (EXTRACT(YEAR FROM DATA_FIM) >= EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -i))
                 OR EXTRACT(YEAR FROM DATA_FIM) IS NULL);

        INSERT INTO saldos (mes, saldo_total) VALUES (v_mes, NVL(v_saldo_total,0));
    END LOOP;
END;
/




CREATE OR REPLACE TRIGGER O_TRIG_2021138219
BEFORE INSERT ON contrato
FOR EACH ROW
DECLARE
    v_ultimo_cod_contrato contrato.cod_contrato%TYPE;
    v_ultimo_cod_cliente contrato.cod_cliente%TYPE;
BEGIN
 
    IF :NEW.data_inicio IS NULL THEN
        :NEW.data_inicio := SYSDATE;
    END IF;

    IF :NEW.cod_contrato IS NULL THEN
        SELECT MAX(cod_contrato) + 1 INTO v_ultimo_cod_contrato FROM contrato;
        :NEW.cod_contrato := v_ultimo_cod_contrato;
    END IF;
    
    IF :NEW.cod_cliente IS NULL THEN
        SELECT MAX(cod_cliente) + 1 INTO v_ultimo_cod_cliente FROM cliente;
        :NEW.cod_cliente := v_ultimo_cod_cliente;
    END IF;
    
    IF :NEW.saldo IS NULL THEN
        :NEW.saldo := 0;
    END IF;
    
    :NEW.motivo_final_contrato := NULL;
END;
/




CREATE OR REPLACE TRIGGER O_TRIG_2021155627 BEFORE
  INSERT ON INTERACAO FOR EACH ROW DECLARE v_prefixo NUMBER;
  v_nr_digitos             NUMBER;
  v_rede                   CHAR(32);
  v_nr_destino_normalizado NUMBER;
  x NUMBER;
  BEGIN
    v_nr_destino_normalizado := e_numero_normalizado(:NEW.NR_DESTINO);
    SELECT COUNT(NR_DESTINO)
    INTO x
    FROM CLASSIFICACAO
    WHERE NR_DESTINO = v_nr_destino_normalizado;
    IF x             = 0 THEN
      IF v_nr_destino_normalizado LIKE '3512%' THEN
        v_prefixo := TO_NUMBER(SUBSTR(v_nr_destino_normalizado, 1, 3));
        v_rede    := 'Fixo Nacional';
      ELSIF v_nr_destino_normalizado LIKE '3519%' THEN
        v_prefixo                                 := TO_NUMBER(SUBSTR(v_nr_destino_normalizado, 1, 3));
        v_rede                                    := 'Móvel Nacional';
      ELSIF SUBSTR(v_nr_destino_normalizado, 4, 1) = '2' THEN
        v_prefixo                                 := TO_NUMBER(SUBSTR(v_nr_destino_normalizado, 1, 3));
        v_rede                                    := 'Fixo Internacional';
      ELSIF SUBSTR(v_nr_destino_normalizado, 4, 1) = '9' THEN
        v_prefixo                                 := TO_NUMBER(SUBSTR(v_nr_destino_normalizado, 1, 3));
        v_rede                                    := 'Móvel Internacional';
      ELSE
        v_prefixo := TO_NUMBER(SUBSTR(v_nr_destino_normalizado, 1, 3));
        v_rede    := 'Gratuito';
      END IF;
      v_nr_digitos := LENGTH(v_nr_destino_normalizado);
      INSERT
      INTO CLASSIFICACAO
        (
          PREFIXO,
          NR_DIGITOS,
          REDE,
          NR_DESTINO
        )
        VALUES
        (
          v_prefixo,
          v_nr_digitos,
          v_rede,
          v_nr_destino_normalizado
        );
    END IF;
  END;
/
