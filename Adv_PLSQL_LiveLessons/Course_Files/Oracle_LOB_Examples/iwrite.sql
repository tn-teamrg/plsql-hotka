/* Note that the example procedure writeDataToLOB_proc is not part of the
   DBMS_LOB package: */

/* writing data to a lob */

CREATE or REPLACE PROCEDURE writeDataToLOB_proc IS
   Lob_loc         CLOB;
   Buffer          VARCHAR2(32767);
   Amount          BINARY_INTEGER := 32767;
   Position        INTEGER := 1;
   i               INTEGER;
BEGIN
   /* Select a LOB: */
   SELECT Story INTO Lob_loc
        FROM Multimedia_tab
           WHERE Clip_ID = 1
              FOR UPDATE;
   /* Opening the LOB is optional: */
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
   /* Fill the buffer with data to write to the LOB: */
   FOR i IN 1..3 LOOP
      DBMS_LOB.WRITE (Lob_loc, Amount, Position, Buffer);
      /* Fill the buffer with more data to write to the LOB: */
      Position := Position + Amount;
   END LOOP;
   /* Closing the LOB is mandatory if you have opened it: */
   DBMS_LOB.CLOSE (Lob_loc);
END;
/

/* We add a second example to show a case in which the buffer size and amount 
   differs from the first example: */
CREATE or REPLACE PROCEDURE writeDataToLOB_proc IS
   Lob_loc         CLOB;
   Buffer          VARCHAR2(32767);
   Amount          BINARY_INTEGER := 32767;
   Position        INTEGER;
   i               INTEGER;
   Chunk_size      INTEGER;
BEGIN
    SELECT Story INTO Lob_loc
        FROM Multimedia_tab
           WHERE Clip_ID = 1
              FOR UPDATE;
     /* Opening the LOB is optional: */
    DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READWRITE);
    Chunk_size := DBMS_LOB.GETCHUNKSIZE(Lob_loc);

    /* Fill the buffer with ∆Chunk_size∆ worth of data to write to
       the LOB. Use the chunk size (or a multiple of chunk size) when writing
       data to the LOB.  Make sure that you write within a chunk boundary and
       don∆t overlap different chunks within a single call to DBMS_LOB.WRITE. */

    Amount := Chunk_size;

    /* Write data starting at the beginning of the second chunk: */
    Position := Chunk_size + 1;
    FOR i IN 1..3 LOOP
        DBMS_LOB.WRITE (Lob_loc, Amount, Position, Buffer);
        /* Fill the buffer with more data (of size Chunk_size) to  write to
           the LOB: */
        Position := Position + Amount;
    END LOOP;
    /* Closing the LOB is mandatory if you have opened it: */
    DBMS_LOB.CLOSE (Lob_loc);
END;
/
