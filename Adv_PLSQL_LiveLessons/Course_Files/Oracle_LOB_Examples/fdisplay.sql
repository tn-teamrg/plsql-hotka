/* Note that the example procedure displayBFILE_proc is not part of the 
DBMS_LOB package: */ 

/* displaying bfile data */

CREATE OR REPLACE PROCEDURE displayBFILE_proc IS 
   Lob_loc  BFILE; 
   Buffer   RAW(1024); 
   Amount   BINARY_INTEGER := 1024; 
   Position INTEGER        := 1; 
BEGIN 
   /* Select the LOB: */ 
   SELECT Music INTO Lob_loc 
   FROM Multimedia_tab WHERE Clip_ID = 1; 
   /* Opening the BFILE: */ 
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY); 
   LOOP 
      DBMS_LOB.READ (Lob_loc, Amount, Position, Buffer); 
      /* Display the buffer contents: */ 
      DBMS_OUTPUT.PUT_LINE(utl_raw.cast_to_varchar2(Buffer)); 
      Position := Position + Amount; 
   END LOOP; 
   /* Closing the BFILE: */ 
   DBMS_LOB.CLOSE (Lob_loc); 
   EXCEPTION 
   WHEN NO_DATA_FOUND THEN 
      DBMS_OUTPUT.PUT_LINE('End of data'); 
END; 
/
SHOW ERRORS;
