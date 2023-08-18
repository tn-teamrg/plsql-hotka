CREATE or REPLACE PROCEDURE Lab52_proc (IN_empno IN emp.empno%TYPE) 
is

cursor emp_cur (v_empno emp.empno%TYPE) is
   select ename, deptno
   from emp
   where empno = v_empno;

emp_rec emp_cur%ROWTYPE;
   
v_dname dept.dname%TYPE;

BEGIN

Open emp_cur(IN_empno);

fetch emp_cur into emp_rec;

v_dname := Lab24_func(emp_rec.deptno);

dbms_output.put_line('Employee ' || emp_rec.ename || ' works in dept ' || v_dname);

--  OR  --
-- dbms_output.put_line('Employee ' || v_ename || ' works in dept ' || Lab24_func(emp_rec.deptno));
--
-- less lines of code is better!

close emp_cur;

EXCEPTION

when NO_DATA_FOUND then
   dbms_output.put_line('No Data Found');
when OTHERS then
   dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);

END;
/


