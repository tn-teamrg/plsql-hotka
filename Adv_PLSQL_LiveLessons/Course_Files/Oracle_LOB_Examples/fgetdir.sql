/* getting bfile directory alias and filename */

CREATE OR REPLACE PROCEDURE getNameBFILE_proc IS
   Lob_loc         BFILE;
   DirAlias_name   VARCHAR2(30);
   File_name       VARCHAR2(40);
BEGIN
   SELECT Music INTO Lob_loc FROM Multimedia_tab WHERE Clip_ID = 3;
   DBMS_LOB.FILEGETNAME(Lob_loc, DirAlias_name, File_name);
   /* do some processing based on the directory alias and file names */
END;
/
SHOW ERRORS;

