create or replace TYPE emp_ename_table IS TABLE OF varchar2(10);


create or replace FUNCTION RUN_SQL (IN_SQL_TEXT IN VARCHAR2) RETURN emp_ename_table 
PIPELINED
IS
    type sql_cursor_type is REF CURSOR;
    sql_cursor sql_cursor_type;
    
    sql_rec emp_ename_table;
       
BEGIN
    OPEN sql_cursor FOR IN_SQL_TEXT;
    FETCH sql_cursor BULK COLLECT INTO sql_rec;
    CLOSE sql_cursor;

    FOR i in 1 .. sql_rec.COUNT
    LOOP
       PIPE ROW(sql_rec(i));
    END LOOP;
    
    RETURN;
    
END RUN_SQL;
    
    
    
    
select * from TABLE(RUN_SQL ('select ename from EMP'));