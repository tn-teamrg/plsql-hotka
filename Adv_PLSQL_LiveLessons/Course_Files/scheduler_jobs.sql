/**********************************************************************
 * File:        Scheduler_jobs.sql
 * Type:        SQL*Plus script
 * Author:      Dan Hotka
 * Date:        08-27-2012
 *
 * Description:
 *      SQL*Plus script to display the output from the USER_SCHEDULER_JOBS queue
 *
 * Modifications:
 *	
 *********************************************************************/
set linesize 100
column JOB_NAME format A10
column JOB_TYPE format A20
column JOB_ACTION format A20
column START_DATE format A20
column STATE format A10

select JOB_NAME, JOB_TYPE, JOB_ACTION, to_char(START_DATE,'MM/DD/YYYY HH:MI') START_DATE, STATE
from USER_SCHEDULER_JOBS;

