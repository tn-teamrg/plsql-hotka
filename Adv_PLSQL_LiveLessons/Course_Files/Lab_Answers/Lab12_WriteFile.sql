CREATE OR REPLACE PROCEDURE WRITEFILE IS
   FileID       UTL_FILE.FILE_TYPE;
   FileName     varchar2(20) := 'USER0_WRITE.txt';
   
BEGIN

   FileID := UTL_FILE.FOPEN('TEMPDIR', FileName, 'W');
   UTL_FILE.PUT_LINE(FileID,'Dan Hotka');
   UTL_FILE.FCLOSE(FileID);

EXCEPTION
   when UTL_FILE.INVALID_OPERATION then
      dbms_output.put_line('Could not open file ' || FileName);
   when UTL_FILE.WRITE_Error then
      dbms_output.put_line('Could not write file ' || FileName);
      UTL_FILE.FCLOSE(FileID);
   when others then
      dbms_output.put_line('Oracle Error: ' || SQLCODE || ' ' || SQLERRM);
      UTL_FILE.FCLOSE(FileID);


END WRITEFILE;
/


