/* Note that the example procedure closeBFILE_procTwo is not part of the 
   DBMS_LOB package: */

/* closing a bfile with CLOSE */

CREATE OR REPLACE PROCEDURE closeBFILE_procTwo IS
   Lob_loc    BFILE := BFILENAME('PHOTO_DIR', 'Lincoln_photo');
BEGIN
   DBMS_LOB.OPEN(Lob_loc, DBMS_LOB.LOB_READONLY);
   /* ...Do some processing. */
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
SHOW ERRORS;
