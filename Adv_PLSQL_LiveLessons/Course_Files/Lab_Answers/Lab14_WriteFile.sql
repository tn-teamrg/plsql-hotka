CREATE OR REPLACE PROCEDURE WRITEFILE IS
   FileID       UTL_FILE.FILE_TYPE;
   
BEGIN

   FileID := UTL_FILE.FOPEN('TEMPDIR', 'USER0_SCHEDULE.txt', 'W');
   UTL_FILE.PUT_LINE(FileID,'Dan Hotka Scheduled');
   UTL_FILE.FCLOSE(FileID);

   DBMS_OUTPUT.PUT_LINE('Scheduled Writefile executed');

END WRITEFILE;
/

declare
   v_job NUMBER;
begin
   dbms_job.submit(v_job,'Writefile;',sysdate + 1/);
   dbms_output.put_line('Job = ' || v_job);
   commit;
end;
/

Select JOB, SCHEMA_USER, THIS_DATE, TOTAL_TIME
From USER_JOBS;


begin
   for i IN 1 .. 10
   LOOP
     DBMS_OUTPUT.PUT(ROUND(DBMS_RANDOM.VALUE(100,1000)) || ' ');
   END LOOP;
DBMS_OUTPUT.NEW_LINE;
END;
/


