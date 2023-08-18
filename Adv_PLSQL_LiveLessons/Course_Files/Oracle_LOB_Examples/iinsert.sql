/* Note that the example procedure insertUseBindVariable_proc is not part of 
the DBMS_LOB package.   */

/* inserting a row by initializing lob locator bind variable */

CREATE OR REPLACE PROCEDURE insertUseBindVariable_proc 
   (Rownum IN NUMBER, Blob_loc IN BLOB) IS
BEGIN
   INSERT INTO Multimedia_tab (Clip_ID, Sound) VALUES (Rownum, Blob_loc);
END;
/
SHOW ERRORS;

DECLARE
   Blob_loc  BLOB;
BEGIN
   /* Select the LOB from the row where Clip_ID = 1, 
      Initialize the LOB locator bind variable: */
   SELECT Sound INTO Blob_loc
      FROM Multimedia_tab
      WHERE Clip_ID = 1;
  /* Insert into the row where Clip_ID = 2: */
  insertUseBindVariable_proc (2, Blob_loc);
  COMMIT;
END;
/
