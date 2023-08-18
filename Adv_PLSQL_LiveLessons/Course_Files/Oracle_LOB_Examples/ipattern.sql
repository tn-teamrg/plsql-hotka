/* Note that the example procedure instringLOB_proc is not part of the 
   DBMS_LOB package: */

/* seeing if pattern exists in lob (instr) */

CREATE OR REPLACE PROCEDURE instringLOB_proc IS
   Lob_loc        CLOB;
   Pattern        VARCHAR2(30) := 'children';
   Position       INTEGER := 0;
   Offset         INTEGER := 1;
   Occurrence     INTEGER := 1;
BEGIN
   /* Select the LOB: */
   SELECT Story INTO Lob_loc
      FROM Multimedia_tab
         WHERE Clip_ID = 1;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY);
   /* Seek for the pattern: */
   Position := DBMS_LOB.INSTR(Lob_loc, Pattern, Offset, Occurrence);
   IF Position = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Pattern not found');
   ELSE
      DBMS_OUTPUT.PUT_LINE('The pattern occurs at '|| position);
   END IF;
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
END;
/

SHOW ERRORS;

