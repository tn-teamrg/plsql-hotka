/* Note that the example procedure lobWriteAppend_proc is not part of the 
   DBMS_LOB package: */

/* writing to the end of lob (write append) */

CREATE OR REPLACE PROCEDURE lobWriteAppend_proc IS
   Lob_loc    BLOB;
   Buffer     RAW(32767);
   Amount     Binary_integer := 32767;
BEGIN
   SELECT Frame INTO Lob_loc FROM Multimedia_tab where Clip_ID = 1 FOR UPDATE;
   /* Fill the buffer with data... */
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Append the data from the buffer to the end of the LOB: */
   DBMS_LOB.WRITEAPPEND(Lob_loc, Amount, Buffer);
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE(Lob_loc);
END;
/
