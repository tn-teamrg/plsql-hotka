/* Note that the example procedure seeIfExistsBFILE_proc is not part of the 
   DBMS_LOB package:  */

/* seeing if bfile exists */

CREATE OR REPLACE PROCEDURE seeIfExistsBFILE_proc IS
   Lob_loc      BFILE;
BEGIN
   /* Select the LOB: */
   SELECT Intab.Recording INTO Lob_loc
      FROM THE(SELECT Mtab.InSeg_ntab FROM Multimedia_tab Mtab
         WHERE Mtab.Clip_ID = 3) Intab
            WHERE Intab.Segment = 1;
   /* See If the BFILE exists: */
   IF (DBMS_LOB.FILEEXISTS(Lob_loc) != 0)
   THEN
      DBMS_OUTPUT.PUT_LINE('Processing given that the BFILE exists');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Processing given that the BFILE does not exist');
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
