INSERT
INTO PLANO
  (
    VALOR,
    DATA_LANCAMENTO,
    DESIGNACAO,
    ESTADO,
    TIPO_FATURACAO,
    COD_PLANO,
    TIPO_PLANO
  )
  VALUES
  (
    150,
    TO_DATE('04-21-2023', 'MM-DD-YYYY'),
    'Plano A',
    'Ativo',
    'Mensal',
    1,
    'POS PAGO PLAFOND'
  );
INSERT
INTO PLANO
  (
    VALOR,
    DATA_LANCAMENTO,
    DESIGNACAO,
    ESTADO,
    TIPO_FATURACAO,
    COD_PLANO,
    TIPO_PLANO
  )
  VALUES
  (
    300,
    TO_DATE('05-01-2023', 'MM-DD-YYYY'),
    'Plano B',
    'Inativo',
    'Anual',
    2,
    'POS PAGO SIMPLES'
  );
INSERT
INTO PLANO
  (
    VALOR,
    DATA_LANCAMENTO,
    DESIGNACAO,
    ESTADO,
    TIPO_FATURACAO,
    COD_PLANO,
    TIPO_PLANO
  )
  VALUES
  (
    250,
    TO_DATE('06-15-2023', 'MM-DD-YYYY'),
    'Plano C',
    'Ativo',
    'Trimestral',
    3,
    'PRE PAGO'
  );
INSERT
INTO PLANO
  (
    VALOR,
    DATA_LANCAMENTO,
    DESIGNACAO,
    ESTADO,
    TIPO_FATURACAO,
    COD_PLANO,
    TIPO_PLANO
  )
  VALUES
  (
    175,
    TO_DATE('07-04-2023', 'MM-DD-YYYY'),
    'Plano D',
    'Ativo',
    'Mensal',
    4,
    'POS PAGO PLAFOND'
  );
INSERT
INTO PLANO
  (
    VALOR,
    DATA_LANCAMENTO,
    DESIGNACAO,
    ESTADO,
    TIPO_FATURACAO,
    COD_PLANO,
    TIPO_PLANO
  )
  VALUES
  (
    225,
    TO_DATE('08-10-2023', 'MM-DD-YYYY'),
    'Plano E',
    'Inativo',
    'Anual',
    5,
    'POS PAGO SIMPLES'
  );
INSERT
INTO PLANO_POS_PAGO_PLAFOND
  (
    COD_PLANO,
    MINUTOS,
    SMS
  )
  VALUES
  (
    1,
    500,
    1000
  );
INSERT
INTO PLANO_POS_PAGO_PLAFOND
  (
    COD_PLANO,
    MINUTOS,
    SMS
  )
  VALUES
  (
    4,
    250,
    750
  );
INSERT INTO PLANO_POS_PAGO_SIMPLES
  (COD_PLANO
  ) VALUES
  (2
  );
INSERT INTO PLANO_POS_PAGO_SIMPLES
  (COD_PLANO
  ) VALUES
  (5
  );
INSERT
INTO PLANO_PRE_PAGO
  (
    COD_PLANO,
    NR_DIAS,
    MINUTOS,
    SMS
  )
  VALUES
  (
    3,
    30,
    600,
    1100
  );
INSERT
INTO CLIENTE
  (
    COD_CLIENTE,
    DATA_NASCIMENTO,
    PAIS_ORIGEM,
    CONTRIBUINTE,
    MAIL,
    ESTADO_CONTRATO,
    NOME
  )
  VALUES
  (
    1,
    TO_DATE('10-12-2003', 'MM-DD-YYYY'),
    'Portugal',
    276760769,
    'carpinto96@gmail.com',
    'Ativo',
    'Carlos Pinto'
  );
INSERT
INTO CLIENTE
  (
    COD_CLIENTE,
    DATA_NASCIMENTO,
    PAIS_ORIGEM,
    CONTRIBUINTE,
    MAIL,
    ESTADO_CONTRATO,
    NOME
  )
  VALUES
  (
    2,
    TO_DATE('12-31-2003', 'MM-DD-YYYY'),
    'Líbano',
    987654321,
    'alx_fra@gmail.com',
    'Inativo',
    'Alexandre Ferreira'
  );
