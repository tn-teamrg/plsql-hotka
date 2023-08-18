
	alter table EXAMPLE_TABLE
	         add (inserted_by      varchar2(10),  
	              inserted_date        date    ,  
	              updated_by       varchar2(10),  
	              updated_date         date    ); 
	
	 create trigger trg_EXAMPLE_TABLE
 	 before insert or update 
	     on EXAMPLE_TABLE
 	    for each row 
	 begin 
	  if :old.inserted_by is null then 
 	     :new.inserted_by   := USER; 
	     :new.inserted_date := SYSDATE; 
	     :new.updated_by    := null; 
 	     :new.updated_date  := null; 
 	   else  
	    :new.inserted_by   := :old.inserted_by; 
 	    :new.inserted_date := :old.inserted_date; 
 	    :new.updated_by    := USER; 
 	    :new.updated_date  := SYSDATE; 
 	    end if; 
 	 end;  
	/
 	

