select *
from V$PGASTAT
where name like 'total PGA%'
/
