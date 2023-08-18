READ ME


Hi!

Thank you for participating in this course.

You can use ANY Oracle database, including the free Oracle Express found on Oracle.com (search on Oracle Express).

EDIT all scripts to change the TNS Connect string to your enviroment.

IF you are not comfortable with these scripts, please contact a senior IT person who works with the Oracle RDBMS or an Oracle DBA type at your company for assistance.

Copy the download files to a temp folder on your workstation such as C:\TEMP.  These will be used 
throughout the course.  Make sure the Resume.txt file is in the same folder as the TEMP_DIR setup in
the RUN_AS_SYS.sql script.

These 2 Oracle scripts will setup your database environment.  Follow the directions and seek help from
your company staff if you need help.  


USE SQL*Plus to run these scripts.  Start SQL*Plus from the folder where these scripts are located.

RUn the scripts in this order:


RUN_AS_SYS.sql     --  edit for passwords and connect strings location (both SYSTEM near the beginning and SYS near the end of the script) 
-- creates user0 account and assigns proper grants.


SETUP_Single_User.sql      -- builds tables for any user...connect to user account that will work the lab exercises...
                              example: login to sql*plus with the USER0 account and enter 'start setup_single_user'.  



You are now ready to work the examples and follow along with the instructor for the live lessons.


ANy questions?  Contact Dan:  dhotka@earthlink.net, 515 771-3935



