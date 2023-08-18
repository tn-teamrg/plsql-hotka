alter session set PLSQL_CCFLAGS = 'dan_setting:1';


CREATE OR REPLACE PROCEDURE INQUIRY_DIRECTIVES IS
    
BEGIN

$IF $$dan_setting = 0
$THEN
   dbms_output.put_line('dan_setting = 0');
$ELSIF $$dan_setting = 1
$THEN
   dbms_output.put_line('dan_setting = 1');
$END
   
END;
/



