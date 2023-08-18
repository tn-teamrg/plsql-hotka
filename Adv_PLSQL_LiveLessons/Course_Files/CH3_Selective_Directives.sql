CREATE OR REPLACE PROCEDURE SELECTIVE_DIRECTIVES IS
    

BEGIN

$IF DBMS_DB_VERSION.VER_LE_10_1
$THEN
   dbms_output.put_line('I am on Database 10 Release 1');
$ELSIF DBMS_DB_VERSION.VER_LE_10_2
$THEN
   dbms_output.put_line('I am on Database 10 Release 2');
$ELSIF DBMS_DB_VERSION.VER_LE_11_1
$THEN
   dbms_output.put_line('I am on Database 11 Release 1');
$END
   
END;
/



