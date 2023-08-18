CREATE OR REPLACE PROCEDURE WRITEFILE IS
   FileID       UTL_FILE.FILE_TYPE;
   
BEGIN

   FileID := UTL_FILE.FOPEN('TEMPDIR', 'USER0_WRITE.txt', 'W');
   UTL_FILE.PUT_LINE(FileID,'Dan Hotka Appended-Signaled');
   UTL_FILE.FCLOSE(FileID);

   DBMS_ALERT.SIGNAL('DanHotka_Signal','File is ready Dan');
   DBMS_OUTPUT.PUT_LINE('Signal issued');
   COMMIT;

END WRITEFILE;
/


