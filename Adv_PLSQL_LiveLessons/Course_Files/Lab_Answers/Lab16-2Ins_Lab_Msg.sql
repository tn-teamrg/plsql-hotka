Create or Replace Procedure DynamicLabMsg (
IN_MSG IN varchar2 )
AS
Begin
    EXECUTE IMMEDIATE ('insert into LAB_MSG values 
       (USER,SYSDATE,:v_msg) ')
    USING IN_MSG;
     COMMIT;
End;
/