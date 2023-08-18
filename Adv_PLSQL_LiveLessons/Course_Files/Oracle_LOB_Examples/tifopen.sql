/* Note that the example procedure seeTempLOBIsOpen_proc is not part of the 
   DBMS_LOB package. This procedure takes a locator as input, creates a  
   temporary LOB, opens it and tests if the LOB is open. */

/* seeing if a temporary lob is open */

CREATE OR REPLACE PROCEDURE seeTempLOBIsOpen_proc(Lob_loc IN OUT BLOB, 
                          Retval OUT INTEGER) IS
BEGIN
   /* Create the temporary LOB: */
   DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);
   /* See If the LOB is open: */
   Retval := DBMS_LOB.ISOPEN(Lob_loc);
  /* The value of Retval will be 1  if  the LOB is open. */
   /* Free the temporary LOB: */
   DBMS_LOB.FREETEMPORARY(Lob_loc);
END;
/
SHOW ERRORS;
