-- 실습을 위한 테이블과 데이터 생성
USE doitsql;

DROP TABLE IF EXISTS doit_clusterindex;

CREATE TABLE doit_clusterindex (
col_1 INT,
col_2 VARCHAR(50),
col_3 VARCHAR(50)
);

INSERT INTO doit_clusterindex VALUES (2, '사자', 'lion');
INSERT INTO doit_clusterindex VALUES (5, '호랑이', 'tiger');
INSERT INTO doit_clusterindex VALUES (3, '얼룩말', 'zbera');
INSERT INTO doit_clusterindex VALUES (4, '코뿔소', 'Rhinoceros');
INSERT INTO doit_clusterindex VALUES (1, '거북이', 'turtle');

SELECT * FROM doit_clusterindex;

-- 기본키(기본 인덱스) 생성
ALTER TABLE doit_clusterindex
	ADD CONSTRAINT PRIMARY KEY (col_1);

SELECT * FROM doit_clusterindex;

-- 새로운 데이터 입력
INSERT INTO doit_clusterindex VALUES (0, '물고기', 'fish');

SELECT * FROM doit_clusterindex;

-- col_2 열로 인덱스 변경
ALTER TABLE doit_clusterindex
	DROP PRIMARY KEY,
	ADD CONSTRAINT PRIMARY KEY doit_clusterindex (col_2);

SELECT * FROM doit_clusterindex;

-- col_3 열로 인덱스 변경
ALTER TABLE doit_clusterindex
	DROP PRIMARY KEY,
	ADD CONSTRAINT PRIMARY KEY (col_3);

SELECT * FROM doit_clusterindex;

-- 복합키 인덱스 생성
ALTER TABLE doit_clusterindex
	DROP PRIMARY KEY,
	ADD CONSTRAINT PRIMARY KEY(col_1, col_3);

SHOW INDEX FROM doit_clusterindex;

-- 인덱스 삭제
ALTER TABLE doit_clusterindex DROP PRIMARY KEY;

SHOW INDEX FROM doit_clusterindex;

-- 실습을 위한 테이블과 데이터 생성
USE doitsql;

DROP TABLE IF EXISTS doit_nonclusterindex;

CREATE TABLE doit_nonclusterindex (
col_1 INT,
col_2 VARCHAR(50),
col_3 VARCHAR(50)
);

INSERT INTO doit_nonclusterindex VALUES (2, '사자', 'lion');
INSERT INTO doit_nonclusterindex VALUES (5, '호랑이', 'tiger');
INSERT INTO doit_nonclusterindex VALUES (3, '얼룩말', 'zbera');
INSERT INTO doit_nonclusterindex VALUES (4, '코뿔소', 'Rhinoceros');
INSERT INTO doit_nonclusterindex VALUES (1, '거북이', 'turtle');

SELECT * FROM doit_nonclusterindex;

-- 비클러스터형 인덱스 생성
CREATE INDEX ix_doit_nonclusterindex_1 ON doit_nonclusterindex (col_1);

SELECT * FROM doit_nonclusterindex;

-- 새로운 데이터 입력
INSERT INTO doit_nonclusterindex VALUES (0, '물고기', 'fish');

SELECT * FROM doit_nonclusterindex;

-- 각 열별로 인덱스 생성
CREATE INDEX ix_doit_nonclusterindex_2 ON doit_nonclusterindex (col_2);
CREATE INDEX ix_doit_nonclusterindex_3 ON doit_nonclusterindex (col_3);

SELECT * FROM doit_nonclusterindex;

-- 복합키 인덱스 생성
CREATE INDEX ix_doit_nonclusterindex_1_2 ON doit_nonclusterindex (col_1, col_2);
CREATE INDEX ix_doit_nonclusterindex_1_3 ON doit_nonclusterindex (col_1, col_3);

SHOW INDEX FROM doit_nonclusterindex;

-- 인덱스 삭제
DROP INDEX ix_doit_nonclusterindex_1_2 ON doit_nonclusterindex;
DROP INDEX ix_doit_nonclusterindex_1_3 ON doit_nonclusterindex;

SHOW INDEX FROM doit_nonclusterindex;