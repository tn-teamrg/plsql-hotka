CREATE or REPLACE FUNCTION Result_Cache_func (v_DEPTNO NUMBER)
return varchar2
RESULT_CACHE
is

v_dname dept.dname%TYPE;

begin
select dname into v_dname from dept where v_deptno = deptno;

DBMS_OUTPUT.PUT_LINE('Result_Cache_Func Executed!');

return(v_dname);

EXCEPTION

when NO_DATA_FOUND then
   return('No Data Found');
when OTHERS then
   dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);

end;
/
