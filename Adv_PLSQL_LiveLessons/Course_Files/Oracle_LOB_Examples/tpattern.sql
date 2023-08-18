/* Note that the example procedure instringTempLOB_proc is not part of the 
   DBMS_LOB package. See also the "INSTR" function, in the Oracle8i Supplied
   Packages Reference,Volume 1, Chapter 17.*/

/* seeing is a pattern exists in a temporary lob (instr) */

CREATE OR REPLACE PROCEDURE instringTempLOB_proc IS
   Lob_loc        CLOB;
   Temp_clob      CLOB;
   Pattern        VARCHAR2(30) := 'children';
   Position       INTEGER := 0;
   Offset         INTEGER := 1;
   Occurrence     INTEGER := 1;
BEGIN
   /* Create the temp LOB and copy a CLOB into it: */
   DBMS_LOB.CREATETEMPORARY(Temp_clob,TRUE, DBMS_LOB.SESSION);
   SELECT Story INTO Lob_loc
      FROM Multimedia_tab
         WHERE Clip_ID = 1;

   DBMS_LOB.OPEN(Temp_clob,DBMS_LOB.LOB_READWRITE);
   DBMS_LOB.OPEN(Lob_loc,DBMS_LOB.LOB_READONLY);
   /* Copy the CLOB into the temp CLOB: */
   DBMS_LOB.COPY(Temp_clob,Lob_loc,DBMS_LOB.GETLENGTH(Lob_loc),1,1);
   /* Seek the pattern in the temp CLOB: */
   Position := DBMS_LOB.INSTR(Temp_clob, Pattern, Offset, Occurrence);
   IF Position = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Pattern not found');
   ELSE
      DBMS_OUTPUT.PUT_LINE('The pattern occurs at '|| position);
   END IF;
   DBMS_LOB.CLOSE(Lob_loc);
   DBMS_LOB.CLOSE(Temp_clob);
   /* Free the temporary LOB: */
   DBMS_LOB.FREETEMPORARY(Temp_clob);
END;
/
SHOW ERRORS;