INSERT
INTO CLIENTE
  (
    COD_CLIENTE,
    DATA_NASCIMENTO,
    PAIS_ORIGEM,
    CONTRIBUINTE,
    MAIL,
    ESTADO_CONTRATO,
    NOME
  )
  VALUES
  (
    3,
    TO_DATE('06-22-2002', 'MM-DD-YYYY'),
    'Palau',
    123789456,
    'vitorf@gmail.com',
    'Ativo',
    'Vitor Fernandes'
  );
INSERT
INTO CAMPANHA
  (
    COD_CAMPANHA,
    NUM_MAX_AMIGOS,
    DESIGNACAO,
    DATA_INICIO,
    DATA_FIM,
    DESCONTO_SMS,
    DESCONTO_VOZ,
    ESTADO,
    DATA_ADESAO
  )
  VALUES
  (
    1,
    5,
    'Campanha 5 amigos Ver o 2022',
    TO_DATE('06-21-2022', 'MM-DD-YYYY'),
    TO_DATE('09-23-2022', 'MM-DD-YYYY'),
    50,
    30,
    'Inativa',
    NULL
  );
INSERT
INTO CAMPANHA
  (
    COD_CAMPANHA,
    NUM_MAX_AMIGOS,
    DESIGNACAO,
    DATA_INICIO,
    DATA_FIM,
    DESCONTO_SMS,
    DESCONTO_VOZ,
    ESTADO,
    DATA_ADESAO
  )
  VALUES
  (
    2,
    10,
    'Campanha 10 Amigos Natal 2022',
    TO_DATE('12-01-2022', 'MM-DD-YYYY'),
    TO_DATE('12-31-2022', 'MM-DD-YYYY'),
    40,
    20,
    'Inativa',
    TO_DATE('12-15-2022', 'MM-DD-YYYY')
  );
INSERT
INTO CAMPANHA
  (
    COD_CAMPANHA,
    NUM_MAX_AMIGOS,
    DESIGNACAO,
    DATA_INICIO,
    DATA_FIM,
    DESCONTO_SMS,
    DESCONTO_VOZ,
    ESTADO,
    DATA_ADESAO
  )
  VALUES
  (
    3,
    3,
    'Campanha 3 Amigos',
    TO_DATE('01-01-2023', 'MM-DD-YYYY'),
    TO_DATE('01-07-2023', 'MM-DD-YYYY'),
    20,
    10,
    'Ativa',
    NULL
  );
INSERT
INTO CONTRATO
  (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    MOTIVO_FINAL_CONTRATO,
    SALDO,
    COD_CONTRATO
  )
  VALUES
  (
    910768445,
    1,
    1,
    'Disponivel',
    TO_DATE('01-01-2022', 'MM-DD-YYYY'),
    NULL,
    6,
    NULL,
    100,1
  );
INSERT
INTO CONTRATO
  (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    MOTIVO_FINAL_CONTRATO,
    SALDO,
    COD_CONTRATO
  )
  VALUES
  (
    911884658,
    2,
    2,
    'Disponivel',
    TO_DATE('03-12-2022', 'MM-DD-YYYY'),
    NULL,
    12,
    NULL,
    50,2
  );
INSERT
INTO CONTRATO
  (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    MOTIVO_FINAL_CONTRATO,
    SALDO,
    COD_CONTRATO
  )
  VALUES
  (
    910546371,
    3,
    1,
    'Inexistente',
    TO_DATE('04-24-2022', 'MM-DD-YYYY'),
    TO_DATE('12-31-2022', 'MM-DD-YYYY'),
    24,
    'Mudança Plano',
    0,3
  );
INSERT
INTO CONTRATO
  (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    MOTIVO_FINAL_CONTRATO,
    SALDO,
    COD_CONTRATO
  )
  VALUES
  (
    910546372,
    3,
    3,
    'Ocupado',
    TO_DATE('01-01-2023', 'MM-DD-YYYY'),
    NULL,
    12,
    NULL,
    120,4
  );
