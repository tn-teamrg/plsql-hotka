

ALTER TABLE EMP ADD (RESUME BFILE);

UPDATE EMP SET RESUME = (BFILENAME('TEMPDIR','RESUME.TXT'))
   WHERE EMPNO = 7499;

COMMIT;

