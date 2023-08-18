/* The following function acceses the Washington_audio file, creates a temporary 
  LOB, loads some data from the file, and then reads it back and 
  displays it. See also the "LOADFROMFILE Procedure", "READ PROCEDURE", and 
  "PUT and PUT_LINE Procedures", in Oracle8i Supplied Packages Reference,
  Volume 1, Chapter 17.*/ 

/* displaying temporary lob data */

DECLARE
   Dest_loc       BLOB;
   Src_loc        BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
   Amount         INTEGER := 128;
   Bbuf           RAW(128);
   Position       INTEGER :=1;
BEGIN
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
   /* Opening the FILE  is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN(Dest_loc,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.LOADFROMFILE(Dest_loc,Src_loc,Amount);

   LOOP
      DBMS_LOB.READ (Dest_loc, Amount, Position, Bbuf);
      /* Display the buffer contents: */
      DBMS_OUTPUT.PUT_LINE('Result :'|| utl_raw.cast_to_varchar2(Bbuf));
      Position := Position + Amount;
   END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('End of data loaded into temp LOB');

    DBMS_LOB.CLOSE(Dest_loc);
    DBMS_LOB.FREETEMPORARY(Dest_loc);
    /* Closing the file is mandatory unless you close the files later: */
    DBMS_LOB.CLOSE(Src_loc);
END;
/
SHOW ERRORS;
