/* Note that the example procedure lobIsOpen_proc is not part of the 
   DBMS_LOB package: */

/* seeing if lob is open */

CREATE OR REPLACE PROCEDURE lobIsOpen_proc IS
   Lob_loc     BLOB;
   Retval      INTEGER;
BEGIN
   SELECT Frame INTO Lob_loc  FROM Multimedia_tab where Clip_ID = 1;

   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc , DBMS_LOB.LOB_READONLY);

   /* See if the LOB is open: */
   Retval := DBMS_LOB.ISOPEN(Lob_loc);
  /* The value of Retval will be 1 meaning that the LOB is open. */
END;
/
SHOW ERRORS;
