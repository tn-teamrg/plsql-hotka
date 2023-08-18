/* Note that the example procedure openBFILE_procOne is not part of the 
   DBMS_LOB package: */

/* opening a bfile with FILEOPEN */

CREATE OR REPLACE PROCEDURE openBFILE_procOne IS 
   Lob_loc    BFILE := BFILENAME('PHOTO_DIR', 'Lincoln_photo'); 
BEGIN 
   /* Open the BFILE: */ 
   DBMS_LOB.FILEOPEN (Lob_loc, DBMS_LOB.FILE_READONLY);
   /* ... Do some processing. */ 
   DBMS_LOB.FILECLOSE(Lob_loc);
END; 
/
SHOW ERRORS;
