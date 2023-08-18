DECLARE
   v_dname dept.dname%type;
BEGIN
   DBMS_OUTPUT.put_line ('Show Errors and Stacks');
   
   v_dname := dept_lookup(21);

   DBMS_OUTPUT.put_line('Dept 20 is ' || v_dname);

EXCEPTION
   WHEN OTHERS
   THEN
      dbms_output.put_line('Format Call Stack');
      dbms_output.put_line(dbms_utility.format_call_Stack);
      dbms_output.put_line('Format Error Stack');
      dbms_output.put_line(dbms_utility.format_error_stack);
      dbms_output.put_line('Format Error Backtrace');
      dbms_output.put_line(dbms_utility.format_error_backtrace);
      dbms_output.put_line('SQLCODE and SQLERRM');
      DBMS_OUTPUT.put_line (SQLCODE);
      DBMS_OUTPUT.put_line (SQLERRM);
      DBMS_OUTPUT.put_line (SQLERRM (SQLCODE));
END;