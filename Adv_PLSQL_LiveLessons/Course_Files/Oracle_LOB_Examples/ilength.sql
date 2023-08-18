/* Note that the example procedure getLengthLOB_proc is not part of the 
   DBMS_LOB package: */

/* getting the length of a lob */

CREATE OR REPLACE PROCEDURE getLengthLOB_proc IS
   Lob_loc     NCLOB;
   Length      INTEGER;
BEGIN
   /* Select the LOB: */
   SELECT FLSub INTO Lob_loc FROM Multimedia_tab
       WHERE Clip_ID = 2;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
   /* Get the length of the LOB: */
   length := DBMS_LOB.GETLENGTH(Lob_loc);
   IF length IS NULL THEN
       DBMS_OUTPUT.PUT_LINE('LOB is null.');
   ELSE
       DBMS_OUTPUT.PUT_LINE('The length is '|| length);
   END IF;
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
END;
/
SHOW ERRORS;
