
/**********************************************************************
 * File:        Proc_Shell.sql
 * Type:        SQL*Plus script
 * Author:      Dan Hotka
 * Date:        10-20-2010
 *
 * Description:
 *      SQL*Plus script to create a procedure to profile function calls
 *
 * Modifications:
 *	
 *********************************************************************/


/* use this to profile your functions! */





create or replace procedure proc_shell as

myvar number;

begin

myvar := <put your function here>;
dbms_output.put_line('Function Output = ' || myvar);
end;
/

