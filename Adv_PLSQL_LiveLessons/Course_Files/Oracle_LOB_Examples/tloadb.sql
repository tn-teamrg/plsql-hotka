/* See also the FreeTemporary procedure in the Oracle8i Supplied Packages
   Reference, Volume 1, Chapter 17.
   Note that the example procedure freeTempLob_proc is not part of the 
   DBMS_LOB package: */

/* loading a temp lob with data from bfile */

CREATE or REPLACE PROCEDURE freeTempLob_proc(Lob_loc IN OUT BLOB) IS
BEGIN
   DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);
   /* Use the temporary LOB locator here, then free it.*/
   /* Free the temporary LOB locator: */
   DBMS_LOB.FREETEMPORARY(Lob_loc);
   DBMS_OUTPUT.PUT_LINE('Temporary LOB was freed');
END;
/
SHOW ERRORS;

