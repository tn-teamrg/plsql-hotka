/* Note that the example procedure readLOB_proc is not part of the 
   DBMS_LOB package: */

/* reading data from lob */

CREATE OR REPLACE PROCEDURE readLOB_proc IS
    Lob_loc           BLOB;
    Buffer            RAW(32767);
    Amount            BINARY_INTEGER := 32767;
    Position          INTEGER := 1000;
    Chunksize         INTEGER;
BEGIN
    /* Select the LOB: */
   SELECT Frame INTO Lob_loc
      FROM Multimedia_tab
        WHERE Clip_ID = 1;
   /* Find out the chunksize for this LOB column: */
   Chunksize := DBMS_LOB.GETCHUNKSIZE(Lob_loc);
   IF (Chunksize < 32767) THEN
      Amount := (32767 / Chunksize) * Chunksize;
   END IF;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
   /* Read data from the LOB: */
   DBMS_LOB.READ (Lob_loc, Amount, Position, Buffer);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
END;
/

SHOW ERRORS;
