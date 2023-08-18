/* Note that the example procedure compareTwoLOBs_proc is not part of the 
   DBMS_LOB package: */

/* comparing all or part of lob */

CREATE OR REPLACE PROCEDURE compareTwoLOBs_proc IS
    Lob_loc1            BLOB;
    Lob_loc2            BLOB;
    Amount              INTEGER := 32767;
    Retval              INTEGER;
BEGIN
    /* Select the LOB: */
    SELECT Frame INTO Lob_loc1 FROM Multimedia_tab
        WHERE Clip_ID = 1;
    SELECT Frame INTO Lob_loc2 FROM Multimedia_tab
        WHERE Clip_ID = 2;
    /* Opening the LOB is optional: */
    DBMS_LOB.OPEN (Lob_loc1, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.OPEN (Lob_loc2, DBMS_LOB.LOB_READONLY);
    /* Compare the two frames: */
    retval := DBMS_LOB.COMPARE(Lob_loc1, Lob_loc2, Amount, 1, 1);
    IF retval = 0 THEN
       DBMS_OUTPUT.PUT_LINE('Processing for equal frames');
    ELSE
       DBMS_OUTPUT.PUT_LINE('Processing for non-equal frames');
    END IF;
    /* Closing the LOB is mandatory if you have opened it: */
    DBMS_LOB.CLOSE (Lob_loc1);
    DBMS_LOB.CLOSE (Lob_loc2);
END;
/

SHOW ERRORS;
