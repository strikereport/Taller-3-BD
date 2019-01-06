--TABLA PARA EL EMPLEADO

CREATE TABLE EMPLEADO 
(
  RUT NUMBER(10, 0) NOT NULL 
, NOMBRE VARCHAR2(30) NOT NULL 
, FECHA_DE_CONTRATACION DATE NOT NULL 
, FECHA_DE_NACIMIENTO DATE NOT NULL 
, DIRECCION VARCHAR2(30) 
, CONSTRAINT EMPLEADO_PK PRIMARY KEY 
  (
    RUT 
  )
 ENABLE
);

--TABLA PARA EL PROYECTO
CREATE TABLE PROYECTO 
(
  CODIGO NUMBER(5,0) NOT NULL 
, NOMBRE VARCHAR2(30) NOT NULL 
, FECHA_DE_INICIO DATE NOT NULL 
, FECHA_DE_TERMINO DATE NOT NULL 
, PRESUPUESTO NUMBER(8, 2) DEFAULT 0 
, TIPO_PROYECTO VARCHAR2(1) 
, RUT_JEFE NUMBER(10, 0) NOT NULL 
, CONSTRAINT PROYECTO_PK PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
);

CREATE SEQUENCE PROYECTO_SEQ;

CREATE TRIGGER PROYECTO_TRG 
BEFORE INSERT ON PROYECTO 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.CODIGO IS NULL THEN
      SELECT PROYECTO_SEQ.NEXTVAL INTO :NEW.CODIGO FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/


--TABLA PARA EL EMPLEADO DEL PROYECTO
CREATE TABLE EMP_PROY 
(
  RUT NUMBER(10) NOT NULL 
, CODIGO NUMBER(5) NOT NULL 
, HORAS NUMBER(2) NOT NULL 
, CONSTRAINT EMP_PROY_PK PRIMARY KEY 
  (
    RUT 
  , CODIGO 
  )
  ENABLE 
);

-- RESTRICCIONES 
alter table "SYSTEM"."PROYECTO" 
  add constraint FKPROYECTO543752 
    foreign key("RUT_JEFE") 
      references "EMPLEADO"("RUT");

alter table "SYSTEM"."EMP_PROY" 
  add constraint FKEMP_PROY362421 
    foreign key("RUT") 
      references "EMPLEADO"("RUT");
alter table "SYSTEM"."EMP_PROY" 
  add constraint FKEMP_PROY902692 
    foreign key("CODIGO") 
      references "PROYECTO"("CODIGO");      

-- DATOS EMPLEADO

INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, FECHA_DE_CONTRATACION, FECHA_DE_NACIMIENTO, DIRECCION) 
  VALUES ('123123', 'PEPITO', TO_DATE('2013-03-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1993-03-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CASA DE PEPITO');
INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, FECHA_DE_CONTRATACION, FECHA_DE_NACIMIENTO, DIRECCION) 
  VALUES ('321321', 'FEFO', TO_DATE('2014-05-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1991-01-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CASA DE FEFO');
INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, FECHA_DE_CONTRATACION, FECHA_DE_NACIMIENTO, DIRECCION) 
  VALUES ('132132', 'CONDORITO', TO_DATE('2019-01-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1952-07-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'CASA DE CONDORITO');
INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, FECHA_DE_CONTRATACION, FECHA_DE_NACIMIENTO, DIRECCION) 
  VALUES ('789789', 'BATMAN', TO_DATE('2017-12-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1994-02-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'BATICUEVA');
INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, FECHA_DE_CONTRATACION, FECHA_DE_NACIMIENTO, DIRECCION) 
  VALUES ('987987', 'KEN', TO_DATE('2016-10-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1993-03-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ANTEIKU');

--DATOS PROYECTO
INSERT INTO "SYSTEM"."PROYECTO" (NOMBRE, FECHA_DE_INICIO, FECHA_DE_TERMINO, PRESUPUESTO, TIPO_PROYECTO, RUT_JEFE) 
  VALUES ('CAFE', TO_DATE('2018-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-03-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1000', 'Y', '789789');
INSERT INTO "SYSTEM"."PROYECTO" (NOMBRE, FECHA_DE_INICIO, FECHA_DE_TERMINO, PRESUPUESTO, TIPO_PROYECTO, RUT_JEFE) 
  VALUES ('PINPONG', TO_DATE('2019-01-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '20000', 'Z', '132132');

--DATOS EMP_PROY


INSERT INTO "SYSTEM"."EMP_PROY" (RUT, CODIGO, HORAS) 
  VALUES ('987987', '1', '16');
INSERT INTO "SYSTEM"."EMP_PROY" (RUT, CODIGO, HORAS) 
  VALUES ('789789', '1', '8');
INSERT INTO "SYSTEM"."EMP_PROY" (RUT, CODIGO, HORAS) 
  VALUES ('132132', '2', '22');
INSERT INTO "SYSTEM"."EMP_PROY" (RUT, CODIGO, HORAS) 
  VALUES ('123123', '2', '5');
INSERT INTO "SYSTEM"."EMP_PROY" (RUT, CODIGO, HORAS) 
  VALUES ('321321', '2', '10');


--CONSULTAS

--3
select EMPLEADO.NOMBRE AS "NOMBRE EMPLEADO" , PROYECTO.NOMBRE AS "NOMBRE PROYECTO"
  from EMPLEADO,PROYECTO,EMP_PROY
 where EMP_PROY.RUT = EMPLEADO.RUT AND EMP_PROY.CODIGO = PROYECTO.CODIGO
 ORDER BY EMPLEADO.NOMBRE;

--4
SELECT EMPLEADO.NOMBRE 
FROM EMPLEADO 
WHERE TRUNC((SYSDATE-EMPLEADO.FECHA_DE_NACIMIENTO)/365.25) >= 60;

--5
select EMPLEADO.NOMBRE SUM(EMP_PROY.HORAS) AS "HORAS TOTALES"
from EMPLEADO,EMP_PROY
where EMPLEADO.RUT = EMP_PROY.RUT
GROUP BY EMPLEADO.RUT;

--6
select EMPLEADO.NOMBRE AS "EMP EN PROYECTOS DEL 2018"
  from EMPLEADO,PROYECTO,EMP_PROY
 where EMP_PROY.RUT=EMPLEADO.RUT AND EMP_PROY.CODIGO = PROYECTO.CODIGO
        AND to_char(PROYECTO.FECHA_DE_INICIO,'YYYY') = '2018';

--7
