CREATE TABLE dept
(
  deptno numeric(2,0) NOT NULL,
  dname character varying(14),
  loc character varying(13),
  versionno numeric(8,0),
  active numeric(1,0),
  CONSTRAINT dept_pkey PRIMARY KEY (deptno)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE dept IS '部署';
COMMENT ON COLUMN dept.deptno IS '部署番号';
COMMENT ON COLUMN dept.dname IS '部署名';
COMMENT ON COLUMN dept.loc IS '所在地';
COMMENT ON COLUMN dept.versionno IS 'バージョン番号';
COMMENT ON COLUMN dept.active IS '状態';

