CREATE OR REPLACE PACKAGE MASTER_VARS AS

   Access_cnt    number := 0;
   
END MASTER_VARS;
/

set serveroutput on

BEGIN

master_vars.access_cnt := master_vars.access_cnt + 1;
dbms_output.put_line('global count = ' || master_vars.access_cnt);

END;

