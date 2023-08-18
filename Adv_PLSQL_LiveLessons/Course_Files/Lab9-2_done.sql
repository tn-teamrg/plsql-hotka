CREATE OR REPLACE PROCEDURE read_bfile is
	v_resume BFILE;
	v_amt integer := 255;
	v_dir varchar2(20);
	v_file varchar2(20);
	v_len integer;
	v_pos integer := 1;
	v_text varchar2(300);
	buffer raw(255);
	v_progress integer := 0;
BEGIN

	
	-- select the lob
	select resume into v_resume from emp
	where empno=7499;
	
	-- get length
	v_len := DBMS_LOB.GETLENGTH(v_resume);
	
	-- get name
	--v_file := DBMS_LOB.FILEGETNAME(v_resume, v_dir, v_file);
	
	-- open the bfile
	DBMS_LOB.OPEN(v_resume, DBMS_LOB.LOB_READONLY);
	
	while (v_progress < v_len)
	loop
		DBMS_LOB.READ(v_resume, v_amt, v_pos, buffer);
		v_text := UTL_RAW.CAST_TO_VARCHAR2(buffer);
		dbms_output.put_line(v_text);
		
		v_progress := v_progress + v_amt;
		v_pos := v_pos + v_amt;
		
	end loop;
	DBMS_LOB.CLOSE(v_resume);
	
END;
/
show errors