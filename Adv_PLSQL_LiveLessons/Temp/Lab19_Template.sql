
CREATE OR REPLACE PROCEDURE Lab19_BFILE IS
   v_resume     BFILE;
   v_amt        INTEGER := 255;
   v_len        INTEGER;
   v_pos        INTEGER := 1;
   v_text       varchar2(300);
   Buffer       RAW(255);
BEGIN

  
  
   DBMS_LOB.OPEN(v_resume, DBMS_LOB.LOB_READONLY);
  


   DBMS_LOB.CLOSE(v_resume);
END;
/

