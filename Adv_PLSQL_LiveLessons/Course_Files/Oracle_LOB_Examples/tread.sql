/* See also the  Oracle8i Application Developer∆s Reference - Packages
       Note that PL/SQL does not support streaming reads. The OCI example will 
       illustrate streaming reads: */ 

/* reading data from temporary lob */

DECLARE
  Dest_loc       BLOB;
  Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
  Amount         INTEGER := 4000;
  Bbuf           RAW(32767);
  Position       INTEGER :=1;
BEGIN
    DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
    /* Opening the FILE is mandatory: */
    DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
    /* Opening the LOB is optional: */
    DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
    DBMS_LOB.READ (Dest_loc, Amount, Position, Bbuf);
    /* Closing the LOB is mandatory if you have opened it: */
    DBMS_LOB.CLOSE(Src_loc);
END;
/
