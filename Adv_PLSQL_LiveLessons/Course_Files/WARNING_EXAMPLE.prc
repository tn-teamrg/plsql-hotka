CREATE OR REPLACE PROCEDURE warning_example
IS
   cursor emp_cur is
        select ename
        from emp;
   loop_counter   NUMBER := 0;
   ename   varchar2(10);

var1 number(3);
var2 char(2);
cntr  varchar2(10);

BEGIN
   open emp_cur;
   fetch emp_cur into ename;
   while emp_cur%FOUND
   LOOP
      loop_counter := loop_counter + 1;
      DBMS_OUTPUT.put_line
          ('Record ' || loop_counter || ' is Employee ' || ename );
      fetch emp_cur into ename;
   END LOOP;
   
 for i in (select ename from emp)
 LOOP
      dbms_output.put_line(i.ename);
  END LOOP;
   
   for cntr in 1 .. 10000
   loop
        var1 := var1 + 1;
   end loop;
   
     for var1 in 1 .. 10000
   loop
        var2 := var1 + 1;
   end loop;

   DBMS_OUTPUT.put_line ('Procedure Looping Example is done');

   close emp_cur;
   
 goto skip_code;
 
var2 := var1 + 1; 

<<skip_code>>

dbms_output.put_line('bye bye');

END;
/