INSERT
INTO CONTRATO
  (
    NR_TELEMOVEL,
    COD_CLIENTE,
    COD_PLANO,
    ESTADO_NUMERO,
    DATA_INICIO,
    DATA_FIM,
    PERIODO_FIDELIZACAO,
    MOTIVO_FINAL_CONTRATO,
    SALDO,
    COD_CONTRATO
  )
  VALUES
  (
    911884659,
    2,
    3,
    'Desligado',
    TO_DATE('07-22-2022', 'MM-DD-YYYY'),
    NULL,
    12,
    NULL,
    120,5
  );

INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    1,
    1
  );
INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    2,
    1
  );
INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    3,
    1
  );
INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    1,
    2
  );
INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    3,
    2
  );
INSERT
INTO RELATIONSHIP_12
  (
    COD_CAMPANHA,
    COD_CONTRATO
  )
  VALUES
  (
    2,
    4
  );
INSERT INTO AMIGO
  (NUMERO, NOME
  ) VALUES
  (946785329, 'Guilherme Correia'
  );
INSERT INTO AMIGO
  (NUMERO, NOME
  ) VALUES
  (967845362, 'Duarte Marques'
  );
INSERT INTO AMIGO
  (NUMERO, NOME
  ) VALUES
  (916432525, 'Carolina Rodrigues'
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (1, 946785329
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (1, 967845362
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (2, 946785329
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (2, 967845362
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (3, 967845362
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (2, 916432525
  );
INSERT INTO RELATIONSHIP_5
  (COD_CAMPANHA, NUMERO
  ) VALUES
  (1, 916432525
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    916432525,
    1
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    946785329,
    1
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    967845362,
    1
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    946785329,
    2
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    967845362,
    2
  );
INSERT
INTO RELATIONSHIP_13
  (
    NUMERO,
    COD_CONTRATO
  )
  VALUES
  (
    967845362,
    4
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('04-20-2023', 'MM-DD-YYYY'),
    4,
    1,
    20.00,
    NULL,
    20.00
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('04-22-2023', 'MM-DD-YYYY'),
    5,
    1,
    20.00,
    30.00,
    50.00
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('04-23-2023', 'MM-DD-YYYY'),
    6,
    1,
    15.00,
    50.00,
    65.00
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('03-13-2022', 'MM-DD-YYYY'),
    1,
    2,
    100.00,
    NULL,
    100.00
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('03-13-2023', 'MM-DD-YYYY'),
    3,
    2,
    100.00,
    100.00,
    200.00
  );
INSERT
INTO CARREGAMENTO
  (
    DATA_CARREGAMENTO,
    COD_CARREGAMENTO,
    COD_CONTRATO,
    MONTANTE,
    SALDO_ANTERIOR,
    SALDO_ATUALIZADO
  )
  VALUES
  (
    TO_DATE('01-01-2023', 'MM-DD-YYYY'),
    2,
    4,
    300.00,
    NULL,
    300.00
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    1,
    1,
    25.50,
    to_date('01-01-2022', 'MM-DD-YYYY'),
    to_date('01-31-2022', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    2,
    2,
    10.20,
    to_date('03-12-2022', 'MM-DD-YYYY'),
    to_date('04-12-2022', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    3,
    4,
    18.70,
    to_date('04-21-2023', 'MM-DD-YYYY'),
    to_date('05-21-2023', 'MM-DD-YYYY'),
    'PENDENTE'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    5,
    1,
    8.99,
    to_date('04-01-2023', 'MM-DD-YYYY'),
    to_date('04-30-2023', 'MM-DD-YYYY'),
    'PENDENTE'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    4,
    2,
    15.99,
    to_date('04-01-2023', 'MM-DD-YYYY'),
    to_date('04-30-2023', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    6,
    1,
    24.99,
    to_date('12-01-2022', 'MM-DD-YYYY'),
    to_date('12-31-2022', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    7,
    2,
    12.99,
    to_date('01-01-2023', 'MM-DD-YYYY'),
    to_date('01-31-2023', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO FATURA
  (
    COD_FATURA,
    COD_CONTRATO,
    MONTANTE,
    DATA_INICIO,
    DATA_FINAL,
    ESTADO
  )
  VALUES
  (
    8,
    4,
    19.99,
    to_date('01-01-2023', 'MM-DD-YYYY'),
    to_date('01-31-2023', 'MM-DD-YYYY'),
    'PAGO'
  );
INSERT
INTO PACOTE
  (
    COD_PACOTE,
    DATA_LANCAMENTO,
    TIPO,
    QUANTIDADE,
    REDE,
    UNIDADE,
    PERIODO,
    DESIGNACAO,
    ESTADO,
    PRECO
  )
  VALUES
  (
    1,
    TO_DATE('04-21-2023', 'MM-DD-YYYY'),
    'voz',
    500,
    'Vodafone',
    'Minuto',
    15,
    'Pacote Voz 500 Minutos',
    'Ativo',
    30.00
  );
INSERT
INTO PACOTE
  (
    COD_PACOTE,
    DATA_LANCAMENTO,
    TIPO,
    QUANTIDADE,
    REDE,
    UNIDADE,
    PERIODO,
    DESIGNACAO,
    ESTADO,
    PRECO
  )
  VALUES
  (
    2,
    TO_DATE('04-21-2023', 'MM-DD-YYYY'),
    'sms',
    1000,
    'NOS',
    'SMS',
    30,
    'Pacote SMS 1000 Mensagens',
    'Ativo',
    10.00
  );
INSERT
INTO PACOTE
  (
    COD_PACOTE,
    DATA_LANCAMENTO,
    TIPO,
    QUANTIDADE,
    REDE,
    UNIDADE,
    PERIODO,
    DESIGNACAO,
    ESTADO,
    PRECO
  )
  VALUES
  (
    3,
    TO_DATE('04-21-2023', 'MM-DD-YYYY'),
    'voz',
    1000,
    'MEO',
    'Minuto',
    60,
    'Pacote Voz 1000 Minutos',
    'Ativo',
    50.00
  );
INSERT INTO RELATIONSHIP_3
  (COD_CONTRATO,COD_PACOTE
  ) VALUES
  (1,2
  );
INSERT INTO RELATIONSHIP_3
  (COD_CONTRATO,COD_PACOTE
  ) VALUES
  (2,3
  );
INSERT INTO RELATIONSHIP_3
  (COD_CONTRATO,COD_PACOTE
  ) VALUES
  (4,1
  );
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
    351,
    9,
    'Fixo Nacional',
    212345678
  );
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
    351,
    9,
    'Móvel Nacional',
    912345678
  );
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
    33,
    10,
    'Fixo Internacional',
    3312345678
  );
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
    33,
    10,
    'Móvel Internacional',
    33612345678
  );
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
    351,
    9,
    'Fixo Nacional',
    214567890
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    1,
    1,
    'SMS',
    TO_DATE('01-31-2022', 'MM-DD-YYYY'),
    0.1,
    'Tarifário SMS',
    'Móvel Nacional',
    'SMS',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    2,
    1,
    'Voz',
    TO_DATE('12-31-2021', 'MM-DD-YYYY'),
    0.2,
    'Tarifário Voz',
    'Fixo Nacional',
    'Minuto',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    3,
    2,
    'SMS',
    TO_DATE('08-11-2022', 'MM-DD-YYYY'),
    0.05,
    'Tarifário SMS',
    'Internacional',
    'SMS',
    'Inativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    4,
    2,
    'Voz',
    TO_DATE('01-01-2023', 'MM-DD-YYYY'),
    0.4,
    'Tarifário Voz',
    'Móvel Nacional',
    'Minuto',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    5,
    3,
    'Voz',
    TO_DATE('04-22-2022', 'MM-DD-YYYY'),
    0.8,
    'Tarifário Voz',
    'Fixo Internacional',
    'Minuto',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    6,
    4,
    'SMS',
    TO_DATE('06-17-2022', 'MM-DD-YYYY'),
    0.08,
    'SMS internacional',
    'Móvel internacional',
    'SMS',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    7,
    4,
    'Voz',
    TO_DATE('12-15-2022', 'MM-DD-YYYY'),
    0.20,
    'Voz internacional',
    'Móvel internacional',
    'Minuto',
    'Ativo'
  );
INSERT
INTO TARIFARIO
  (
    COD_TARIFARIO,
    COD_PLANO,
    TIPO,
    DATA_LANCAMENTO,
    PRECO_UNIDADE,
    DESIGNACAO,
    REDE,
    UNIDADE,
    ESTADO
  )
  VALUES
  (
    8,
    5,
    'SMS',
    TO_DATE('02-10-2022', 'MM-DD-YYYY'),
    0.09,
    'SMS nacional',
    'Fixo nacional',
    'SMS',
    'Ativo'
  );
---------eventos---------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    1,
    NULL,
    212345678,
    1,
    to_date('03-15-2023 10:30:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 1, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-15-2023 10:30:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    1,
    1
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-15-2023 10:31:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Atendida',
    2,
    1
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-15-2023 10:46:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Terminada',
    3,
    1
  );
INSERT
INTO INTERACOES_FATURAVEIS
  (
    CUSTO,
    TIPO_INTERACAO,
    COD_FATURAVEL,
    COD_INTERACAO,
    COD_FATURA,
    DURACAO
  )
  VALUES
  (
    3.2,
    'Chamada',
    1,
    1,
    1,
    16
  );
UPDATE INTERACAO
SET COD_FATURAVEL   = 1,
  ESTADO            = 'Terminada'
WHERE COD_INTERACAO = 1;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('03-15-2023 10:46:00', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 1;
-------------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    2,
    NULL,
    912345678,
    2,
    to_date('04-16-2023 12:15:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 2, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-16-2023 12:15:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    4,
    2
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-16-2023 12:20:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Nao atendida',
    5,
    2
  );
UPDATE INTERACAO SET ESTADO = 'Nao atendida' WHERE COD_INTERACAO = 2;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('04-16-2023 12:20:00', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 2;
---------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    3,
    NULL,
    214567890,
    4,
    to_date('03-18-2023 16:40:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 3, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-18-2023 16:40:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    6,
    3
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-18-2023 16:40:10', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado',
    7,
    3
  );
UPDATE INTERACAO SET ESTADO = 'Ocupado' WHERE COD_INTERACAO = 3;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('03-18-2023 16:40:10', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 3;
-----------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    4,
    NULL,
    3312345678,
    1,
    to_date('03-21-2023 09:20:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 4, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-21-2023 09:20:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    8,
    4
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-21-2023 09:20:10', 'MM-DD-YYYY HH24:MI:SS'),
    'Desligado',
    9,
    4
  );
UPDATE INTERACAO SET ESTADO = 'Desligado' WHERE COD_INTERACAO = 4;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('03-21-2023 09:20:10', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 4;
-----------------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    5,
    NULL,
    33612345678,
    2,
    to_date('04-22-2023 14:35:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Enviada'
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-22-2023 14:35:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Enviada',
    10,
    5
  );
INSERT INTO SMS
  ( COD_INTERACAO, MENSAGEM
  ) VALUES
  ( 5, 'Ola :)'
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-22-2023 14:35:05', 'MM-DD-YYYY HH24:MI:SS'),
    'Entregue',
    11,
    5
  );
INSERT
INTO INTERACOES_FATURAVEIS
  (
    CUSTO,
    TIPO_INTERACAO,
    COD_FATURAVEL,
    COD_INTERACAO,
    COD_FATURA,
    DURACAO
  )
  VALUES
  (
    0.05,
    'SMS',
    2,
    5,
    2,
    NULL
  );
UPDATE INTERACAO
SET COD_FATURAVEL   = 2,
  ESTADO            = 'Entregue'
WHERE COD_INTERACAO = 5;
-----------------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    6,
    NULL,
    212345678,
    4,
    to_date('03-23-2023 08:50:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Enviada'
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-23-2023 08:50:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Enviada',
    12,
    6
  );
INSERT INTO SMS
  ( COD_INTERACAO, MENSAGEM
  ) VALUES
  ( 6, 'Como est s?'
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-23-2023 08:50:05', 'MM-DD-YYYY HH24:MI:SS'),
    'Nao Entregue',
    13,
    6
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-23-2023 08:50:10', 'MM-DD-YYYY HH24:MI:SS'),
    'Terminada',
    14,
    6
  );
UPDATE INTERACAO SET ESTADO = 'Terminada' WHERE COD_INTERACAO = 6;
----------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    7,
    NULL,
    912345678,
    2,
    to_date('04-20-2023 11:10:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 7, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-20-2023 11:10:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    15,
    7
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('04-20-2023 11:11:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Nao atendida',
    16,
    7
  );
UPDATE INTERACAO SET ESTADO = 'Nao atendida' WHERE COD_INTERACAO = 7;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('04-20-2023 11:11:00', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 7;
-------------------
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    8,
    NULL,
    33612345678,
    1,
    to_date('03-25-2023 15:25:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada'
  );
INSERT INTO CHAMADA
  ( COD_INTERACAO, INSTANTE_FINAL
  ) VALUES
  ( 8, NULL
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-25-2023 15:25:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Iniciada',
    17,
    8
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-25-2023 15:25:30', 'MM-DD-YYYY HH24:MI:SS'),
    'Atendida',
    18,
    8
  );
INSERT
INTO EVENTOS
  (
    INSTANTE,
    ESTADO,
    COD_EVENTO,
    COD_INTERACAO
  )
  VALUES
  (
    TO_DATE('03-25-2023 15:30:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Terminada',
    19,
    8
  );
INSERT
INTO INTERACOES_FATURAVEIS
  (
    CUSTO,
    TIPO_INTERACAO,
    COD_FATURAVEL,
    COD_INTERACAO,
    COD_FATURA,
    DURACAO
  )
  VALUES
  (
    1,
    'Chamada',
    3,
    8,
    3,
    5
  );
UPDATE INTERACAO
SET COD_FATURAVEL   = 3,
  ESTADO            = 'Terminada'
WHERE COD_INTERACAO = 8;
UPDATE CHAMADA
SET INSTANTE_FINAL  = TO_DATE('03-25-2023 15:30:00', 'MM-DD-YYYY HH24:MI:SS')
WHERE COD_INTERACAO = 8;
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    9,
    NULL,
    212345678,1,
    to_date('01-02-2022 12:00:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  ) ;
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    10,
    NULL,
    212345678,1,
    to_date('01-02-2022 12:05:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  );
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    11,
    NULL,
    212345678,1,
    to_date('01-02-2022 12:10:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  );
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    12,
    NULL,
    212345678,1,
    to_date('01-02-2022 12:15:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  );
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    13,
    NULL,
    212345678,1,
    to_date('01-02-2022 12:30:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  );
INSERT
INTO INTERACAO
  (
    COD_INTERACAO,
    COD_FATURAVEL,
    NR_DESTINO,
    COD_CONTRATO,
    INSTANTE_INICIAL,
    ESTADO
  )
  VALUES
  (
    14,
    NULL,
    212345678,1,
    to_date('01-02-2022 13:30:00', 'MM-DD-YYYY HH24:MI:SS'),
    'Ocupado'
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    9,
    to_date('01-02-2022 12:00:05', 'MM-DD-YYYY HH24:MI:SS')
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    10,
    to_date('01-02-2022 12:05:05', 'MM-DD-YYYY HH24:MI:SS')
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    11,
    to_date('01-02-2022 12:10:05', 'MM-DD-YYYY HH24:MI:SS')
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    12,
    to_date('01-02-2022 12:15:05', 'MM-DD-YYYY HH24:MI:SS')
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    13,
    to_date('01-02-2022 12:30:05', 'MM-DD-YYYY HH24:MI:SS')
  );
INSERT
INTO CHAMADA
  (
    COD_INTERACAO,
    INSTANTE_FINAL
  )
  VALUES
  (
    14,
    to_date('01-02-2022 13:30:05', 'MM-DD-YYYY HH24:MI:SS')
  );
COMMIT;
