CREATE or REPLACE PROCEDURE Lab52_proc (IN_empno IN emp.empno%TYPE) 
is

cursor emp_cur (v_empno emp.empno%TYPE) is
   select ename, deptno
   from emp
   where empno = v_empno;

emp_rec emp_cur%ROWTYPE;
   
v_dname dept.dname%TYPE;

BEGIN

for emp_rec in emp_cur(IN_empno)
LOOP

    dbms_output.put_line('Employee ' || emp_rec.ename || ' works in dept ' || Lab24_func(emp_rec.deptno));

END LOOP;

close emp_cur;

EXCEPTION

when NO_DATA_FOUND then
   dbms_output.put_line('No Data Found');
when OTHERS then
   dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);

END;
/


