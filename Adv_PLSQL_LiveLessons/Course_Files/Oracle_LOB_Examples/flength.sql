/* Note that the example procedure getLengthBFILE_proc is not part of the 
   DBMS_LOB package: */

/* getting the length of a bfile */

CREATE OR REPLACE PROCEDURE getLengthBFILE_proc IS
   Lob_loc      BFILE;
   Length       INTEGER;
BEGIN
   /* Initialize the BFILE locator by selecting the LOB: */
   SELECT Mtab.Voiced_ref.Recording INTO Lob_loc FROM Multimedia_tab Mtab
      WHERE Mtab.Clip_ID = 3;
   /* Open the BFILE: */
   DBMS_LOB.OPEN(Lob_loc, DBMS_LOB.LOB_READONLY);
   /* Get the length of the LOB: */
   Length := DBMS_LOB.GETLENGTH(Lob_loc);
   IF Length IS NULL THEN
       DBMS_OUTPUT.PUT_LINE('BFILE is null.');
   ELSE
       DBMS_OUTPUT.PUT_LINE('The length is ' || length);
   END IF;
   /* Close the BFILE: */
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
SHOW ERRORS;
