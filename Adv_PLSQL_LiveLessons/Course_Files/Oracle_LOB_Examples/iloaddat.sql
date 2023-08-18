/* Note that the example procedure loadLOBFromBFILE_proc is not part of the 
   DBMS_LOB package: */

/* loading a lob with bfile data */

CREATE OR REPLACE PROCEDURE loadLOBFromBFILE_proc IS
   Dest_loc       BLOB;
   Src_loc        BFILE := BFILENAME('FRAME_DIR', 'Washington_frame');
   Amount         INTEGER := 4000;
BEGIN
   SELECT Frame INTO Dest_loc FROM Multimedia_tab
      WHERE Clip_ID = 3 FOR UPDATE;
   /* Opening the LOB is mandatory: */
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN(Dest_loc, DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, Amount);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE(Dest_loc);
   DBMS_LOB.CLOSE(Src_loc);
   COMMIT;
END;
/
SHOW ERRORS;

