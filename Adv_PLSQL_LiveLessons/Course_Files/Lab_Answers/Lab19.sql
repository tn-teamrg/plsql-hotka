
CREATE OR REPLACE PROCEDURE Lab92_READ_BFILE IS
   v_resume     BFILE;
   v_amt        INTEGER := 255;
   v_len        INTEGER;
   v_pos        INTEGER := 1;
   v_text       varchar2(300);
   Buffer       RAW(255);
BEGIN
 
   SELECT RESUME INTO V_RESUME FROM EMP
   WHERE EMPNO = 7499; 
      
   DBMS_LOB.OPEN(v_resume, DBMS_LOB.LOB_READONLY);

   DBMS_LOB.READ(v_resume, v_amt, v_pos, Buffer);
   v_text := UTL_RAW.CAST_TO_VARCHAR2(Buffer);
   DBMS_OUTPUT.PUT_LINE(v_text);
-- or  DBMS_OUTPUT.PUT_LINE(UTL_RAW.CAST_TO_VARCHAR2(Buffer)); --  
   DBMS_LOB.CLOSE(v_resume);
END;
/

