/* Note that the example procedure compareBFILEs_proc is not part of the 
   DBMS_LOB package: */

/* comparing all or part of two bfiles */

CREATE OR REPLACE PROCEDURE compareBFILEs_proc IS
   /* Initialize the BFILE locator: */
   Lob_loc1       BFILE := BFILENAME('PHOTO_DIR', 'RooseveltFDR_photo');
   Lob_loc2       BFILE;
   Retval         INTEGER;
BEGIN
   /* Select the LOB: */
   SELECT Photo INTO Lob_loc2 FROM Multimedia_tab
      WHERE Clip_ID = 3;
   /* Open the BFILEs: */
   DBMS_LOB.OPEN(Lob_loc1, DBMS_LOB.LOB_READONLY);
   DBMS_LOB.OPEN(Lob_loc2, DBMS_LOB.LOB_READONLY);
   Retval := DBMS_LOB.COMPARE(Lob_loc2, Lob_loc1, DBMS_LOB.LOBMAXSIZE, 1, 1);
   /* Close the BFILEs: */
   DBMS_LOB.CLOSE(Lob_loc1);
   DBMS_LOB.CLOSE(Lob_loc2);
END;
/
SHOW ERRORS;
