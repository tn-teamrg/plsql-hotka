BEGIN

for rec in SELECT OBJECT_NAME FROM USER_OBJECT where OBJECT_TYPE = 'TABLE'
LOOP
   EXECUTE IMMEDIATE  'alter table ' || rec.OBJECT_NAME || 
                      ' add (inserted_by      varchar2(10), ' || 
                      ' inserted_date         date    , ' || 
                      ' updated_by            varchar2(10), 
                      ' updated_date          date    ) ';
   
   DBMS_OUTUT.PUT_LINE('Table ' || rec.OBJECT_NAME || ' altered.');
END LOOP;
END;
       




