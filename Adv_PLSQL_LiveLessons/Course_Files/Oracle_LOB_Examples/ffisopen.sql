/* Note that the example procedure seeIfOpenBFILE_procOne is not part of the 
   DBMS_LOB package: */

/* seeing if bfile is open with FILEISOPEN */

CREATE OR REPLACE PROCEDURE seeIfOpenBFILE_procOne IS
   Lob_loc      BFILE;
   RetVal       INTEGER;
BEGIN
   /* Select the LOB, initializing the BFILE locator: */
   SELECT Music INTO Lob_loc FROM Multimedia_tab
      WHERE Clip_ID = 3;
   RetVal := DBMS_LOB.FILEISOPEN(Lob_loc);
   IF (RetVal = 1)
      THEN
      DBMS_OUTPUT.PUT_LINE('File is open');
   ELSE
      DBMS_OUTPUT.PUT_LINE('File is not open');
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
