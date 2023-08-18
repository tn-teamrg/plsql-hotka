/* Note that the example procedure closeAllOpenFilesBFILE_proc is not part of 
   the DBMS_LOB package: */

/* closing all open bfiles */

CREATE OR REPLACE PROCEDURE closeAllOpenFilesBFILE_proc IS
BEGIN
   /* Close all open BFILEs: */
   DBMS_LOB.FILECLOSEALL;
END;
/
SHOW ERRORS;
