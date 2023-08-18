/* Note that the example procedure closeBFILE_procOne is not part of the 
   DBMS_LOB package: */

/* closing a bfile with FILECLOSE */

CREATE OR REPLACE PROCEDURE closeBFILE_procOne IS
   Lob_loc    BFILE := BFILENAME('PHOTO_DIR', 'Lincoln_photo');
BEGIN
   DBMS_LOB.FILEOPEN(Lob_loc, DBMS_LOB.FILE_READONLY);
   /* ...Do some processing. */
   DBMS_LOB.FILECLOSE(Lob_loc);
END;
/
SHOW ERRORS;
