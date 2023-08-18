/* Note that the example procedure appendTempLOB_proc is not part of the 
   DBMS_LOB package. For a description of the other DBMS_LOB procedures used
   below, see the Oracle8i Supplied Packages Reference,Volume 1.*/

/* appending one temporary lob to another */

CREATE OR REPLACE PROCEDURE appendTempLOB_proc IS
   Dest_loc2 CLOB;
   Dest_loc  CLOB;
   Amount    NUMBER;
   Src_loc   BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
BEGIN
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE,DBMS_LOB.SESSION);
   DBMS_LOB.CREATETEMPORARY(Dest_loc2,TRUE,DBMS_LOB.SESSION);
   DBMS_LOB.OPEN(Dest_loc,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN(Dest_loc2,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN(Src_loc,DBMS_LOB.LOB_READWRITE);
   Amount := 32767;
   DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
   DBMS_LOB.LOADFROMFILE(Dest_loc2, Src_loc, Amount);
   DBMS_LOB.APPEND(Dest_loc, Dest_loc2);
   /* Close the temporary lobs and then free them: */
   DBMS_LOB.CLOSE(Dest_loc);
   DBMS_LOB.CLOSE(Dest_loc2);
   DBMS_LOB.CLOSE(Src_loc);
   DBMS_LOB.FREETEMPORARY(Dest_loc);
   DBMS_LOB.FREETEMPORARY(Dest_loc2);
END;
/
SHOW ERRORS;
