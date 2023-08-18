/* Note that the example procedure appendLOB_proc is not part of the 
   DBMS_LOB package: */

/* appending one lob to another */

CREATE OR REPLACE PROCEDURE appendLOB_proc IS
   Dest_loc        BLOB;
   Src_loc         BLOB;
BEGIN
   /* Select the LOB, get the destination LOB locator: */
   SELECT Sound INTO Dest_loc FROM Multimedia_tab
      WHERE Clip_ID = 2
         FOR UPDATE;
   /* Select the LOB, get the destination LOB locator: */
   SELECT Sound INTO Src_loc FROM Multimedia_tab
      WHERE Clip_ID = 1;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Dest_loc, DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN (Src_loc, DBMS_LOB.LOB_READONLY);
   DBMS_LOB.APPEND(Dest_loc, Src_loc);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Dest_loc);
   DBMS_LOB.CLOSE (Src_loc);
COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
