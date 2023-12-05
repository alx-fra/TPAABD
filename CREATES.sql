/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     10/05/2023 11:42:02                          */
/*==============================================================*/


alter table CARREGAMENTO
   drop constraint FK_CARREGAM_RELATIONS_CONTRATO;

alter table CHAMADA
   drop constraint FK_CHAMADA_INHERITAN_INTERACA;

alter table CONTRATO
   drop constraint FK_CONTRATO_RELATIONS_CLIENTE;

alter table CONTRATO
   drop constraint FK_CONTRATO_RELATIONS_PLANO;

alter table EVENTOS
   drop constraint FK_EVENTOS_RELATIONS_INTERACA;

alter table FATURA
   drop constraint FK_FATURA_RELATIONS_CONTRATO;

alter table INTERACAO
   drop constraint FK_INTERACA_RELATIONS_CLASSIFI;

alter table INTERACAO
   drop constraint FK_INTERACA_RELATIONS_INTERACO;

alter table INTERACAO
   drop constraint FK_INTERACA_RELATIONS_CONTRATO;

alter table INTERACOES_FATURAVEIS
   drop constraint FK_INTERACO_RELATIONS_FATURA;

alter table INTERACOES_FATURAVEIS
   drop constraint FK_INTERACO_RELATIONS_INTERACA;

alter table PLANO_POS_PAGO_PLAFOND
   drop constraint FK_PLANO_PO_INHERITAN_PLANO2;

alter table PLANO_POS_PAGO_SIMPLES
   drop constraint FK_PLANO_PO_INHERITAN_PLANO;

alter table PLANO_PRE_PAGO
   drop constraint FK_PLANO_PR_INHERITAN_PLANO;

alter table RELATIONSHIP_12
   drop constraint FK_RELATION_RELATIONS_CAMPANHA;

alter table RELATIONSHIP_12
   drop constraint FK_RELATION_RELATIONS_CONTRAT3;

alter table RELATIONSHIP_13
   drop constraint FK_RELATION_RELATIONS_AMIGO;

alter table RELATIONSHIP_13
   drop constraint FK_RELATION_RELATIONS_CONTRATO;

alter table RELATIONSHIP_3
   drop constraint FK_RELATION_RELATIONS_CONTRAT2;

alter table RELATIONSHIP_3
   drop constraint FK_RELATION_RELATIONS_PACOTE;

alter table RELATIONSHIP_5
   drop constraint FK_RELATION_RELATIONS_CAMPANH2;

alter table RELATIONSHIP_5
   drop constraint FK_RELATION_RELATIONS_AMIGO2;

alter table SMS
   drop constraint FK_SMS_INHERITAN_INTERACA;

alter table TARIFARIO
   drop constraint FK_TARIFARI_RELATIONS_PLANO;

drop table AMIGO cascade constraints;

drop table CAMPANHA cascade constraints;

drop index RELATIONSHIP_10_FK;

drop table CARREGAMENTO cascade constraints;

drop table CHAMADA cascade constraints;

drop table CLASSIFICACAO cascade constraints;

drop table CLIENTE cascade constraints;

drop index RELATIONSHIP_20_FK;

drop index RELATIONSHIP_1_FK;

drop table CONTRATO cascade constraints;

drop index RELATIONSHIP_9_FK;

drop table EVENTOS cascade constraints;

drop index RELATIONSHIP_11_FK;

drop table FATURA cascade constraints;

drop index RELATIONSHIP_18_FK;

drop index RELATIONSHIP_12_FK;

drop index RELATIONSHIP_8_FK;

drop table INTERACAO cascade constraints;

drop index RELATIONSHIP_19_FK;

drop index RELATIONSHIP_17_FK;

drop table INTERACOES_FATURAVEIS cascade constraints;

drop table PACOTE cascade constraints;

drop table PLANO cascade constraints;

drop table PLANO_POS_PAGO_PLAFOND cascade constraints;

drop table PLANO_POS_PAGO_SIMPLES cascade constraints;

drop table PLANO_PRE_PAGO cascade constraints;

