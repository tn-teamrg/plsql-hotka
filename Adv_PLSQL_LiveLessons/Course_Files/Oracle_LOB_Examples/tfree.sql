/* See also the  "LoadFromFile" procedure in the Oracle8i Supplied Packages 
Reference, Volume 1, Chapter 17.*/

/* freeing a temp lob */

DECLARE
   Dest_loc       BLOB;
   Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount         INTEGER := 4000;
BEGIN
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
   /* Opening the BFILE is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN(Dest_loc,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE(Src_loc);
   DBMS_LOB.CLOSE(Dest_loc);
   /* Free the temporary LOB: */
   DBMS_LOB.FREETEMPORARY(Dest_loc);
END;
/
