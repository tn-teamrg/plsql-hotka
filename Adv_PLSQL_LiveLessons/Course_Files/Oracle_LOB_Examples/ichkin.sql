/* Note that the example procedure checkInLOB_proc is not part of the 
   DBMS_LOB package: */

/* checking in a lob */

CREATE OR REPLACE PROCEDURE checkInLOB_proc IS
    Lob_loc        CLOB;
    Buffer         VARCHAR2(32767);
    Amount         BINARY_INTEGER := 32767;
    Position       INTEGER := 2147483647;
    i              INTEGER;
BEGIN
    /* Select the LOB: */
    SELECT Intab.Transcript INTO Lob_loc
        FROM TABLE(SELECT Mtab.InSeg_ntab FROM Multimedia_tab Mtab
                   WHERE Clip_ID = 2) Intab
        WHERE Intab.Segment = 1
        FOR UPDATE;
    /* Opening the LOB is optional: */
    DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
    FOR i IN 1..3 LOOP
        /* Fill the Buffer with data to be written. */
        /* Write data: */
        DBMS_LOB.WRITE (Lob_loc, Amount, Position, Buffer);
        Position := Position + Amount;
    END LOOP;
    /* Closing the LOB is mandatory if you have opened it: */
    DBMS_LOB.CLOSE (Lob_loc);

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Operation failed');
END;
/

SHOW ERRORS;








