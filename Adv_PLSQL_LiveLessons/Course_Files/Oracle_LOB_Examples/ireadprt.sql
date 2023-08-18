/* Note that the example procedure substringLOB_proc is not part of the 
   DBMS_LOB package: */

/* reading portion of lob (substr) */

CREATE OR REPLACE PROCEDURE substringLOB_proc IS
    Lob_loc           BLOB;
    Amount            BINARY_INTEGER := 32767;
    Position          INTEGER := 1024;
    Buffer            RAW(32767);
BEGIN
    /* Select the LOB: */
    SELECT Sound INTO Lob_loc FROM Multimedia_tab
       WHERE Clip_ID = 1;
    /* Opening the LOB is optional: */
    DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
    Buffer := DBMS_LOB.SUBSTR(Lob_loc, Amount, Position);
    /* Process the data */
    /* Closing the LOB is mandatory if you have opened it: */
    DBMS_LOB.CLOSE (Lob_loc);
END;
/

SHOW ERRORS;

/* In the following SQL statement, 255 is the amount to read 
   and 1 is the starting offset from which to read: */
SELECT DBMS_LOB.SUBSTR(Sound, 255, 1) FROM Multimedia_tab WHERE Clip_ID = 1;

