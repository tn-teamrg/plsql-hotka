CREATE OR REPLACE PACKAGE USERx_pkg IS
   PROCEDURE RECORD_LAB_MSG 
(p_msg VARCHAR2);
   PROCEDURE WHAT_DATABASE;
   
END USERx_pkg;
/

CREATE OR REPLACE PACKAGE BODY USERx_pkg IS

PROCEDURE RECORD_LAB_MSG 
(p_msg VARCHAR2)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

INSERT INTO LAB_MSG VALUES (USER, SYSDATE, p_msg);

COMMIT;

END RECORD_LAB_MSG;

PROCEDURE WHAT_DATABASE IS
    
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
$ELSIF DBMS_DB_VERSION.VER_LE_11_2
$THEN
   dbms_output.put_line('I am on Database 11 Release 2');
$ELSIF DBMS_DB_VERSION.VER_LE_12_1
$THEN
   dbms_output.put_line('I am on Database 12 Release 1');
$ELSIF DBMS_DB_VERSION.VER_LE_12_2
$THEN
   dbms_output.put_line('I am on Database 12 Release 2');
$END
   
END WHAT_DATABASE;

END USERx_pkg;
/

