CREATE or REPLACE FUNCTION DEPT_Lookup (v_DEPTNO NUMBER)
return varchar2
is
v_dname dept.dname%TYPE;
v_oraerr number(10);
v_oramsg varchar2(1200);

begin

select dname
into v_dname
from dept
where deptno = v_DEPTNO;

return v_dname;

--EXCEPTION

--when NO_DATA_FOUND then
--   return('No Data Found');

--when OTHERS then
--   dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);

end;
/
