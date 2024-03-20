-- 실수형 데이터가 있는 테이블 생성
USE doitsql;

CREATE TABLE doit_float (col_1 FLOAT);

INSERT INTO doit_float VALUES (0.7);

SELECT * FROM doit_float WHERE col_1 = 0.7;

-- 암시적 형 변환으로 계산 결과가 출력된 예
SELECT 10/3;


-- 문자열 데이터의 길이와 크기 확인
USE doitsql;

CREATE TABLE doit_char_varchar (
col_1 CHAR(5),
col_2 VARCHAR(5)
);

INSERT INTO doit_char_varchar VALUES ('12345', '12345');
INSERT INTO doit_char_varchar VALUES ('ABCDE', 'ABCDE');
INSERT INTO doit_char_varchar VALUES ('가나다라마', '가나다라마');
INSERT INTO doit_char_varchar VALUES ('hello', '안녕하세요');
INSERT INTO doit_char_varchar VALUES ('安寧安寧安', '安寧安寧安');

SELECT
	col_1, 
	CHAR_LENGTH(col_1) as char_length, 
	LENGTH(col_1) AS char_byte,col_2, 
	CHAR_LENGTH(col_2) as char_length, 
	LENGTH(col_2) AS char_byte
FROM doit_char_varchar;

-- 저장 공간을 초과한 예
USE doitsql;

CREATE TABLE doit_table_byte (
col_1 VARCHAR(16383)
); 	--생성 성공
	
CREATE TABLE doit_table_byte (
col_1 VARCHAR(16383),
col_2 VARCHAR(10)
); --생성 실패

-- MySQL의 문자 집합 확인
SHOW CHARACTER SET;

-- 콜레이션에 따른 정렬 순서 비교를 위한 테이블 생성
CREATE TABLE doit_collation (
col_latin1_general_ci VARCHAR(10) COLLATE latin1_general_ci,
col_latin1_general_cs VARCHAR(10) COLLATE latin1_general_cs,
col_latin1_bin VARCHAR(10) COLLATE latin1_bin,
col_latin7_general_ci VARCHAR(10) COLLATE latin7_general_ci
);
INSERT INTO doit_collation VALUES ('a', 'a', 'a', 'a');
INSERT INTO doit_collation VALUES ('b', 'b', 'b', 'b');
INSERT INTO doit_collation VALUES ('A', 'A', 'A', 'A');
INSERT INTO doit_collation VALUES ('B', 'B', 'B', 'B');
INSERT INTO doit_collation VALUES ('*', '*', '*', '*');
INSERT INTO doit_collation VALUES ('_', '_', '_', '_');
INSERT INTO doit_collation VALUES ('!', '!', '!', '!');
INSERT INTO doit_collation VALUES ('1', '1', '1', '1');
INSERT INTO doit_collation VALUES ('2', '2', '2', '2');

-- 콜레이션에 따른 정렬 순서 확인
SELECT col_latin1_general_ci FROM doit_collation ORDER BY col_latin1_general_ci;

SELECT col_latin1_general_cs FROM doit_collation ORDER BY col_latin1_general_cs;

SELECT col_latin1_bin FROM doit_collation ORDER BY col_latin1_bin;

SELECT col_latin7_general_ci FROM doit_collation ORDER BY col_latin7_general_ci;

-- 데이터 유형에 따른 현재 시간 조회
CREATE TABLE date_table(
justdate DATE,
justtime TIME,
justdatetime DATETIME,
justtimestamp TIMESTAMP);

INSERT INTO date_table VALUES (now(), now(), now(), now());

SELECT * FROM date_table;