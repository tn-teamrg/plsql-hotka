/* Note that the example procedure instringBFILE_proc is not part of the 
   DBMS_LOB package: */

/* seeing if pattern exists (instr) in bfile */

CREATE OR REPLACE PROCEDURE instringBFILE_proc IS
   Lob_loc        BFILE;
   Pattern        RAW(32767);
   Position       INTEGER;
BEGIN
   /* Select the LOB: */
   SELECT Intab.Recording INTO Lob_loc
      FROM THE(SELECT Mtab.InSeg_ntab FROM Multimedia_tab Mtab
         WHERE Clip_ID = 3) Intab
            WHERE Segment = 1;
   /* Open the BFILE: */
   DBMS_LOB.OPEN(Lob_loc, DBMS_LOB.LOB_READONLY);
   /*  Initialize the pattern for which to search, find the 2nd occurrence of
       the pattern starting from the beginning of the BFILE: */
   Position := DBMS_LOB.INSTR(Lob_loc, Pattern, 1, 2);
   /* Close the BFILE: */
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
SHOW ERRORS;
