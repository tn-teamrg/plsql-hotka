CREATE OR REPLACE PACKAGE overload3 IS
   FUNCTION esal (IN_Number number) RETURN number; 
   FUNCTION esal (IN_Name varchar2) RETURN number;
END;
/

CREATE or REPLACE PACKAGE BODY overload3 IS

FUNCTION esal (IN_Number number) RETURN number
IS
v_sal    emp.sal%TYPE;

BEGIN

select sal
into v_sal
from emp
where empno = IN_Number;

RETURN v_sal;

END;

FUNCTION esal (IN_Name varchar2) RETURN number
IS
v_sal    emp.sal%TYPE;

BEGIN

select sal
into v_sal
from emp
where ename = IN_Name;

RETURN v_sal;

END;

END overload3;
/

