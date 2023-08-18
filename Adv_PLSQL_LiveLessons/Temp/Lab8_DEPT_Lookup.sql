CREATE or REPLACE FUNCTION Lab8_DEPT_Lookup (IN_DEPTNO NUMBER)
return varchar2
is

v_dname varchar2(30);

cursor dept_cur is
select dname
from dept
where deptno = IN_DEPTNO;

dept_rec dept_cur%rowtype;

begin

open dept_cur;

fetch dept_cur into dept_rec;

return dept_rec.dname;

EXCEPTION

when NO_DATA_FOUND then
  return('No Data Found');

when OTHERS then
   return('Oracle Error');

end;
/
