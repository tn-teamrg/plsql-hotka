/* Note that the example procedure displayLOB_proc is not part of the 
DBMS_LOB package: */ 

/* displaying lob data */

CREATE OR REPLACE PROCEDURE displayLOB_proc IS 
Lob_loc  BLOB; 
Buffer   RAW(1024); 
Amount   BINARY_INTEGER := 1024; 
Position INTEGER := 1; 
BEGIN 
   /* Select the LOB: */ 
   SELECT m.Map_obj.Drawing INTO Lob_loc 
   FROM Multimedia_tab m WHERE m.Clip_ID = 1; 
   /* Opening the LOB is optional: */ 
   DBMS_LOB.OPEN (Lob_loc, DBMS_LOB.LOB_READONLY); 
   LOOP 
      DBMS_LOB.READ (Lob_loc, Amount, Position, Buffer); 
      /* Display the buffer contents: */ 
      DBMS_OUTPUT.PUT_LINE(utl_raw.cast_to_varchar2(Buffer)); 
      Position := Position + Amount; 
   END LOOP; 
   /* Closing the LOB is mandatory if you have opened it: */ 
   DBMS_LOB.CLOSE (Lob_loc); 
   EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
         DBMS_OUTPUT.PUT_LINE('End of data'); 
END; 
/

SHOW ERRORS;
