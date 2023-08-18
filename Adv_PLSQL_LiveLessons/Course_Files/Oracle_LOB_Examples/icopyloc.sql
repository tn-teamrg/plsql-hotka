/* Note that the example procedure lobAssign_proc is not part of the 
   DBMS_LOB package. */

/* copying a lob locator */

CREATE OR REPLACE PROCEDURE lobAssign_proc IS 
  Lob_loc1    blob; 
  Lob_loc2    blob; 
BEGIN 
  SELECT Frame INTO Lob_loc1 FROM Multimedia_tab where Clip_ID = 1 FOR UPDATE; 
   /* Assign Lob_loc1 to Lob_loc2 thereby saving a copy of the value of the lob 
     at this point in time. */ 
  Lob_loc2 := Lob_loc1; 
  /* When you write some data to the lob through Lob_loc1, Lob_loc2 will not see 
     the newly written data whereas Lob_loc1 will see the new data. */ 
END; 
/