drop index RELATIONSHIP_14_FK;

drop index RELATIONSHIP_13_FK;

drop table RELATIONSHIP_12 cascade constraints;

drop index RELATIONSHIP_16_FK;

drop index RELATIONSHIP_15_FK;

drop table RELATIONSHIP_13 cascade constraints;

drop index RELATIONSHIP_4_FK;
drop table saldos;
drop index RELATIONSHIP_3_FK;

drop table RELATIONSHIP_3 cascade constraints;

drop index RELATIONSHIP_7_FK;

drop index RELATIONSHIP_6_FK;

drop table RELATIONSHIP_5 cascade constraints;

drop table SMS cascade constraints;

drop index RELATIONSHIP_5_FK;

drop table TARIFARIO cascade constraints;

/*==============================================================*/
/* Table: AMIGO                                                 */
/*==============================================================*/
create table AMIGO 
(
   NUMERO               NUMBER               not null,
   NOME                 CHAR(64)             not null,
   constraint PK_AMIGO primary key (NUMERO)
);

/*==============================================================*/
/* Table: CAMPANHA                                              */
/*==============================================================*/
create table CAMPANHA 
(
   COD_CAMPANHA         NUMBER               not null,
   NUM_MAX_AMIGOS       NUMBER               not null,
   DESIGNACAO           CHAR(32)             not null,
   DATA_INICIO          DATE                 not null,
   DATA_FIM             DATE                 not null,
   DESCONTO_SMS         NUMBER               not null,
   DESCONTO_VOZ         NUMBER               not null,
   ESTADO               CHAR(16)             not null,
   DATA_ADESAO          DATE,
   constraint PK_CAMPANHA primary key (COD_CAMPANHA)
);

