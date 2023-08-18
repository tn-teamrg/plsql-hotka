/* Note that the example procedure BFILEAssign_proc is not part of the 
   DBMS_LOB package:  */

/* copying a lob locator for a bfile */

CREATE OR REPLACE PROCEDURE BFILEAssign_proc IS
   Lob_loc1    BFILE;
   Lob_loc2    BFILE;
BEGIN
   SELECT Photo INTO Lob_loc1 FROM Multimedia_tab WHERE Clip_ID = 3
      FOR UPDATE;
   /* Assign Lob_loc1 to Lob_loc2 so that they both refer to the same operating
      system file: */
   Lob_loc2 := Lob_loc1;
   /* Now you can read the bfile from either Lob_loc1 or Lob_loc2. */
END;
/
SHOW ERRORS;
