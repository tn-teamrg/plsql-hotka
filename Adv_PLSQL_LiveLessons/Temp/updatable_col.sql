select column_name, updatable UPD, insertable INS,
   deletable DEL
from USER_UPDATABLE_COLUMNS
where table_name = upper('&view_name')
/
