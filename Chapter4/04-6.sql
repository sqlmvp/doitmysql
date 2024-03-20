-- 첫 번째 열에 AUTO_INCREMENT 적용
USE doitsql;

CREATE TABLE doit_increment (
col_1 INT AUTO_INCREMENT PRIMARY KEY,
col_2 VARCHAR(50),
col_3 INT
);
INSERT INTO doit_increment (col_2, col_3) VALUES ('1 자동 입력', 1);
INSERT INTO doit_increment (col_2, col_3) VALUES ('2 자동 입력', 2);

SELECT * FROM doit_increment;

-- 자동 입력되는 값과 동일한 값을 입력한 경우
INSERT INTO doit_increment (col_1, col_2, col_3) VALUES (3, '3 자동 입력', 3);

SELECT * FROM doit_increment;

-- 자동 입력되는 값보다 큰 값을 입력한 경우
INSERT INTO doit_increment (col_1, col_2, col_3) VALUES (5, '4 건너뛰고 5 자동 입력', 5);

SELECT * FROM doit_increment;

-- 1열을 제외하고 데이터 입력한 경우
INSERT INTO doit_increment (col_2, col_3) VALUES ('어디까지 입력되었을까?', 0);

SELECT * FROM doit_increment;

-- AUTO_INCREMENT가 적용된 열의 마지막 데이터 조회
SELECT LAST_INSERT_ID();

-- 자동으로 입력되는 값을 100부터 시작
ALTER TABLE doit_increment AUTO_INCREMENT=100;

INSERT INTO doit_increment (col_2, col_3) VALUES ('시작값이 변경되었을까?', 0);

SELECT * FROM doit_increment;

-- 자동으로 입력되는 값이 5씩 증가
SET @@AUTO_INCREMENT_INCREMENT = 5;

INSERT INTO doit_increment (col_2, col_3) VALUES ('5씩 증가할까? (1)', 0);
INSERT INTO doit_increment (col_2, col_3) VALUES ('5씩 증가할까? (2)', 0);

SELECT * FROM doit_increment;

-- INSERT INTO와 SELECT로 다른 테이블에 결과 입력
CREATE TABLE doit_insert_select_from (
col_1 INT,
col_2 VARCHAR(10)
);

CREATE TABLE doit_insert_select_to (
col_1 INT,
col_2 VARCHAR(10)
);

INSERT INTO doit_insert_select_from VALUES (1, 'Do');
INSERT INTO doit_insert_select_from VALUES (2, 'It');
INSERT INTO doit_insert_select_from VALUES (3, 'MySQL');

INSERT INTO doit_insert_select_to
SELECT * FROM doit_insert_select_from;

SELECT * FROM doit_insert_select_to;

-- INSERT INTO와 SELECT로 다른 테이블에 결과 입력
CREATE TABLE doit_select_new AS (SELECT * FROM doit_insert_select_from);

SELECT * FROM doit_select_new;

-- 부모 테이블과 자식 테이블 생성
CREATE TABLE doit_parent (col_1 INT PRIMARY KEY);
CREATE TABLE doit_child (col_1 INT);

ALTER TABLE doit_child
ADD FOREIGN KEY (col_1) REFERENCES doit_parent(col_1);

-- 자식 테이블에 데이터 입력 시 부모 테이블에 해당 데이터가 없는 경우
INSERT INTO doit_child VALUES (1);

-- 부모 테이블에 데이터 입력 후 자식 테이블에도 데이터 입력
INSERT INTO doit_parent VALUES (1);
INSERT INTO doit_child VALUES (1);

SELECT * FROM doit_parent;
SELECT * FROM doit_child;

-- 부모 테이블에서만 데이터를 삭제한 경우
DELETE FROM doit_parent WHERE col_1 = 1;

-- 자식 테이블의 데이터 삭제 후 부모 테이블의 데이터 삭제
DELETE FROM doit_child WHERE col_1 = 1;
DELETE FROM doit_parent WHERE col_1 = 1;

-- 부모 테이블을 삭제할 경우
DROP TABLE doit_parent;

-- 하위 테이블 삭제 후 상위 테이블 삭제
DROP TABLE doit_child;
DROP TABLE doit_parent;

-- 부모 테이블 생성 후 제약 조건 확인
CREATE TABLE doit_parent (col_1 INT PRIMARY KEY);
CREATE TABLE doit_child (col_1 INT);

SHOW CREATE TABLE doit_child;

-- 제약 조건 제거 후 상위 테이블 삭제
ALTER TABLE doit_child
DROP CONSTRAINT doit_child_ibfk_1;

DROP TABLE doit_parent;