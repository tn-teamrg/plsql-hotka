/* Note that the example procedure substringBFILE_proc is not part of the 
   DBMS_LOB package:  */

/* reading portion of bfile data (substr) */

CREATE OR REPLACE PROCEDURE substringBFILE_proc IS
   Lob_loc         BFILE;
   Position        INTEGER := 1;
   Buffer          RAW(32767);
BEGIN
   /* Select the LOB: */  
   SELECT Mtab.Voiced_ref.Recording INTO Lob_loc FROM Multimedia_tab Mtab
      WHERE Mtab.Clip_ID = 3;
   /* Open the BFILE: */  
   DBMS_LOB.OPEN(Lob_loc, DBMS_LOB.LOB_READONLY);
   Buffer := DBMS_LOB.SUBSTR(Lob_loc, 255, Position);
   /* Close the BFILE: */  
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
SHOW ERRORS;
