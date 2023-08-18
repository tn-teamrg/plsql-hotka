/* See also the CREATETEMPORARY procedure in Oracle8i Supplied Packages
   Reference, Volume 1, Chapter 17.*/

/* creating a temporary lob */

DECLARE
   Dest_loc       BLOB;
   Src_loc        BLOB;
   Amount         INTEGER := 4000;
BEGIN
   SELECT Frame INTO Src_loc FROM Multimedia_tab WHERE Clip_ID = 1;
    /* Create a temporary LOB: */
   DBMS_LOB.CREATETEMPORARY(Dest_loc,TRUE, DBMS_LOB.SESSION);
   /* Copy the entire frame from the Src_loc to the Temporary Lob: */
   DBMS_LOB.COPY(Dest_loc,Src_loc,DBMS_LOB.GETLENGTH(Src_loc),1,1);
   DBMS_LOB.FREETEMPORARY(Dest_loc);
END;
/

