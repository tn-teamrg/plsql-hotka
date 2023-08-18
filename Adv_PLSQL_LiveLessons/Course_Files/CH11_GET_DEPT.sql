CREATE OR REPLACE PACKAGE my_pkg AUTHID DEFINER IS
  TYPE dept_refcur IS REF CURSOR RETURN dept%ROWTYPE;
  TYPE deptrec_typ IS RECORD (
    deptno    NUMBER(2),
    dname  VARCHAR2(14),
    loc  VARCHAR2(13)
  );
  TYPE outrecset IS TABLE OF deptrec_typ;
  FUNCTION get_dept (p1 dept_refcur) RETURN outrecset PIPELINED;
END my_pkg;

CREATE OR REPLACE PACKAGE BODY my_pkg IS
  FUNCTION get_dept (
    p1 dept_refcur
  ) RETURN outrecset PIPELINED
  IS
    out_rec deptrec_typ;
    in_rec p1%ROWTYPE;
  BEGIN
    
    LOOP
      FETCH p1 INTO in_rec;
      EXIT WHEN p1%NOTFOUND;
      out_rec.deptno := in_rec.deptno;
      out_rec.dname := in_rec.dname;
      out_rec.loc := in_rec.loc;
      PIPE ROW(out_rec);
    END LOOP;
    CLOSE p1;
    RETURN;
  END get_dept;
END my_pkg;




select * from table(my_pkg.get_dept(CURSOR(select * from dept)));


