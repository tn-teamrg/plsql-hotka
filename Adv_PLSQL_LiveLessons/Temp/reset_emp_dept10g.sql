drop table emp;
drop table dept;

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));
INSERT INTO EMP VALUES        (7369, 'SMITH',  'CLERK',     7902,        TO_DATE('17-DEC-1980', 'DD-MON-YYYY'),  800, NULL, 20);
INSERT INTO EMP VALUES        (7499, 'ALLEN',  'SALESMAN',  7698,        TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600,  300, 30);
INSERT INTO EMP VALUES        (7521, 'WARD',   'SALESMAN',  7698,        TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250,  500, 30);
INSERT INTO EMP VALUES        (7566, 'JONES',  'MANAGER',   7839,        TO_DATE('2-APR-1981', 'DD-MON-YYYY'),  2975, NULL, 20);
INSERT INTO EMP VALUES        (7654, 'MARTIN', 'SALESMAN',  7698,        TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES        (7698, 'BLAKE',  'MANAGER',   7839,        TO_DATE('1-MAY-1981', 'DD-MON-YYYY'),  2850, NULL, 30);
INSERT INTO EMP VALUES        (7782, 'CLARK',  'MANAGER',   7839,        TO_DATE('9-JUN-1981', 'DD-MON-YYYY'),  2450, NULL, 10);
INSERT INTO EMP VALUES        (7788, 'SCOTT',  'ANALYST',   7566,        TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES        (7839, 'KING',   'PRESIDENT', NULL,        TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES        (7844, 'TURNER', 'SALESMAN',  7698,        TO_DATE('8-SEP-1981', 'DD-MON-YYYY'),  1500,    0, 30);
INSERT INTO EMP VALUES        (7876, 'ADAMS',  'CLERK',     7788,        TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES        (7900, 'JAMES',  'CLERK',     7698,        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),   950, NULL, 30);
INSERT INTO EMP VALUES        (7902, 'FORD',   'ANALYST',   7566,        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),  3000, NULL, 20);
INSERT INTO EMP VALUES        (7934, 'MILLER', 'CLERK',     7782,        TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);



CREATE TABLE DEPT 
(DEPTNO              NUMBER(2) NOT NULL,
 DNAME               VARCHAR2(14),
 LOC                 VARCHAR2(13),
 CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));
INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');


commit;


CREATE OR REPLACE PROCEDURE looping_example
IS
   cursor emp_cur is
        select ename
        from emp;
   loop_counter   NUMBER := 0;
   ename   varchar2(10);
   
BEGIN
   open emp_cur;

   fetch emp_cur into ename;

   while emp_cur%FOUND
   LOOP
      loop_counter := loop_counter + 1;
      DBMS_OUTPUT.put_line 
          ('Record ' || loop_counter || ' is Employee ' || ename );
      fetch emp_cur into ename;
   END LOOP;

   DBMS_OUTPUT.put_line ('Procedure Looping Example is done');
   
   close emp_cur;
   
END;

/

CREATE OR REPLACE PACKAGE temperature IS
   PROCEDURE Temperature_Conversion ( IN_Temp number,IN_Type varchar2);
   FUNCTION Celsius_to_Fahrenheit ( IN_Temp NUMBER) Return Number;
   FUNCTION Fahrenheit_to_Celsius ( IN_Temp NUMBER) Return Number;
   
END temperature;
/

CREATE OR REPLACE PACKAGE BODY temperature AS

PROCEDURE temperature_conversion 
(IN_Temp number,
IN_Type varchar2)
IS
Converted_Temp NUMBER := 0;
BEGIN

IF 	 IN_Type = 'C'
THEN
	Converted_Temp := TEMPERATURE.Celsius_to_Fahrenheit(IN_Temp);
		
	DBMS_OUTPUT.PUT_LINE('Fahrenheit = ' || Converted_Temp);
	RETURN;
ELSIF In_Type = 'F'
THEN
	Converted_temp := TEMPERATURE.Fahrenheit_to_Celsius(IN_Temp);
	DBMS_OUTPUT.PUT_LINE('Celsius = ' || Converted_Temp);
	RETURN; 
END IF;
DBMS_OUTPUT.PUT_LINE('Bad Temperature Conversion Code: ' ||
    IN_Type);
RETURN;  

END temperature_conversion;


FUNCTION celsius_to_fahrenheit (IN_Temp NUMBER)
RETURN NUMBER IS
Conv_Temp NUMBER;
BEGIN
   Conv_Temp := (IN_Temp * 9/5) + 32;
   RETURN Conv_temp;
END celsius_to_fahrenheit;

FUNCTION fahrenheit_to_celsius (IN_Temp NUMBER)
RETURN NUMBER IS
Conv_Temp NUMBER;
BEGIN
   Conv_Temp := (5/9) * (IN_Temp - 32);
   RETURN Conv_temp;
END fahrenheit_to_celsius;

END temperature;
/ 


COMMIT;

exec dbms_stats.gather_schema_stats(user,cascade => true);

purge recyclebin;

exit;