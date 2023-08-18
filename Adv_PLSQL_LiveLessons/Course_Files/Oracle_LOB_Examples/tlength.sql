/* Note that the example procedure getLengthTempCLOB_proc is not part of the 
   DBMS_LOB package. For a description of the other DBMS_LOB procedures used
   below, see the Oracle8i Supplied Packages Reference,Volume 1.*/

/* getting the length of a temporary lob */

CREATE OR REPLACE PROCEDURE getLengthTempCLOB_proc IS
   Length      INTEGER;
   tlob        CLOB;
   bufc        VARCHAR2(8);
   Amount      NUMBER;
   pos         NUMBER;
   Src_loc     BFILE := BFILENAME('AUDIO_DIR', 'Washington_audio');
BEGIN
    DBMS_LOB.CREATETEMPORARY(tlob,TRUE,DBMS_LOB.SESSION);
    /* Opening the LOB is optional: */
    DBMS_LOB.OPEN(tlob,DBMS_LOB.LOB_READWRITE);
    /* Opening the file is mandatory: */
    DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);
    Amount := 32767;
    DBMS_LOB.LOADFROMFILE(tlob, Src_loc, Amount);
    /* Get the length of the LOB: */
    length := DBMS_LOB.GETLENGTH(tlob);
    IF length = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LOB is empty.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The length is ' || length);
    END IF;
     /* Must close any lobs that were opened: */
    DBMS_LOB.CLOSE(tlob);
    DBMS_LOB.CLOSE(Src_loc);
    /* Free the temporary LOB now that we are done with it: */
    DBMS_LOB.FREETEMPORARY(tlob);
END;
/
SHOW ERRORS;
