/* Note that the example procedure writeAppendTempLOB_proc is not part of the 
   DBMS_LOB package. This example procedure will read in 32767 bytes of  data
   from the Washington_audio file starting at offset 128 and append it to a
   temporary LOB. */

/* writing to the end of a temporary lob (write append) */

CREATE OR REPLACE PROCEDURE writeAppendTempLOB_proc IS
   Lob_loc    BLOB;
   Buffer     RAW(32767);
   Src_loc    BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount     Binary_integer := 32767;
   Position   Binary_integer := 128;
BEGIN
   DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);
   /* Opening the temporary LOB is optional: */
   DBMS_LOB.OPEN(Lob_loc,DBMS_LOB.LOB_READWRITE);
   /* Opening the FILE is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Fill the buffer with data: */
   DBMS_LOB.LOADFROMFILE (Lob_loc,Src_loc, Amount);

   /* Append the data from the buffer to the end of the LOB: */
   DBMS_LOB.WRITEAPPEND(Lob_loc, Amount, Buffer);
   DBMS_LOB.CLOSE(Src_loc);
   DBMS_LOB.CLOSE(Lob_loc);
   DBMS_LOB.FREETEMPORARY(Lob_loc);
END;
/
SHOW ERRORS;
