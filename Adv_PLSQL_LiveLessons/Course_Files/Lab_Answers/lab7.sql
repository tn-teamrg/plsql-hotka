
	create table EMP (ename varchar2(20));
	
	alter table EMP
	         add (inserted_by      varchar2(10),  
	              inserted_date        date    ,  
	              updated_by       varchar2(10),  
	              updated_date         date    ); 
	
	 create trigger UPD_EMP_trg
 	 before insert or update 
	     on EMP
 	    for each row 
	 begin 
	   if INSERTING then 
 	     :new.inserted_by   := USER; 
	     :new.inserted_date := SYSDATE; 
	     :new.updated_by    := null; 
 	     :new.updated_date  := null; 
 	   elsif UPDATING then 
	    :new.inserted_by   := :old.inserted_by; 
 	    :new.inserted_date := :old.inserted_date; 
 	    :new.updated_by    := USER; 
 	    :new.updated_date  := SYSDATE; 
 	   end if; 
 	 end;  
	/
 	