/*==============================================================*/
/* Table: CARREGAMENTO                                          */
/*==============================================================*/
create table CARREGAMENTO 
(
   DATA_CARREGAMENTO    DATE                 not null,
   COD_CARREGAMENTO     NUMBER               not null,
   COD_CONTRATO         CHAR(10)             not null,
   MONTANTE             NUMBER               not null,
   SALDO_ANTERIOR       NUMBER,
   SALDO_ATUALIZADO     NUMBER               not null,
   constraint PK_CARREGAMENTO primary key (COD_CARREGAMENTO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_10_FK on CARREGAMENTO (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Table: CHAMADA                                               */
/*==============================================================*/
create table CHAMADA 
(
   COD_INTERACAO        NUMBER               not null,
   INSTANTE_FINAL       DATE,
   constraint PK_CHAMADA primary key (COD_INTERACAO)
);

/*==============================================================*/
/* Table: CLASSIFICACAO                                         */
/*==============================================================*/
create table CLASSIFICACAO 
(
   PREFIXO              NUMBER               not null,
   NR_DIGITOS           NUMBER               not null,
   REDE                 CHAR(32)             not null,
   NR_DESTINO           NUMBER               not null,
   constraint PK_CLASSIFICACAO primary key (NR_DESTINO)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   COD_CLIENTE          NUMBER               not null,
   DATA_NASCIMENTO      DATE                 not null,
   PAIS_ORIGEM          CHAR(64)             not null,
   CONTRIBUINTE         NUMBER               not null,
   MAIL                 CHAR(64),
   ESTADO_CONTRATO      CHAR(8)              not null,
   NOME                 CHAR(64)             not null,
   constraint PK_CLIENTE primary key (COD_CLIENTE)
);

/*==============================================================*/
/* Table: CONTRATO                                              */
/*==============================================================*/
create table CONTRATO 
(
   NR_TELEMOVEL         NUMBER               not null,
   ESTADO_NUMERO        CHAR(16)             not null,
   DATA_INICIO          DATE                 not null,
   DATA_FIM             DATE,
   PERIODO_FIDELIZACAO  NUMBER               not null,
   MOTIVO_FINAL_CONTRATO CHAR(256),
   SALDO                NUMBER               not null,
   COD_CONTRATO         CHAR(10)             not null,
   COD_CLIENTE          NUMBER               not null,
   COD_PLANO            NUMBER,
   constraint PK_CONTRATO primary key (COD_CONTRATO)
);
    CREATE TABLE saldos (mes VARCHAR2(20), saldo_total NUMBER);


/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on CONTRATO (
   COD_CLIENTE ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_20_FK on CONTRATO (
   COD_PLANO ASC
);

/*==============================================================*/
/* Table: EVENTOS                                               */
/*==============================================================*/
create table EVENTOS 
(
   INSTANTE             DATE                 not null,
   ESTADO               CHAR(16)             not null,
   COD_EVENTO           NUMBER               not null,
   COD_INTERACAO        NUMBER               not null,
   constraint PK_EVENTOS primary key (COD_EVENTO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_9_FK on EVENTOS (
   COD_INTERACAO ASC
);

/*==============================================================*/
/* Table: FATURA                                                */
/*==============================================================*/
create table FATURA 
(
   COD_FATURA           NUMBER               not null,
   COD_CONTRATO         CHAR(10)             not null,
   MONTANTE             NUMBER               not null,
   DATA_INICIO          DATE                 not null,
   DATA_FINAL           DATE                 not null,
   ESTADO               CHAR(16)             not null,
   constraint PK_FATURA primary key (COD_FATURA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_11_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_11_FK on FATURA (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Table: INTERACAO                                             */
/*==============================================================*/
create table INTERACAO 
(
   COD_INTERACAO        NUMBER               not null,
   COD_FATURAVEL        NUMBER,
   NR_DESTINO           NUMBER,
   COD_CONTRATO         CHAR(10)             not null,
   INSTANTE_INICIAL     DATE                 not null,
   ESTADO               CHAR(16)             not null,
   constraint PK_INTERACAO primary key (COD_INTERACAO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_8_FK on INTERACAO (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on INTERACAO (
   NR_DESTINO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_18_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_18_FK on INTERACAO (
   COD_FATURAVEL ASC
);

/*==============================================================*/
/* Table: INTERACOES_FATURAVEIS                                 */
/*==============================================================*/
create table INTERACOES_FATURAVEIS 
(
   CUSTO                NUMBER               not null,
   TIPO_INTERACAO       CHAR(8)              not null,
   COD_FATURAVEL        NUMBER               not null,
   COD_INTERACAO        NUMBER               not null,
   COD_FATURA           NUMBER,
   DURACAO           NUMBER,
   constraint PK_INTERACOES_FATURAVEIS primary key (COD_FATURAVEL)
);

/*==============================================================*/
/* Index: RELATIONSHIP_17_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_17_FK on INTERACOES_FATURAVEIS (
   COD_FATURA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_19_FK on INTERACOES_FATURAVEIS (
   COD_INTERACAO ASC
);

/*==============================================================*/
/* Table: PACOTE                                                */
/*==============================================================*/
create table PACOTE 
(
   COD_PACOTE           NUMBER               not null,
   DATA_LANCAMENTO      DATE                 not null,
   TIPO                 CHAR(4)              not null,
   QUANTIDADE           NUMBER               not null,
   REDE                 CHAR(32)             not null,
   UNIDADE              CHAR(16)             not null,
   PERIODO              NUMBER               not null,
   DESIGNACAO           CHAR(32)             not null,
   ESTADO               CHAR(16)             not null,
   PRECO                NUMBER               not null,
   constraint PK_PACOTE primary key (COD_PACOTE)
);

/*==============================================================*/
/* Table: PLANO                                                 */
/*==============================================================*/
create table PLANO 
(
   VALOR                NUMBER               not null,
   DATA_LANCAMENTO      DATE                 not null,
   DESIGNACAO           CHAR(32)             not null,
   ESTADO               CHAR(16)             not null,
   TIPO_FATURACAO       CHAR(16)             not null,
   COD_PLANO            NUMBER               not null,
   TIPO_PLANO           CHAR(32),
   constraint PK_PLANO primary key (COD_PLANO)
);

/*==============================================================*/
/* Table: PLANO_POS_PAGO_PLAFOND                                */
/*==============================================================*/
create table PLANO_POS_PAGO_PLAFOND 
(
   COD_PLANO            NUMBER               not null,
   MINUTOS              NUMBER               not null,
   SMS                  NUMBER               not null,
   constraint PK_PLANO_POS_PAGO_PLAFOND primary key (COD_PLANO)
);

/*==============================================================*/
/* Table: PLANO_POS_PAGO_SIMPLES                                */
/*==============================================================*/
create table PLANO_POS_PAGO_SIMPLES 
(
   COD_PLANO            NUMBER               not null,
   constraint PK_PLANO_POS_PAGO_SIMPLES primary key (COD_PLANO)
);

/*==============================================================*/
/* Table: PLANO_PRE_PAGO                                        */
/*==============================================================*/
create table PLANO_PRE_PAGO 
(
   COD_PLANO            NUMBER               not null,
   NR_DIAS              NUMBER               not null,
   MINUTOS              NUMBER,
   SMS                  NUMBER,
   constraint PK_PLANO_PRE_PAGO primary key (COD_PLANO)
);

/*==============================================================*/
/* Table: RELATIONSHIP_12                                       */
/*==============================================================*/
create table RELATIONSHIP_12 
(
   COD_CAMPANHA         NUMBER               not null,
   COD_CONTRATO         CHAR(10)             not null,
   constraint PK_RELATIONSHIP_12 primary key (COD_CAMPANHA, COD_CONTRATO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_13_FK on RELATIONSHIP_12 (
   COD_CAMPANHA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_14_FK on RELATIONSHIP_12 (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Table: RELATIONSHIP_13                                       */
/*==============================================================*/
create table RELATIONSHIP_13 
(
   NUMERO               NUMBER               not null,
   COD_CONTRATO         CHAR(10)             not null,
   constraint PK_RELATIONSHIP_13 primary key (NUMERO, COD_CONTRATO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_15_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_15_FK on RELATIONSHIP_13 (
   NUMERO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_16_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_16_FK on RELATIONSHIP_13 (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Table: RELATIONSHIP_3                                        */
/*==============================================================*/
create table RELATIONSHIP_3 
(
   COD_CONTRATO         CHAR(10)             not null,
   COD_PACOTE           NUMBER               not null,
   constraint PK_RELATIONSHIP_3 primary key (COD_CONTRATO, COD_PACOTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on RELATIONSHIP_3 (
   COD_CONTRATO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on RELATIONSHIP_3 (
   COD_PACOTE ASC
);

/*==============================================================*/
/* Table: RELATIONSHIP_5                                        */
/*==============================================================*/
create table RELATIONSHIP_5 
(
   COD_CAMPANHA         NUMBER               not null,
   NUMERO               NUMBER               not null,
   constraint PK_RELATIONSHIP_5 primary key (COD_CAMPANHA, NUMERO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on RELATIONSHIP_5 (
   COD_CAMPANHA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_7_FK on RELATIONSHIP_5 (
   NUMERO ASC
);

/*==============================================================*/
/* Table: SMS                                                   */
/*==============================================================*/
create table SMS 
(
   COD_INTERACAO        NUMBER               not null,
   MENSAGEM             CHAR(256),
   constraint PK_SMS primary key (COD_INTERACAO)
);

/*==============================================================*/
/* Table: TARIFARIO                                             */
/*==============================================================*/
create table TARIFARIO 
(
   COD_TARIFARIO        NUMBER               not null,
   COD_PLANO            NUMBER               not null,
   TIPO                 CHAR(4)              not null,
   DATA_LANCAMENTO      DATE                 not null,
   PRECO_UNIDADE        NUMBER               not null,
   DESIGNACAO           CHAR(32)             not null,
   REDE                 CHAR(32)             not null,
   UNIDADE              CHAR(16)             not null,
   ESTADO               CHAR(16)             not null,
   constraint PK_TARIFARIO primary key (COD_TARIFARIO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on TARIFARIO (
   COD_PLANO ASC
);

alter table CARREGAMENTO
   add constraint FK_CARREGAM_RELATIONS_CONTRATO foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table CHAMADA
   add constraint FK_CHAMADA_INHERITAN_INTERACA foreign key (COD_INTERACAO)
      references INTERACAO (COD_INTERACAO);

alter table CONTRATO
   add constraint FK_CONTRATO_RELATIONS_CLIENTE foreign key (COD_CLIENTE)
      references CLIENTE (COD_CLIENTE);

alter table CONTRATO
   add constraint FK_CONTRATO_RELATIONS_PLANO foreign key (COD_PLANO)
      references PLANO (COD_PLANO);

alter table EVENTOS
   add constraint FK_EVENTOS_RELATIONS_INTERACA foreign key (COD_INTERACAO)
      references INTERACAO (COD_INTERACAO);

alter table FATURA
   add constraint FK_FATURA_RELATIONS_CONTRATO foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table INTERACAO
   add constraint FK_INTERACA_RELATIONS_CLASSIFI foreign key (NR_DESTINO)
      references CLASSIFICACAO (NR_DESTINO);

alter table INTERACAO
   add constraint FK_INTERACA_RELATIONS_INTERACO foreign key (COD_FATURAVEL)
      references INTERACOES_FATURAVEIS (COD_FATURAVEL);

alter table INTERACAO
   add constraint FK_INTERACA_RELATIONS_CONTRATO foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table INTERACOES_FATURAVEIS
   add constraint FK_INTERACO_RELATIONS_FATURA foreign key (COD_FATURA)
      references FATURA (COD_FATURA);

alter table INTERACOES_FATURAVEIS
   add constraint FK_INTERACO_RELATIONS_INTERACA foreign key (COD_INTERACAO)
      references INTERACAO (COD_INTERACAO);

alter table PLANO_POS_PAGO_PLAFOND
   add constraint FK_PLANO_PO_INHERITAN_PLANO2 foreign key (COD_PLANO)
      references PLANO (COD_PLANO);

alter table PLANO_POS_PAGO_SIMPLES
   add constraint FK_PLANO_PO_INHERITAN_PLANO foreign key (COD_PLANO)
      references PLANO (COD_PLANO);

alter table PLANO_PRE_PAGO
   add constraint FK_PLANO_PR_INHERITAN_PLANO foreign key (COD_PLANO)
      references PLANO (COD_PLANO);

alter table RELATIONSHIP_12
   add constraint FK_RELATION_RELATIONS_CAMPANHA foreign key (COD_CAMPANHA)
      references CAMPANHA (COD_CAMPANHA);

alter table RELATIONSHIP_12
   add constraint FK_RELATION_RELATIONS_CONTRAT3 foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table RELATIONSHIP_13
   add constraint FK_RELATION_RELATIONS_AMIGO foreign key (NUMERO)
      references AMIGO (NUMERO);

alter table RELATIONSHIP_13
   add constraint FK_RELATION_RELATIONS_CONTRATO foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table RELATIONSHIP_3
   add constraint FK_RELATION_RELATIONS_CONTRAT2 foreign key (COD_CONTRATO)
      references CONTRATO (COD_CONTRATO);

alter table RELATIONSHIP_3
   add constraint FK_RELATION_RELATIONS_PACOTE foreign key (COD_PACOTE)
      references PACOTE (COD_PACOTE);

alter table RELATIONSHIP_5
   add constraint FK_RELATION_RELATIONS_CAMPANH2 foreign key (COD_CAMPANHA)
      references CAMPANHA (COD_CAMPANHA);

alter table RELATIONSHIP_5
   add constraint FK_RELATION_RELATIONS_AMIGO2 foreign key (NUMERO)
      references AMIGO (NUMERO);

alter table SMS
   add constraint FK_SMS_INHERITAN_INTERACA foreign key (COD_INTERACAO)
      references INTERACAO (COD_INTERACAO);

alter table TARIFARIO
   add constraint FK_TARIFARI_RELATIONS_PLANO foreign key (COD_PLANO)
      references PLANO (COD_PLANO);
