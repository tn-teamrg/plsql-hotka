/* Note that the example procedure compareTwoTmpPerLOBs_proc is not part 
   of the DBMS_LOB package. For further information on the procedures used 
   below, see the Oracle8i Supplied Packages Reference,Volume 1, Chapter 17. */

/* comparing all or part of two temporary lobs */

CREATE OR REPLACE PROCEDURE compareTwoTmpPerLOBs_proc IS
    Lob_loc1 BLOB;
    Lob_loc2 BLOB;
    Temp_loc BLOB;
    Amount   INTEGER := 32767;
    Retval   INTEGER;
BEGIN
    /* Select the LOB: */
    SELECT Frame INTO Lob_loc1 FROM Multimedia_tab
        WHERE Clip_ID = 1;
    SELECT Frame INTO Lob_loc2 FROM Multimedia_tab
        WHERE Clip_ID = 2;
    /* Copy a frame into a temp LOB and convert it to a different format */
    /* before comparing the frames : */
    DBMS_LOB.CREATETEMPORARY(Temp_loc, TRUE, DBMS_LOB.SESSION);
    DBMS_LOB.OPEN(Temp_loc, DBMS_LOB.LOB_READWRITE);
    DBMS_LOB.OPEN(Lob_loc1, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.OPEN(Lob_loc2, DBMS_LOB.LOB_READONLY);
    /* Copy the persistent LOB into the temp LOB: */
    DBMS_LOB.COPY(Temp_loc,Lob_loc2,DBMS_LOB.GETLENGTH(Lob_loc2),1,1);
    /* Perform some conversion function on the temp LOB before comparing it*/
    /* ...some_conversion_format_function(Temp_loc); */
    retval := DBMS_LOB.COMPARE(Lob_loc1, Temp_loc, Amount, 1, 1);
    IF retval = 0 THEN
       DBMS_OUTPUT.PUT_LINE('Processing for equal frames');
    ELSE
       DBMS_OUTPUT.PUT_LINE('Processing for non-equal frames');
    END IF;
    DBMS_LOB.CLOSE(Temp_loc);
    DBMS_LOB.CLOSE(Lob_loc1);
    DBMS_LOB.CLOSE(Lob_loc2);
    /* Free the temporary LOB now that we are done using it: */
    DBMS_LOB.FREETEMPORARY(Temp_loc);
    END;
/
SHOW ERRORS;




