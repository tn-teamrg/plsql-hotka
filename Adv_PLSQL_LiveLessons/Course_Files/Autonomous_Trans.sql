CREATE TABLE LAB_MSG (
    MSG_USER  varchar2(10),
    MSG_DATE  date,
    MSG       varchar2(50)
    );
/


CREATE or REPLACE PROCEDURE RECORD_LAB_MSG 
(p_user VARCHAR2, p_date DATE, p_msg VARCHAR2)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

INSERT INTO LAB_MSG VALUES (p_user, p_date, p_msg);

COMMIT;

END;
/


-- Test --

set autocommit off

select ename, sal from emp where empno = 7369;

update emp set sal = sal * 1.1 
where empno = 7369;

exec RECORD_LAB_MSG(USER,SYSDATE,'Empno 7369 salary change');

ROLLBACK;

select ename, sal from emp where empno = 7369;

select * from lab_msg;
