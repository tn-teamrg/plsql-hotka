/* Note that the example procedure openBFILE_procTwo is not part of the 
   DBMS_LOB package:  */

/* opening a bfile with OPEN */

CREATE OR REPLACE PROCEDURE openBFILE_procTwo IS 
  Lob_loc    BFILE := BFILENAME('PHOTO_DIR', 'Lincoln_photo'); 
BEGIN 
   /* Open the BFILE: */ 
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
   /* ... Do some processing: */ 
   DBMS_LOB.CLOSE(Lob_loc);
END; 
/
SHOW ERRORS;
