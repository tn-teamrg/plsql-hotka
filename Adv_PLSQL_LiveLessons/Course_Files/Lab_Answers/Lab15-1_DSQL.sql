CREATE OR REPLACE PROCEDURE DSQL
AS
    CurID       integer;
    v_rows      number;
    v_ename     EMP.ENAME%TYPE;
Begin
    CurID := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CurID,'SELECT ENAME FROM EMP',1);
    DBMS_SQL.DEFINE_COLUMN(CurID,1,v_ename,10);
    v_rows := DBMS_SQL.EXECUTE(CurID);
    WHILE DBMS_SQL.FETCH_ROWS(CurID) > 0
    LOOP
        DBMS_SQL.COLUMN_VALUE(CurID,1,v_ename);
        DBMS_OUTPUT.PUT_LINE('Ename = ' || v_ename );
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(CurID);
END DSQL;
/



