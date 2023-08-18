SELECT ename
from EMP
where deptno in
   (select DEPTNO from DEPT);
