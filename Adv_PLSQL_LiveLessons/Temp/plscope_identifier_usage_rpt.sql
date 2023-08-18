/**********************************************************************
 * File:        plscope_identifier_usage_rpt.sql
 * Type:        SQL*Plus/TOAD script
 * Author:      Dan Hotka
 * Date:        07-28-2011
 *
 * Description:
 *      This script prints out information collected from PL/SCOPE.  This script
 *      comes from the Oracle Documentation Database SQL Developer User's Guide 
 *
 * Modifications:
 *	
 *********************************************************************/

WITH v AS (
  SELECT    Line,
            Col,
            INITCAP(NAME) Name,
            LOWER(TYPE)   Type,
            LOWER(USAGE)  Usage,
            USAGE_ID,
            USAGE_CONTEXT_ID
    FROM USER_IDENTIFIERS
        WHERE Object_Name = upper('&Object_Name')
          AND Object_Type = upper('&Object_Type')
)
SELECT RPAD(LPAD(' ', 2*(Level-1)) ||
                 Name, 20, '.')||' '||
                 RPAD(Type, 20)||
                 RPAD(Usage, 20)
                 IDENTIFIER_USAGE_CONTEXTS
  FROM v
  START WITH USAGE_CONTEXT_ID = 0
  CONNECT BY PRIOR USAGE_ID = USAGE_CONTEXT_ID
  ORDER SIBLINGS BY Line, Col
/
