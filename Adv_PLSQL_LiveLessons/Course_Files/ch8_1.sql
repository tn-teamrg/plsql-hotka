DECLARE

emp_rec emp.%ROWTYPE;

BEGIN

select * into emp_rec
from emp
where empno = v_number;

emp_rec.sal := emp_rec.sal * 1.1;

dbms_output.put_line('Employee ' || chr(10) || emp_rec.empno || ' New Sal ' || v_sal);

END;
/