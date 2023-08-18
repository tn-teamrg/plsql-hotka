CREATE OR REPLACE PROCEDURE READFILE IS
   FileID    UTL_FILE.FILE_TYPE;
   v_text    VARCHAR2(200);
   FileName  varchar2(20) := 'USER0_WRITE.txt';

BEGIN

   FileID := UTL_FILE.FOPEN('TEMPDIR', FileName, 'R');
   UTL_FILE.GET_LINE(FileID, v_text);
   DBMS_OUTPUT.PUT_LINE(v_text);  
   UTL_FILE.FCLOSE(FileID);

EXCEPTION
   when UTL_FILE.INVALID_OPERATION then
      dbms_output.put_line('Could not open file ' || FileName);
   when UTL_FILE.READ_Error then
      dbms_output.put_line('Could not read file ' || FileName);
      UTL_FILE.FCLOSE(FileID);
   when others then
      dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);
      UTL_FILE.FCLOSE(FileID);

END READFILE;
/


