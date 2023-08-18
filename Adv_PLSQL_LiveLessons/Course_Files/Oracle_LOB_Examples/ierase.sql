/* Note that the example procedure eraseLOB_proc is not part of the 
   DBMS_LOB package: */

/* erasing part of a lob */

CREATE OR REPLACE PROCEDURE eraseLOB_proc IS
   Lob_loc        BLOB;
   Amount         INTEGER := 3000;
BEGIN
   /* Select the LOB, get the LOB locator: */
   SELECT Sound INTO lob_loc FROM Multimedia_tab
      WHERE Clip_ID = 1
         FOR UPDATE;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Erase the data: */
   DBMS_LOB.ERASE(Lob_loc, Amount, 2000);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
COMMIT;
/* Exception handling: */
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/
SHOW ERRORS;
