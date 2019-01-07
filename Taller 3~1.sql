--requerimiento numero 12 Listo
--SELECT *
--FROM EMPLEADO 
--WHERE NOT EXISTS (SELECT *
--                 FROM emp_proy   
--                 WHERE  emp_proy.rut = empleado.rut
--                )

--requerimiento numero 13 //pausado
--SELECT *
--FROM EMPLEADO ,emp_proy
--WHERE emp_proy.rut = empleado.rut 

--requerimiento numero 14 Listo
--SELECT nombre
--FROM EMPLEADO, emp_proy
--WHERE empleado.rut = emp_proy.rut and emp_proy.codigo =(SELECT codigo
--                                                        FROM   proyecto   
--                                                        WHERE  proyecto.nombre = 'ADMINISTRACION'
--                                                        )

--requerimiento numero 15 Listo
--SELECT proyecto.nombre , empleado.nombre 
--FROM proyecto , empleado, emp_proy
--WHERE emp_proy.codigo = proyecto.codigo and empleado.rut = proyecto.rut_jefe 

--requerimiento numero 16 Listo
--SELECT proyecto.nombre , empleado.nombre
--FROM proyecto , empleado
--WHERE empleado.rut = proyecto.rut_jefe and proyecto.codigo = ( SELECT emp_proy.codigo
--                                                               FROM emp_proy
--                                                               GROUP BY codigo
--                                                               HAVING COUNT(*) > 5
--                                                             ) 

--Requerimiento 17

--INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, F_DE_CONTRATACION, F_DE_NACIMIENTO, DIRECCION) VALUES ('1222222278', 'SAIKO',TO_DATE(sysdate,'YYYY/MM/DD:HH:MI:SSAM'), TO_DATE('1997-07-03', 'YYYY-MM-DD'), 'HAITI')


--Requerimiento 18

INSERT INTO "SYSTEM"."EMPLEADO" (RUT, NOMBRE, F_DE_CONTRATACION, F_DE_NACIMIENTO, DIRECCION) VALUES ('1222222278', 'SAKO',TO_DATE(sysdate,'YYYY/MM/DD:HH:MI:SSAM'), TO_DATE('1997-07-03', 'YYYY-MM-DD'), 'colombia')
ORA-00001: restricción única (SYSTEM.EMPLEADO_PK) violada





