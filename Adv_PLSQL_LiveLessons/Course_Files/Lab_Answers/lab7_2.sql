	
create or replace trigger UPDATE_EMP_SAL_trg
before update of SAL 
    on EMP
for each row 
DECLARE
v_msg   varchar2(50);
PRAGMA AUTONOMOUS_TRANSACTION;
begin 
    v_msg := 'SAL Change from  ' || :OLD.SAL || ' to ' || :NEW.SAL ;
    insert into LAB_MSG values (user,sysdate,v_msg);
    commit;
end;  
/
 	

