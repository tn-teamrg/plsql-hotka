/* Note that the example procedure updateUseBindVariable_proc is not part of the 
   DBMS_LOB package: */

/* updating a bfile by initializing bfile locator */

CREATE OR REPLACE PROCEDURE updateUseBindVariable_proc (Lob_loc BFILE) IS
BEGIN
   UPDATE Multimedia_tab SET Photo = Lob_loc WHERE Clip_ID = 3;
END;
/
SHOW ERRORS;

DECLARE
   Lob_loc  BFILE;
BEGIN
   SELECT Photo INTO Lob_loc
      FROM Multimedia_tab
         WHERE Clip_ID = 1;
   updateUseBindVariable_proc (Lob_loc);
   COMMIT;
END;
/
