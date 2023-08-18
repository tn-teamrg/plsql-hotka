/* See also the "ISTEMPORARY Function" in the Oracle8i Supplied Packages
   Reference, Volume 1, Chapter 17. 
   This is also an example of freeing a temporary LOB. First we test to make
   sure that the LOB locator points to a temporary LOB, then we free it.
   Otherwise, we issue an error: */

/* seeing if lob is temporary */

CREATE or REPLACE PROCEDURE freeTempLob_proc(Lob_loc IN OUT BLOB) IS
BEGIN
   /* Free the temporary LOB locator passed in. */
   /* First check to make sure that the locator is pointing to a temporary 
      LOB:*/
    IF DBMS_LOB.ISTEMPORARY(Lob_loc) = 1 THEN
       /* Free the temporary LOB locator: */
        DBMS_LOB.FREETEMPORARY(Lob_loc);
        DBMS_OUTPUT.PUT_LINE(' temporary LOB was freed');
    ELSE
        /* Print an error: */
        DBMS_OUTPUT.PUT_LINE(
           'Locator passed in was not a temporary LOB locator');
    END IF;
END;
/
SHOW ERRORS;
