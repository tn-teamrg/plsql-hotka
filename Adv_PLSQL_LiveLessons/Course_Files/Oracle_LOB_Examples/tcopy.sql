/* Note that the example procedure copyTempLOB_proc is not part of the 
   DBMS_LOB package. For a description of the other DBMS_LOB procedures used
   below, see the Oracle8i Supplied Packages Reference,Volume 1. */

/* copying all or part of one temporary lob to another */

CREATE OR REPLACE PROCEDURE copyTempLOB_proc IS
   Dest_pos     NUMBER;
   Src_pos      NUMBER;
   Dest_loc     BLOB;
   Dest_loc2    BLOB;
   Src_loc      BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount       INTEGER := 32767;
BEGIN
   DBMS_LOB.CREATETEMPORARY(Dest_loc2,TRUE,DBMS_LOB.SESSION);
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
   /* Opening the FILE  is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Opening the temporary  LOBs is optional: */
   DBMS_LOB.OPEN(Dest_loc,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN(Dest_loc2,DBMS_LOB.LOB_READWRITE);

   DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
      /* Set Dest_pos to the position at which we should start writing in the
          target temp LOB */
      /* Copies the LOB from the source position to the destination
          position:*/
      /* Set amount to the amount you want copied */
          Amount := 328;
          Dest_pos := 1000;
          Src_pos := 1000;
      /* Set Src_pos to the position from which we should start copying data
          from  tclob_src: */
          DBMS_LOB.COPY(Dest_loc2,Dest_loc, Amount, Dest_pos, Src_pos);
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
      DBMS_LOB.CLOSE(Dest_loc);
      DBMS_LOB.CLOSE(Dest_loc2);
      DBMS_LOB.CLOSE(Src_loc);
      DBMS_LOB.FREETEMPORARY(Dest_loc);
      DBMS_LOB.FREETEMPORARY(Dest_loc2);
END;
/
SHOW ERRORS;
