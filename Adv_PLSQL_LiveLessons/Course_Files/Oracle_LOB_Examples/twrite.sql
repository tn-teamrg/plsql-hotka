/* Note that the example procedure writeDataToTempLOB_proc is not part of the 
   DBMS_LOB package. */

/* writing data to a temporary lob */

CREATE or REPLACE PROCEDURE writeDataToTempLOB_proc IS
   Lob_loc         CLOB;
   Buffer          VARCHAR2(26);
   Amount          BINARY_INTEGER := 26;
   Position        INTEGER := 1;
   i               INTEGER;
BEGIN
    DBMS_LOB.CREATETEMPORARY(Lob_loc,TRUE,DBMS_LOB.SESSION);
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Fill the buffer with data to write to the LOB: */
   Buffer := 'abcdefghijklmnopqrstuvwxyz';

   FOR i IN 1..3 LOOP
      DBMS_LOB.WRITE (Lob_loc, Amount, Position, Buffer);
      /* Fill the buffer with more data to write to the LOB: */
      Position := Position + Amount;
   END LOOP;
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
   DBMS_LOB.FREETEMPORARY(Lob_loc);
END;
/
SHOW ERRORS;


