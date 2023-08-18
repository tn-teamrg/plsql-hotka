/* Note that the example procedure copyLOB_proc is not part of the 
   DBMS_LOB package: */

/* copying all or part of a lob to another lob */

CREATE OR REPLACE PROCEDURE copyLOB_proc IS
   Dest_loc     BLOB;
   Src_loc      BLOB;
   Amount       NUMBER;
   Dest_pos     NUMBER;
   Src_pos      NUMBER;
BEGIN
   SELECT Sound INTO Dest_loc FROM Multimedia_tab
      WHERE Clip_ID = 2 FOR UPDATE;
   /* Select the LOB: */
   SELECT Sound INTO Src_loc FROM Multimedia_tab
      WHERE Clip_ID = 1;
   /* Opening the LOBs is optional: */
   DBMS_LOB.OPEN(Dest_loc, DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
   /* Copies the LOB from the source position to the destination position: */
   DBMS_LOB.COPY(Dest_loc, Src_loc, Amount, Dest_pos, Src_pos);
   /* Closing LOBs is mandatory if you have opened them: */
   DBMS_LOB.CLOSE(Dest_loc);
   DBMS_LOB.CLOSE(Src_loc);
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
