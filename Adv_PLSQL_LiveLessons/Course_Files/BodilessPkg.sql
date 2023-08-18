CREATE OR REPLACE PACKAGE USERx_GLOBAL_VARS AS

   Access_cnt    number := 0;
   StartTime     DATE := SYSDATE;
   
   Emp_Rec emp%rowtype;



END USERx_GLOBAL_VARS;
/

set serveroutput on

BEGIN

userx_global_vars.access_cnt := userx_global_vars.access_cnt + 1;
dbms_output.put_line('global count = ' || userx_global_vars.access_cnt);

END;

