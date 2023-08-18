rem 
rem	Sales Tracking Application Oracle9i Objects
rem	    Oracle9i Development By Example  
rem            by Dan Hotka
rem         Que Publications May 2001
rem         All Rights Reserved
rem
spool INSTALL_sales_tracking_objects.log

DROP TABLE st_inventory 	CASCADE CONSTRAINTS;
DROP SEQUENCE st_inv_seq;
DROP OBJECT address_field;
DROP TABLE st_parts 		CASCADE CONSTRAINTS;
DROP TABLE st_inv_type 		CASCADE CONSTRAINTS;
DROP TABLE st_inv_make 		CASCADE CONSTRAINTS;
DROP TABLE st_inv_model 	CASCADE CONSTRAINTS;
DROP TABLE st_vendor		CASCADE CONSTRAINTS;
DROP SEQUENCE st_vendor_seq;
DROP TABLE st_customer 		CASCADE CONSTRAINTS;
DROP TABLE st_staff 		CASCADE CONSTRAINTS;
DROP SEQUENCE st_staff_seq;
DROP TABLE st_bill_time 	CASCADE CONSTRAINTS;
DROP TABLE st_departments	CASCADE CONSTRAINTS;
DROP TABLE st_job_description	CASCADE CONSTRAINTS;
DROP TRIGGER st_inventory_trg;
DROP TRIGGER st_parts_trg;
DROP TRIGGER st_customer_trg;
DROP TRIGGER st_staff_trg;
DROP TRIGGER st_bill_time_trg;

CREATE TABLE st_inventory
	(inv_id			NUMBER(6) 	CONSTRAINT pk_inv_id PRIMARY KEY
						USING INDEX TABLESPACE users,
	inv_type                VARCHAR2(10),
	inv_make                VARCHAR2(10),
	inv_model               VARCHAR2(10),
	inv_color		VARCHAR(10),
	inv_year                NUMBER(4),
	inv_purchase_vendor_id	NUMBER(6),
	inv_purchase_amt	NUMBER(9,2) 	NOT NULL,
	inv_purchase_date	DATE 		NOT NULL,
	inv_purchase_photo	BLOB,
	inv_sale_customer_id	NUMBER(6),
	inv_sale_amt		NUMBER(9,2),
	inv_sale_date		DATE,
	inv_sale_photo		BLOB,
	inv_description		VARCHAR2(20),
	inv_insert_user 	VARCHAR2(20),
   	inv_insert_date 	DATE,
   	inv_update_user 	VARCHAR2(20),
   	inv_update_date 	DATE)
	TABLESPACE users
	PCTFREE 30
	PCTUSED	50
	STORAGE (INITIAL 10K
		NEXT 10K
		MINEXTENTS 5
		MAXEXTENTS 10)
	LOB (inv_purchase_photo, inv_sale_photo) STORE AS 
		(TABLESPACE users
		STORAGE (INITIAL 5K
			NEXT 5K
			MINEXTENTS 1
			MAXEXTENTS 100)
		NOCACHE 
		NOLOGGING);


CREATE SEQUENCE st_inv_seq 
	START WITH 1
	INCREMENT BY 1
	CACHE 10;

CREATE TRIGGER st_inventory_trg BEFORE INSERT OR UPDATE ON st_inventory
	FOR EACH ROW
	BEGIN
		IF :old.inv_insert_user IS NULL THEN
			:new.inv_insert_user := USER;
			:new.inv_insert_date := SYSDATE;
			:new.inv_update_user := NULL;
			:new.inv_update_date := NULL;
		ELSE
			:new.inv_insert_user := :old.inv_insert_user;
			:new.inv_insert_date := :old.inv_insert_date;
			:new.inv_update_user := USER;
			:new.inv_update_date := SYSDATE;
		END IF;
	END;
/

