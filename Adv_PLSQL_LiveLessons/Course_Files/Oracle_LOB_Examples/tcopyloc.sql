/* Note that the example procedure copyTempLOBLocator_proc is not part of the 
   DBMS_LOB package. For a description of the other DBMS_LOB procedures used
   below, see the Oracle8i Supplied Packages Reference,Volume 1.*/

/* copying lob locator for temporary lob */

CREATE OR REPLACE PROCEDURE copyTempLOBLocator_proc(
   Lob_loc1 IN OUT CLOB, Lob_loc2 IN OUT CLOB) IS

   bufp     VARCHAR2(4);
   Amount   NUMBER  := 32767;
   Src_loc  BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
BEGIN
    DBMS_LOB.CREATETEMPORARY(Lob_loc1,TRUE,DBMS_LOB.SESSION);
    DBMS_LOB.CREATETEMPORARY(Lob_loc2,TRUE,DBMS_LOB.SESSION);
    /* Populate the first temporary LOB with some data. */
    /* Opening file is mandatory: */
    DBMS_LOB.OPEN(Src_loc,DBMS_LOB.LOB_READONLY);
    /* Opening LOB is optional: */
    DBMS_LOB.OPEN(Lob_loc1,DBMS_LOB.LOB_READWRITE);
    DBMS_LOB.OPEN(Lob_loc2,DBMS_LOB.LOB_READWRITE);
    DBMS_LOB.LOADFROMFILE(Lob_loc1,Src_loc,Amount);

   /* Assign Lob_loc1 to Lob_loc2 thereby creating  a copy of the value of
      the temporary LOB referenced by Lob_loc1 at this point in time: */
   Lob_loc2 := Lob_loc1;

   /* When you write some data to the LOB through Lob_loc1, Lob_loc2
      will not see the newly written data whereas Lob_loc1 will see
      the new data: */
   /*Closing LOBs is mandatory if they were opened: */
    DBMS_LOB.CLOSE (Src_loc);
    DBMS_LOB.CLOSE (Lob_loc1);
    DBMS_LOB.CLOSE (Lob_loc2);
    DBMS_LOB.FREETEMPORARY(Lob_loc1);
    DBMS_LOB.FREETEMPORARY(Lob_loc2);
END;
/
SHOW ERRORS;
