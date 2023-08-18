/* See also the "SUBSTR" function in the Oracle8i Supplied Packages Reference,
   Volume 1, Chapter 17. Note that the example procedure substringTempLOB_proc 
   is not part of the DBMS_LOB package. */
/* This example assumes the user has a ∆Washington_audio∆ file in a
   directory which has a AUDIO_DIR alias */

/* reading portion of temporary lob (substr) */

CREATE or REPLACE PROCEDURE substringTempLOB_proc IS
   Dest_loc       BLOB;
   Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount         INTEGER := 32767;
   Bbuf           RAW(32767);
   Position       INTEGER :=128;
BEGIN
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
   /* Opening the FILE  is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Opening the LOB is optional */
   DBMS_LOB.OPEN(Dest_loc,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
   Bbuf := DBMS_LOB.SUBSTR(Dest_loc, Amount, Position);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE(Src_loc);
   DBMS_LOB.CLOSE(Dest_loc);
END;
/
SHOW ERRORS;
