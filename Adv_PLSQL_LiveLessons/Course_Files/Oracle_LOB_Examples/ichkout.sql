/* Note that the example procedure checkOutLOB_proc is not part of the 
   DBMS_LOB package: */

/* checking out a lob */

CREATE OR REPLACE PROCEDURE checkOutLOB_proc IS
    Lob_loc     CLOB;
    Buffer      VARCHAR2(32767);
    Amount      BINARY_INTEGER := 32767;
    Position    INTEGER := 2147483647;
BEGIN
   /* Select the LOB: */
   SELECT Intab.Transcript INTO Lob_loc
       FROM TABLE(SELECT Mtab.InSeg_ntab FROM Multimedia_tab Mtab
          WHERE Mtab.Clip_ID = 1) Intab
             WHERE Intab.Segment = 1;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
   LOOP
      DBMS_LOB.READ (Lob_loc, Amount, Position, Buffer);
      /* Process the buffer: */
      Position := Position + Amount;
   END LOOP;
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('End of data');
END;
/
SHOW ERRORS;
