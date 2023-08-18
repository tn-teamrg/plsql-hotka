CREATE OR REPLACE PROCEDURE READFILE IS
   FileID    UTL_FILE.FILE_TYPE;
   v_text    VARCHAR2(200);
   v_info    VARCHAR2(50);
   V_status  INTEGER;
   

BEGIN

   DBMS_ALERT.REGISTER('DanHotka_Signal');
   DBMS_ALERT.WAITONE('DanHotka_Signal',v_info,v_status,3600);

   FileID := UTL_FILE.FOPEN('TEMPDIR', 'USER0_WRITE.txt', 'R');
   UTL_FILE.GET_LINE(FileID, v_text);
   DBMS_OUTPUT.PUT_LINE(v_text);  
   UTL_FILE.FCLOSE(FileID);

   DBMS_ALERT.REMOVE('DanHotka_Signal');
   DBMS_OUTPUT.PUT_LINE(v_info);

END READFILE;
/




BEGIN
dbms_file_transfer.copy_file(
    source_directory_object => 'DBAFILES_SOURCE',
    source_file_name => 'MyTblspace01.dbf', 
    destination_directory_object => 'DBAFILES_TARGET',
    destination_file_name => 'MyTblspace01.dbf');
END;
/


