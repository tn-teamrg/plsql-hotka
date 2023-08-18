/**********************************************************************
 * File:        plscope_variable_usage_rpt.sql
 * Type:        SQL*Plus/TOAD script
 * Author:      Dan Hotka
 * Date:        07-28-2011
 *
 * Description:
 *      This script prints out information collected from PL/SCOPE.   
 *
 * Modifications:
 *	
 *********************************************************************/

  SELECT    Line,
            Col,
            INITCAP(NAME) Name,
            LOWER(TYPE)   Type,
            LOWER(USAGE)  Usage,
            LINE
      FROM USER_IDENTIFIERS
      WHERE Object_Name = upper('&Object_Name'
        AND Object_Type = upper('&Object_Type'
        AND Type = '
        AND Usage in ('DECLARATION','ASSIGNMENT');
/
