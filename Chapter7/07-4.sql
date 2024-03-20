-- 일부 열을 보여주는 뷰 생성
CREATE VIEW v_customer
AS
	SELECT first_name, last_name, email FROM customer;

SELECT* FROM v_customer;

-- 2개의 테이블을 조인해 원하는 데이터를 보여주는 뷰 생성
CREATE VIEW v_payuser
AS
	SELECT 
		first_name, last_name, email, amount, address_id
	FROM customer AS a
		INNER JOIN (
			SELECT 
				customer_id, SUM(amount) AS amount 
			FROM payment
			GROUP BY customer_id
			) AS b ON a.customer_id = b.customer_id;

SELECT * FROM v_payuser;

-- 뷰 테이블과 일반 테이블 조인
SELECT a.*, b.*
FROM v_payuser AS a
	INNER JOIN address AS b ON a.address_id = b.address_id;

-- 뷰 수정
ALTER VIEW v_customer
AS
	SELECT 
		customer_id, first_name, last_name, email, address_id
	FROM customer;

SELECT * FROM v_customer;

-- v_customer 뷰 생성 및 교체
CREATE OR REPLACE VIEW v_customer
AS
	SELECT '뷰가 이미 있으면 수정, 없으면 생성';

SELECT * FROM v_customer;

-- 뷰 정보 확인
DESCRIBE v_payuser;

-- SQL 문으로 뷰 정보 확인
SHOW CREATE VIEW v_payuser;

-- 뷰 삭제
DROP VIEW v_customer;
DROP VIEW v_payuser;

-- 테이블과 뷰 생성
CREATE TABLE tbl_a (
col_1 INT NOT NULL,
col_2 VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_b (
col_1 INT NOT NULL,
col_2 VARCHAR(50) NOT NULL
);

INSERT INTO tbl_a VALUES(1, 'tbl_a_1');
INSERT INTO tbl_a VALUES(2, 'tbl_a_2');
INSERT INTO tbl_b VALUES(1, 'tbl_b_1');
INSERT INTO tbl_b VALUES(2, 'tbl_b_2');

CREATE VIEW v_tbl_a
AS
	SELECT col_1, col_2 FROM tbl_a;


SELECT * FROM v_tbl_a;

-- 단일 뷰 데이터 수정
SET SQL_SAFE_UPDATES = 0;

UPDATE v_tbl_a SET col_2 = 'tbl_a 열 수정' WHERE col_1 = 1;

SELECT * FROM v_tbl_a;

-- 단일 뷰 데이터 추가
INSERT v_tbl_a VALUES (3, 'tbl_a_3');

SELECT * FROM v_tbl_a;

-- 단일 뷰 데이터 삭제
DELETE FROM v_tbl_a WHERE col_1 = 3;

SELECT * FROM v_tbl_a;

-- 새로운 뷰 생성 후 데이터 추가
CREATE VIEW v_tbl_a2
AS
	SELECT col_1 FROM tbl_a;

INSERT v_tbl_a2 VALUES (5);

-- 복합 뷰 생성
CREATE VIEW v_tbl_a_b
AS
	SELECT
		a.col_1 as a_col_1,
		a.col_2 as a_col_2,
		b.col_2 as b_col_2
	FROM tbl_a AS a
		INNER JOIN tbl_b AS b ON a.col_1 = b.col_1;


SELECT * FROM v_tbl_a_b;

-- 복합 뷰 데이터 수정
UPDATE v_tbl_a_b SET a_col_2 = 'tbl_a 컬럼 수정', b_col_2 = 'tbl_b 컬럼 수정' WHERE a_col_1 = 1;

-- 복합 뷰 데이터 입력
INSERT v_tbl_a_b VALUES (3, 'tbl_a_3', 'tbl_b_3');

-- 참조 테이블 삭제
DROP TABLE tbl_a;

-- 참조 테이블 삭제된 뷰 조회
SELECT * FROM v_tbl_a_b;

-- 뷰 정보 확인
CHECK TABLE tbl_a_b;