CREATE TABLE st_inv_type	
	(inv_type		VARCHAR(10))
	TABLESPACE users
	CACHE
	PCTFREE 1
	PCTUSED	90
	STORAGE (INITIAL 1K
		NEXT 1K
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE TABLE st_inv_make	
	(inv_make		VARCHAR(10))
	TABLESPACE users
	CACHE
	PCTFREE 1
	PCTUSED	90
	STORAGE (INITIAL 1K 
		NEXT 1K
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE TABLE st_inv_model	
	(inv_model		VARCHAR2(10))
	TABLESPACE users
	CACHE
	PCTFREE 1
	PCTUSED	90
	STORAGE (INITIAL 1K 
		NEXT 1K
		MINEXTENTS 1
		MAXEXTENTS 100);


CREATE TABLE st_vendor		
	(vendor_id		NUMBER(6) 	PRIMARY KEY,
	vendor_name		VARCHAR2(30) 	NOT NULL,
	vendor_street1		VARCHAR2(30),
	vendor_street2		VARCHAR2(30),
	vendor_city		VARCHAR2(20),
	vendor_state		VARCHAR2(2),
	vendor_zipcode		VARCHAR2(10),
	vendor_tax_id		VARCHAR2(20) 	NOT NULL)
	TABLESPACE users 
	STORAGE (INITIAL 5K 
		NEXT 5
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE SEQUENCE st_vendor_seq 
	START WITH 1
	INCREMENT BY 1
	CACHE 10;


ALTER TABLE st_inventory 	ADD CONSTRAINT fk_inv_purchase_vendor_id FOREIGN KEY (inv_purchase_vendor_id)
				REFERENCES sales_tracking.st_vendor(vendor_id);

CREATE TABLE st_customer	
	(customer_id		NUMBER(6) PRIMARY KEY,
	customer_name		VARCHAR2(30) NOT NULL,
	customer_street1	VARCHAR2(30),
	customer_street2	VARCHAR2(30),
	customer_city		VARCHAR2(20),
	customer_state		VARCHAR2(2),
	customer_zipcode	VARCHAR2(10),
   	customer_insert_user 	VARCHAR2(20),
   	customer_insert_date 	DATE,
   	customer_update_user 	VARCHAR2(20),
   	customer_update_date 	DATE)
	TABLESPACE users 
	STORAGE (INITIAL 5K 
		NEXT 5
		MINEXTENTS 1
		MAXEXTENTS 100);


CREATE TRIGGER st_customer_trg BEFORE INSERT OR UPDATE ON st_customer
	FOR EACH ROW
	BEGIN
		IF :old.customer_insert_user IS NULL THEN
			:new.customer_insert_user := USER;
			:new.customer_insert_date := SYSDATE;
			:new.customer_update_user := NULL;
			:new.customer_update_date := NULL;
		ELSE
			:new.customer_insert_user := :old.customer_insert_user;
			:new.customer_insert_date := :old.customer_insert_date;
			:new.customer_update_user := USER;
			:new.customer_update_date := SYSDATE;
		END IF;
	END;
/

ALTER TABLE st_inventory 	ADD CONSTRAINT fk_inv_customer_id FOREIGN KEY (inv_sale_customer_id)
				REFERENCES sales_tracking.st_customer(customer_id);

CREATE TABLE st_parts
	(part_inv_id		NUMBER(6) 	CONSTRAINT fk_part_inv_id 
						REFERENCES st_inventory (inv_id),
	part_vendor_id		NUMBER(6) 	CONSTRAINT fk_part_vendor_id 
						REFERENCES st_vendor (vendor_id),
	part_amt		NUMBER(8,2) 	NOT NULL,
	part_desc		VARCHAR2(20),
	part_date		DATE,
   	part_insert_user 	VARCHAR2(20),
   	part_insert_date 	DATE,
   	part_update_user 	VARCHAR2(20),
   	part_update_date 	DATE)
	TABLESPACE users 
	STORAGE (INITIAL 5K 
		NEXT 5
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE TRIGGER st_parts_trg BEFORE INSERT OR UPDATE ON st_parts
	FOR EACH ROW
	BEGIN
		IF :old.part_insert_user IS NULL THEN
			:new.part_insert_user := USER;
			:new.part_insert_date := SYSDATE;
			:new.part_update_user := NULL;
			:new.part_update_date := NULL;
		ELSE
			:new.part_insert_user := :old.part_insert_user;
			:new.part_insert_date := :old.part_insert_date;
			:new.part_update_user := USER;
			:new.part_update_date := SYSDATE;
		END IF;
	END;
/


CREATE TABLE st_departments
   	(dept_id 		NUMBER(6),
   	dept_name 		VARCHAR2(20))
	TABLESPACE users
	CACHE
	PCTFREE 1
	PCTUSED	90
	STORAGE (INITIAL 1K 
		NEXT 1K
		MINEXTENTS 1
		MAXEXTENTS 100);



ALTER TABLE st_departments ADD CONSTRAINT pk_dept_id PRIMARY KEY (dept_id)
	USING INDEX TABLESPACE users;


CREATE TABLE st_job_description 
   	(job_id 		NUMBER(6),
   	Job_descrition 		VARCHAR2(20))
	TABLESPACE users
	CACHE
	PCTFREE 1
	PCTUSED	90
	STORAGE (INITIAL 1K 
		NEXT 1K
		MINEXTENTS 1
		MAXEXTENTS 100);

ALTER TABLE st_job_description ADD CONSTRAINT pk_job_id PRIMARY KEY (job_id)
	USING INDEX TABLESPACE users;



CREATE TABLE st_staff 		
   	(staff_id    		NUMBER(6),
   	staff_name   		VARCHAR2(30),
	staff_street1		VARCHAR2(30),
	staff_street2		VARCHAR2(30),
	staff_city		VARCHAR2(20),
	staff_state		VARCHAR2(2),
	staff_zipcode		VARCHAR2(10),   	
	staff_dept_id 		NUMBER(6) 	NOT NULL,
   	staff_job_id 		NUMBER(6) 	NOT NULL,
   	staff_hiredate   	DATE 		NOT NULL,
   	staff_termdate 		DATE,
   	staff_hourly_rate  	NUMBER(6,2) 	NOT NULL,
   	staff_billing_rate   	NUMBER(6,2) 	NOT NULL,
   	staff_picture   	BLOB,
   	staff_insert_user 	VARCHAR2(20),
   	staff_insert_date 	DATE,
   	staff_update_user 	VARCHAR2(20),
   	staff_update_date 	DATE,
	CONSTRAINT pk_staff_id PRIMARY KEY (staff_id)
	USING INDEX TABLESPACE users,
	CONSTRAINT fk_staff_dept_id FOREIGN KEY (staff_dept_id)
	REFERENCES sales_tracking.st_departments (dept_id),
	CONSTRAINT fk_staff_job_id FOREIGN KEY (staff_job_id)
	REFERENCES sales_tracking.st_job_description (job_id))
	TABLESPACE users
	PCTFREE 30
	PCTUSED	50
	STORAGE (INITIAL 10K 
		NEXT 10K
		MINEXTENTS 5
		MAXEXTENTS 100)
	LOB (staff_picture) STORE AS 
		(TABLESPACE users
		STORAGE (INITIAL 5K
			NEXT 5K
			MINEXTENTS 1
			MAXEXTENTS 100)
		NOCACHE
		NOLOGGING);


CREATE SEQUENCE st_staff_seq 
	START WITH 1
	INCREMENT BY 1
	CACHE 10;

CREATE TRIGGER st_staff_trg BEFORE INSERT OR UPDATE ON st_staff
	FOR EACH ROW
	BEGIN
		IF :old.staff_insert_user IS NULL THEN
			:new.staff_insert_user := USER;
			:new.staff_insert_date := SYSDATE;
			:new.staff_update_user := NULL;
			:new.staff_update_date := NULL;
		ELSE
			:new.staff_insert_user := :old.staff_insert_user;
			:new.staff_insert_date := :old.staff_insert_date;
			:new.staff_update_user := USER;
			:new.staff_update_date := SYSDATE;
		END IF;
	END;
/

CREATE TABLE st_bill_time 	
   	(bt_staff_id	     	NUMBER(6),
   	bt_inv_id           	NUMBER(6),
   	bt_date          	DATE		NOT NULL,
   	bt_time			NUMBER(3)	NOT NULL,
   	bt_insert_user 		VARCHAR2(20),
   	bt_insert_date 		DATE,
   	bt_update_user 		VARCHAR2(20),
   	bt_update_date  	DATE,
	CONSTRAINT fk_bt_staff_id FOREIGN KEY (bt_staff_id)
	REFERENCES sales_tracking.st_staff(staff_id),
	CONSTRAINT fk_bt_inv_id FOREIGN KEY (bt_inv_id)
	REFERENCES sales_tracking.st_inventory(inv_id))
	TABLESPACE users
	PCTFREE 1
	PCTUSED	80
	STORAGE (INITIAL 5K 
		NEXT 5
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE INDEX st_bt_staff_id ON st_bill_time (bt_staff_id)
	TABLESPACE users
	STORAGE (INITIAL 5K 
		NEXT 5K
		MINEXTENTS 1
		MAXEXTENTS 100);

CREATE INDEX st_bt_inv_id ON st_bill_time (bt_inv_id)
	TABLESPACE users
	STORAGE (INITIAL 5K 
		NEXT 5K
		MINEXTENTS 1
		MAXEXTENTS 100);


CREATE TRIGGER st_bill_time_trg BEFORE INSERT OR UPDATE ON st_bill_time
	FOR EACH ROW
	BEGIN
		IF :old.bt_insert_user IS NULL THEN
			:new.bt_insert_user := USER;
			:new.bt_insert_date := SYSDATE;
			:new.bt_update_user := NULL;
			:new.bt_update_date := NULL;
		ELSE
			:new.bt_insert_user := :old.bt_insert_user;
			:new.bt_insert_date := :old.bt_insert_date;
			:new.bt_update_user := USER;
			:new.bt_update_date := SYSDATE;
		END IF;
	END;
/

spool off
exit
