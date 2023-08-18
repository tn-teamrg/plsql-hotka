
/* inserting a row containing by initializing a bfile locator */

DECLARE
  /* Initialize the BFILE locator: */ 
  Lob_loc  BFILE := BFILENAME('PHOTO_DIR', 'Washington_photo');
BEGIN
    INSERT INTO Multimedia_tab (Clip_ID, Photo) VALUES (3, Lob_loc);
    COMMIT;
END;
/
