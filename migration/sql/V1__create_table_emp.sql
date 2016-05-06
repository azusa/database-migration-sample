CREATE TABLE EMP(
	EMPNO NUMERIC(4) NOT NULL PRIMARY KEY
	,ENAME VARCHAR(10)
	,JOB VARCHAR(9),MGR NUMERIC(4)
	,HIREDATE DATE,SAL NUMERIC(7,2)
	,COMM NUMERIC(7,2)
	,DEPTNO NUMERIC(2)
	,TSTAMP TIMESTAMP
);

COMMENT ON TABLE emp IS '従業員';
COMMENT ON COLUMN emp.empno IS '社員番号';
COMMENT ON COLUMN emp.ename IS '氏名';
COMMENT ON COLUMN emp.job IS '職種';
COMMENT ON COLUMN emp.mgr IS '上長';
COMMENT ON COLUMN emp.hiredate IS '入社日';
COMMENT ON COLUMN emp.sal IS '基本給';
COMMENT ON COLUMN emp.comm IS '歩合給';
COMMENT ON COLUMN emp.deptno IS '部署';
COMMENT ON COLUMN emp.tstamp IS 'タイムスタンプ';
