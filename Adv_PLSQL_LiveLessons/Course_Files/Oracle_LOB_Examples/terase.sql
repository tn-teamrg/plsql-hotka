/* Note that the example procedure eraseTempLOB_proc is not part of the 
   DBMS_LOB package: */

/* erasing part of a temporary lob */

CREATE OR REPLACE PROCEDURE trimTempLOB_proc IS
   Lob_loc        CLOB;
   amt            number;
   Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount         INTEGER := 32767;
BEGIN

   /* Create a temporary LOB: */
   DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);

   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);

   /* Populate the temporary LOB with some data: */
   Amount := 32767;
   DBMS_LOB.LOADFROMFILE(Lob_loc, Src_loc, Amount);
   /* Erase  the LOB data: */
   amt := 3000;
   DBMS_LOB.ERASE(Lob_loc, amt, 2);

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
