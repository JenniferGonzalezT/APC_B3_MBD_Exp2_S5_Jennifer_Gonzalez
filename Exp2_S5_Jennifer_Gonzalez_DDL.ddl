-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2025-09-15 21:13:41 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE AFP 
    ( 
     id_afp NUMBER  NOT NULL , 
     nombre VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE AFP 
    ADD CONSTRAINT PK_AFP PRIMARY KEY ( id_afp ) ;

CREATE TABLE ATENCION 
    ( 
     id_atencion                    NUMBER  NOT NULL , 
     fecha                          DATE  NOT NULL , 
     diagnostico                    VARCHAR2 (200)  NOT NULL , 
     TIPO_ATENCION_id_tipo_atencion NUMBER  NOT NULL , 
     MODALIDAD_id_modalidad         NUMBER  NOT NULL , 
     PACIENTE_id_paciente           NUMBER  NOT NULL , 
     MEDICO_id_medico               NUMBER  NOT NULL , 
     PAGO_id_pago                   NUMBER  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX ATENCION_MEDICA__IDX ON ATENCION 
    ( 
     PAGO_id_pago ASC 
    ) 
;

ALTER TABLE ATENCION 
    ADD CONSTRAINT PK_ATENCION PRIMARY KEY ( id_atencion ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER  NOT NULL , 
     nombre           VARCHAR2 (50)  NOT NULL , 
     REGION_id_region NUMBER  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT PK_COMUNA PRIMARY KEY ( id_comuna ) ;

CREATE TABLE CONVENIO 
    ( 
     id_pago     NUMBER  NOT NULL , 
     institucion VARCHAR2 (200)  NOT NULL 
    ) 
;

ALTER TABLE CONVENIO 
    ADD CONSTRAINT PK_CONVENIO PRIMARY KEY ( id_pago ) ;

CREATE TABLE CREDITO 
    ( 
     id_pago NUMBER  NOT NULL , 
     cuotas  NUMBER  NOT NULL , 
     interes NUMBER  NOT NULL 
    ) 
;

ALTER TABLE CREDITO 
    ADD CONSTRAINT PK_CREDITO PRIMARY KEY ( id_pago ) ;

CREATE TABLE DEBITO 
    ( 
     id_pago NUMBER  NOT NULL 
    ) 
;

ALTER TABLE DEBITO 
    ADD CONSTRAINT PK_DEBITO PRIMARY KEY ( id_pago ) ;

CREATE TABLE EFECTIVO 
    ( 
     id_pago NUMBER  NOT NULL 
    ) 
;

ALTER TABLE EFECTIVO 
    ADD CONSTRAINT PK_EFECTIVO PRIMARY KEY ( id_pago ) ;

CREATE TABLE ESPECIALIDAD 
    ( 
     id_especialidad NUMBER  NOT NULL , 
     nombre          VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE ESPECIALIDAD 
    ADD CONSTRAINT PK_ESPECIALIDAD PRIMARY KEY ( id_especialidad ) ;

CREATE TABLE EXAMEN 
    ( 
     id_examen    NUMBER  NOT NULL , 
     nombre       VARCHAR2 (200)  NOT NULL , 
     tipo_muestra VARCHAR2 (200)  NOT NULL , 
     preparacion  VARCHAR2 (200) 
    ) 
;

ALTER TABLE EXAMEN 
    ADD CONSTRAINT PK_EXAMEN PRIMARY KEY ( id_examen ) ;

CREATE TABLE GENERO 
    ( 
     id_genero NUMBER  NOT NULL , 
     nombre    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE GENERO 
    ADD CONSTRAINT PK_GENERO PRIMARY KEY ( id_genero ) ;

CREATE TABLE INSTITUCION_SALUD 
    ( 
     id_salud NUMBER  NOT NULL , 
     nombre   VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE INSTITUCION_SALUD 
    ADD 
    CHECK (nombre IN ('"FONASA"', '"ISAPRE"')) 
;

ALTER TABLE INSTITUCION_SALUD 
    ADD CONSTRAINT PK_INSTITUCION_SALUD PRIMARY KEY ( id_salud ) ;

CREATE TABLE MEDICO 
    ( 
     rut                          NUMBER  NOT NULL , 
     id_medico                    NUMBER  NOT NULL , 
     fecha_ingreso                DATE  NOT NULL , 
     ESPECIALIDAD_id_especialidad NUMBER  NOT NULL , 
     UNIDAD_ATENCION_id_unidad    NUMBER  NOT NULL , 
     AFP_id_afp                   NUMBER  NOT NULL , 
     INSTITUCION_SALUD_id_salud   NUMBER  NOT NULL , 
     MEDICO_id_medico             NUMBER 
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT PK_MEDICO PRIMARY KEY ( rut ) ;

ALTER TABLE MEDICO 
    ADD CONSTRAINT MEDICO_PKv1 UNIQUE ( id_medico ) ;

CREATE TABLE MODALIDAD 
    ( 
     id_modalidad NUMBER  NOT NULL , 
     nombre       VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE MODALIDAD 
    ADD CONSTRAINT CK_MODALIDAD_ATENCION_NOMBRE 
    CHECK (nombre IN ('"PRESENCIAL"', '"VIRTUAL"')) 
;

ALTER TABLE MODALIDAD 
    ADD CONSTRAINT PK_MODALIDAD PRIMARY KEY ( id_modalidad ) ;

CREATE TABLE PACIENTE 
    ( 
     rut                          NUMBER  NOT NULL , 
     id_paciente                  NUMBER  NOT NULL , 
     fecha_nacimiento             DATE  NOT NULL , 
     telefono                     NUMBER  NOT NULL , 
     correo                       VARCHAR2 (200) , 
     direccion                    VARCHAR2 (200)  NOT NULL , 
     COMUNA_id_comuna             NUMBER  NOT NULL , 
     GENERO_id_genero             NUMBER  NOT NULL , 
     TIPO_USUARIO_id_tipo_usuario NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PK_PACIENTE PRIMARY KEY ( rut ) ;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PACIENTE_PKv1 UNIQUE ( id_paciente ) ;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PACIENTE_correo_UN UNIQUE ( correo ) ;

CREATE TABLE PAGO 
    ( 
     id_pago              NUMBER  NOT NULL , 
     fecha                DATE  NOT NULL , 
     monto                NUMBER  NOT NULL , 
     ATENCION_id_atencion NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT CK_PAGO_ATENCION_MONTO 
    CHECK (monto >= 0) 
;
CREATE UNIQUE INDEX PAGO_ATENCION__IDX ON PAGO 
    ( 
     ATENCION_id_atencion ASC 
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PK_PAGO PRIMARY KEY ( id_pago ) ;

CREATE TABLE PERSONA 
    ( 
     rut              NUMBER  NOT NULL , 
     rut_dv           VARCHAR2 (1)  NOT NULL , 
     primer_nombre    VARCHAR2 (50)  NOT NULL , 
     segundo_nombre   VARCHAR2 (50) , 
     primer_apellido  VARCHAR2 (50)  NOT NULL , 
     segundo_apellido VARCHAR2 (50) 
    ) 
;

ALTER TABLE PERSONA 
    ADD CONSTRAINT PK_PERSONA PRIMARY KEY ( rut ) ;

CREATE TABLE REGION 
    ( 
     id_region NUMBER  NOT NULL , 
     nombre    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT PK_REGION PRIMARY KEY ( id_region ) ;

CREATE TABLE SOLICITUD_EXAMEN 
    ( 
     id_solicitud_examen  NUMBER  NOT NULL , 
     fecha                DATE  NOT NULL , 
     resultado            VARCHAR2 (200)  NOT NULL , 
     ATENCION_id_atencion NUMBER  NOT NULL , 
     EXAMEN_id_examen     NUMBER  NOT NULL 
    ) 
;

ALTER TABLE SOLICITUD_EXAMEN 
    ADD CONSTRAINT PK_SOLICITUD_EXAMEN PRIMARY KEY ( id_solicitud_examen ) ;

CREATE TABLE TARJETA 
    ( 
     id_pago        NUMBER  NOT NULL , 
     numero_tarjeta NUMBER  NOT NULL , 
     banco          VARCHAR2 (200)  NOT NULL 
    ) 
;

ALTER TABLE TARJETA 
    ADD CONSTRAINT PK_TARJETA PRIMARY KEY ( id_pago ) ;

CREATE TABLE TIPO_ATENCION 
    ( 
     id_tipo_atencion NUMBER  NOT NULL , 
     nombre           VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE TIPO_ATENCION 
    ADD CONSTRAINT CK_TIPO_ATENCION_NOMBRE 
    CHECK (nombre IN ('"GENERAL"', '"PREVENTIVA"', '"URGENCIA"')) 
;

ALTER TABLE TIPO_ATENCION 
    ADD CONSTRAINT PK_TIPO_ATENCION PRIMARY KEY ( id_tipo_atencion ) ;

CREATE TABLE TIPO_USUARIO 
    ( 
     id_tipo_usuario NUMBER  NOT NULL , 
     nombre          VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE TIPO_USUARIO 
    ADD CONSTRAINT CK_TIPO_USUARIO_NOMBRE 
    CHECK (nombre IN ('"ESTUDIANTE"', '"EXTERNO"', '"FUNCIONARIO"')) 
;

ALTER TABLE TIPO_USUARIO 
    ADD CONSTRAINT PK_TIPO_USUARIO PRIMARY KEY ( id_tipo_usuario ) ;

CREATE TABLE UNIDAD_ATENCION 
    ( 
     id_unidad NUMBER  NOT NULL , 
     nombre    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE UNIDAD_ATENCION 
    ADD 
    CHECK (nombre IN ('"LABORATORIO CLINICO"', '"MEDICINA GENERAL"', '"SALUD MENTAL"')) 
;

ALTER TABLE UNIDAD_ATENCION 
    ADD CONSTRAINT PK_UNIDAD_ATENCION PRIMARY KEY ( id_unidad ) ;

ALTER TABLE ATENCION 
    ADD CONSTRAINT FK_ATENCION_MEDICO FOREIGN KEY 
    ( 
     MEDICO_id_medico
    ) 
    REFERENCES MEDICO 
    ( 
     id_medico
    ) 
;

ALTER TABLE ATENCION 
    ADD CONSTRAINT FK_ATENCION_MODALIDAD FOREIGN KEY 
    ( 
     MODALIDAD_id_modalidad
    ) 
    REFERENCES MODALIDAD 
    ( 
     id_modalidad
    ) 
;

ALTER TABLE ATENCION 
    ADD CONSTRAINT FK_ATENCION_PACIENTE FOREIGN KEY 
    ( 
     PACIENTE_id_paciente
    ) 
    REFERENCES PACIENTE 
    ( 
     id_paciente
    ) 
;

ALTER TABLE ATENCION 
    ADD CONSTRAINT FK_ATENCION_PAGO FOREIGN KEY 
    ( 
     PAGO_id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

ALTER TABLE ATENCION 
    ADD CONSTRAINT FK_ATENCION_TIPO_ATENCION FOREIGN KEY 
    ( 
     TIPO_ATENCION_id_tipo_atencion
    ) 
    REFERENCES TIPO_ATENCION 
    ( 
     id_tipo_atencion
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT FK_COMUNA_REGION FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE CONVENIO 
    ADD CONSTRAINT FK_CONVENIO_PAGO FOREIGN KEY 
    ( 
     id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

ALTER TABLE CREDITO 
    ADD CONSTRAINT FK_CREDITO_TARJETA FOREIGN KEY 
    ( 
     id_pago
    ) 
    REFERENCES TARJETA 
    ( 
     id_pago
    ) 
;

ALTER TABLE DEBITO 
    ADD CONSTRAINT FK_DEBITO_TARJETA FOREIGN KEY 
    ( 
     id_pago
    ) 
    REFERENCES TARJETA 
    ( 
     id_pago
    ) 
;

ALTER TABLE EFECTIVO 
    ADD CONSTRAINT FK_EFECTIVO_PAGO FOREIGN KEY 
    ( 
     id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_AFP FOREIGN KEY 
    ( 
     AFP_id_afp
    ) 
    REFERENCES AFP 
    ( 
     id_afp
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD FOREIGN KEY 
    ( 
     ESPECIALIDAD_id_especialidad
    ) 
    REFERENCES ESPECIALIDAD 
    ( 
     id_especialidad
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_INSTITUCION_SALUD FOREIGN KEY 
    ( 
     INSTITUCION_SALUD_id_salud
    ) 
    REFERENCES INSTITUCION_SALUD 
    ( 
     id_salud
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_MEDICO FOREIGN KEY 
    ( 
     MEDICO_id_medico
    ) 
    REFERENCES MEDICO 
    ( 
     id_medico
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_PERSONA FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PERSONA 
    ( 
     rut
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_UNIDAD_ATENCION FOREIGN KEY 
    ( 
     UNIDAD_ATENCION_id_unidad
    ) 
    REFERENCES UNIDAD_ATENCION 
    ( 
     id_unidad
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_COMUNA FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_GENERO FOREIGN KEY 
    ( 
     GENERO_id_genero
    ) 
    REFERENCES GENERO 
    ( 
     id_genero
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_PERSONA FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PERSONA 
    ( 
     rut
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_TIPO_USUARIO FOREIGN KEY 
    ( 
     TIPO_USUARIO_id_tipo_usuario
    ) 
    REFERENCES TIPO_USUARIO 
    ( 
     id_tipo_usuario
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT FK_PAGO_ATENCION FOREIGN KEY 
    ( 
     ATENCION_id_atencion
    ) 
    REFERENCES ATENCION 
    ( 
     id_atencion
    ) 
;

ALTER TABLE SOLICITUD_EXAMEN 
    ADD CONSTRAINT FK_SOLICITUD_EXAMEN_ATENCION FOREIGN KEY 
    ( 
     ATENCION_id_atencion
    ) 
    REFERENCES ATENCION 
    ( 
     id_atencion
    ) 
;

ALTER TABLE SOLICITUD_EXAMEN 
    ADD CONSTRAINT FK_SOLICITUD_EXAMEN_EXAMEN FOREIGN KEY 
    ( 
     EXAMEN_id_examen
    ) 
    REFERENCES EXAMEN 
    ( 
     id_examen
    ) 
;

ALTER TABLE TARJETA 
    ADD CONSTRAINT FK_TARJETA_PAGO FOREIGN KEY 
    ( 
     id_pago
    ) 
    REFERENCES PAGO 
    ( 
     id_pago
    ) 
;

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc Arc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc Arc_2 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc Arc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc Arc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc Arc_1 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             2
-- ALTER TABLE                             55
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  12
-- WARNINGS                                 0
