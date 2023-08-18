/* Note that the example procedure trimLOB_proc is not part of the 
   DBMS_LOB package: */

/* trimming lob data */

CREATE OR REPLACE PROCEDURE trimLOB_proc IS
   Lob_loc        CLOB;
BEGIN
   /* Select the LOB, get the LOB locator: */
   SELECT Mtab.Voiced_ref.Script INTO Lob_loc FROM Multimedia_tab Mtab
      WHERE Mtab.Clip_ID = 2
         FOR UPDATE;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Trim the LOB data: */
   DBMS_LOB.TRIM(Lob_loc,100);
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
