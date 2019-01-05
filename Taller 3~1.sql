
--CREAMOS LAS TABLAS DE DATOS
DROP TABLE PROYECTO;

--TABLA PARA EL EMPLEADO
CREATE TABLE EMPLEADO (
RUT NUMBER(10) NOT NULL ,
NOMBRE VARCHAR2(30)NOT NULL ,
FECHA_DE_CONTRATACION DATE NOT NULL,
FECHA_DE_NACIMIENTO DATE NOT NULL,
DIRECCION VARCHAR2(30),
--LLAVE PRIMARIA
CONSTRAINT PK_RUT
PRIMARY KEY (RUT)
);


--TABLA PARA EL PROYECTO
CREATE TABLE PROYECTO (
CODIGO NUMBER(5) NOT NULL,
NOMBRE VARCHAR2(30)NOT NULL,
FECHA_DE_INICIO DATE NOT NULL,
FECHA_DE_TERMINO DATE NOT NULL,
PRESUPUESTO NUMBER(8,2),
TIPO_PROYECTO VARCHAR(1),
RUT_JEFE NUMBER(10) NOT NULL ,
--RESTRICCIONES
CHECK(TIPO_PROYECTO LIKE '[A,B,C,D,X,Y,Z]'),
CHECK(FECHA_DE_INICIO > TO_DATE('2000-01-01','YYYY-MM-DD')),
CHECK(FECHA_DE_INICIO < FECHA_DE_TERMINO),
--LLAVE PRIMARIA
CONSTRAINT PK_CODIGO
PRIMARY KEY (CODIGO)
);

--CREAMOS LA CLAVE FORANEA
ALTER TABLE PROYECTO 
ADD CONSTRAINT FK_RUT_JEFE FOREIGN KEY (RUT_JEFE) REFERENCES EMPLEADO(RUT);

--TABLA PARA EL EMPLEADO DEL PROYECTO
CREATE TABLE  EMP_PROY (
RUT_EMP_PROY NUMBER(10) NOT NULL ,
CODIGO_EMP_PROY NUMBER(5) NOT NULL ,
HORAS NUMBER(2) NOT NULL,
--RESTRICCIONES
CHECK(HORAS > 5 AND HORAS < 22),
--LLAVE PRIMARIA
CONSTRAINT PK_CODIGO_RUT
PRIMARY KEY (RUT_EMP_PROY,CODIGO_EMP_PROY)
);
--CREAMOS LA CLAVE FORANEA
ALTER TABLE EMP_PROY 
ADD CONSTRAINT FK_RUT_EMP_PROY FOREIGN KEY (RUT_EMP_PROY) REFERENCES EMPLEADO(RUT);
ALTER TABLE EMP_PROY 
ADD CONSTRAINT FK_CODIGO_EMP_PROY FOREIGN KEY (CODIGO_EMP_PROY) REFERENCES PROYECTO(CODIGO);


--agregar datos a las tablas
INSERT INTO EMPLEADO (RUT,NOMBRE,FECHA_DE_CONTRATACION,FECHA_DE_NACIMIENTO,DIRECCION) VALUES ('1111111121','JUAN',to_date('2017-01-01', 'yyyy-mm-dd'),to_date('1995-01-01', 'yyyy-mm-dd'),'ANTOFAGASTA');
INSERT INTO EMPLEADO (RUT,NOMBRE,FECHA_DE_CONTRATACION,FECHA_DE_NACIMIENTO,DIRECCION) VALUES ('2222222231','CAMILO',to_date('2014-01-01', 'yyyy-mm-dd'),to_date('1994-01-01', 'yyyy-mm-dd'),'CALAMA');
INSERT INTO EMPLEADO (RUT,NOMBRE,FECHA_DE_CONTRATACION,FECHA_DE_NACIMIENTO,DIRECCION) VALUES ('3333333341','JORGE',to_date('2013-01-01', 'yyyy-mm-dd'),to_date('1993-01-01', 'yyyy-mm-dd'),'IQUIQUE');
INSERT INTO EMPLEADO (RUT,NOMBRE,FECHA_DE_CONTRATACION,FECHA_DE_NACIMIENTO,DIRECCION) VALUES ('4444444451','SOFIA',to_date('2012-01-01', 'yyyy-mm-dd'),to_date('1992-01-01', 'yyyy-mm-dd'),'SANTIAGO');
INSERT INTO EMPLEADO (RUT,NOMBRE,FECHA_DE_CONTRATACION,FECHA_DE_NACIMIENTO,DIRECCION) VALUES ('5555555521','DIANA',to_date('2011-01-01', 'yyyy-mm-dd'),to_date('1991-01-01', 'yyyy-mm-dd'),'OVALLE');

-- para proyecto
INSERT INTO PROYECTO (CODIGO,NOMBRE,FECHA_DE_INICIO,FECHA_DE_TERMINO,PRESUPUESTO,TIPO_PROYECTO,RUT_JEFE) VALUES ('12345','DIANA',to_date('2011-01-01', 'yyyy-mm-dd'),to_date('2018-01-01', 'yyyy-mm-dd'),'234556','A','5555555521');

--verificar si se agrego
SELECT * FROM PROYECTO;
