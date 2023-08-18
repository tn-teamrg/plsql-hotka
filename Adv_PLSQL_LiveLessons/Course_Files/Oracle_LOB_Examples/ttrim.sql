/* Note that the example procedure trimTempLOB_proc is not part of the 
   DBMS_LOB package. */

/* trimming temporary lob data */

CREATE OR REPLACE PROCEDURE trimTempLOB_proc IS
   Lob_loc        CLOB;
   Amount         number;
   Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   TrimAmount     number := 100;
BEGIN
   /* Create a temporary LOB: */
   DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Opening the file is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Populate the temporary LOB with some data: */
   Amount := 32767;
   DBMS_LOB.LOADFROMFILE(Lob_loc, Src_loc, Amount);
   DBMS_LOB.TRIM(Lob_loc,TrimAmount);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
   DBMS_LOB.CLOSE(Src_loc);
   DBMS_LOB.FREETEMPORARY(Lob_loc);
COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
