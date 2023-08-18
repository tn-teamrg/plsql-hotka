/* Note that the example procedure readBFILE_proc is not part of the 
   DBMS_LOB package: */

/* reading data from a bfile */

CREATE OR REPLACE PROCEDURE readBFILE_proc IS
   Lob_loc       BFILE := BFILENAME('PHOTO_DIR', 'Jefferson_photo');
   Amount        INTEGER := 32767;
   Position      INTEGER := 1;
   Buffer        RAW(32767);
BEGIN
   /* Select the LOB: */  
   SELECT Photo INTO Lob_loc FROM Multimedia_tab 
      WHERE Clip_ID = 3;
   /* Open the BFILE: */  
   DBMS_LOB.OPEN(Lob_loc, DBMS_LOB.LOB_READONLY);
   /* Read data: */  
   DBMS_LOB.READ(Lob_loc, Amount, Position, Buffer);
   /* Close the BFILE: */  
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
SHOW ERRORS;
