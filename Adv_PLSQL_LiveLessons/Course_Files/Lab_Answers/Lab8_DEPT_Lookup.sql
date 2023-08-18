CREATE or REPLACE FUNCTION Lab8_DEPT_Lookup (IN_DEPTNO NUMBER)
return varchar2
is

v_dname varchar2(30);

cursor dept_cur (v_deptno dept.deptno%type) is
select dname
from dept
where deptno = v_DEPTNO;

dept_rec dept_cur%rowtype;

begin

open dept_cur (IN_DEPTNO);

fetch dept_cur into dept_rec;

return dept_rec.dname;

EXCEPTION

when NO_DATA_FOUND then
  return('No Data Found');

when OTHERS then
   return('Oracle Error');

end;

