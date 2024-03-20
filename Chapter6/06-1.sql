-- CONCAT 함수로 열 이름과 문자열 연결
SELECT CONCAT(first_name, ', ', last_name) AS customer_name FROM customer;

-- CONCAT_WS 함수로 구분자 지정
SELECT CONCAT_WS(', ', first_name, last_name, email) AS customer_name FROM customer;

-- CONCAT 함수로 NULL과 열 이름 연결
SELECT CONCAT(NULL, first_name, last_name) AS customer_name FROM customer;

-- CONCAT_WS 인자로 NULL이 있는 경우
SELECT CONCAT_WS(', ', first_name, NULL, last_name) as customer_name FROM customer;

-- 문자열을 부호 없는 정수형으로 변경
SELECT
4 / '2',
4 / 2,
4 / CAST('2' AS UNSIGNED);

-- NOW 함수로 현재 날짜와 시간 출력
SELECT NOW();

-- CAST 함수로 날짜형을 숫자형으로 변환
SELECT CAST(NOW() AS SIGNED);

-- CAST 함수로 숫자형을 날짜형으로 변환
SELECT CAST(20230819 AS DATE);

-- CAST 함수로 숫자형을 문자열로 변환
SELECT CAST(20230819 AS CHAR);

-- CONVERT 함수로 날짜형을 정수형으로 변환
SELECT CONVERT(NOW(), SIGNED);

-- CONVERT 함수로 숫자형을 날짜형으로 변환
SELECT CONVERT(20230819, DATE);

-- CHAR로 데이터 길이 지정
SELECT CONVERT(20230819, CHAR(5));

-- 오버플로 발생 예
SELECT 9223372036854775807 + 1;

-- CAST 함수로 오버플로 방지
SELECT CAST(9223372036854775807 AS UNSIGNED) + 1;

-- CONVERT함수로 오버플로 방지
SELECT CONVERT(9223372036854775807, UNSIGNED) + 1;

-- 테이블 생성
CREATE TABLE doit_null (
col_1 INT,
col_2 VARCHAR(10),
col_3 VARCHAR(10),
col_4 VARCHAR(10),
col_5 VARCHAR(10)
);

INSERT INTO doit_null VALUES (1, NULL, 'col_3', 'col_4', 'col_5');
INSERT INTO doit_null VALUES (2, NULL, NULL, NULL, 'col_5');
INSERT INTO doit_null VALUES (3, NULL, NULL, NULL, NULL);
SELECT * FROM doit_null;

-- IFNULL 함수로 col_2열의 NULL 대체
SELECT col_1, IFNULL(col_2, '') AS col_2, col_3, col_4, col_5
FROM doit_null WHERE col_1 = 1;

-- IFNULL 함수로 col_3열의 NULL 대체
SELECT col_1, IFNULL(col_2, col_3) AS col_2, col_3, col_4, col_5
FROM doit_null WHERE col_1 = 1;

-- COALESCE 함수로 NULL을 다른 데이터로 대체: 마지막 인자에 데이터가 있는 경우
SELECT col_1, COALESCE(col_2, col_3, col_4, col_5)
FROM doit_null WHERE col_1 = 2;

-- COALESCE 함수로 NULL을 다른 데이터로 대체: 마지막 인자에도 NULL이 있는 경우
SELECT col_1, COALESCE(col_2, col_3, col_4, col_5)
FROM doit_null WHERE col_1 = 3;

-- LOWER 함수로 소문자를, UPPER 함수로 대문자로 변경
SELECT 'Do it! SQL', LOWER('Do it! SQL'), UPPER('Do it! SQL');

-- LOWER 함수로 소문자를, UPPER 함수로 대문자로 변경
SELECT email, LOWER(email), UPPER(email) FROM customer;

-- LTRIM 함수로 왼쪽 공백 제거
SELECT ' Do it! MySQL', LTRIM(' Do it! MySQL');

-- RTRIM 함수로 오른쪽 공백 제거
SELECT 'Do it! MySQL ', RTRIM('Do it! MySQL ');

-- TRIM 함수로 양쪽 공백 제거
SELECT ' Do it! MySQL ', TRIM(' Do it! MySQL ');

-- TRIM 함수로 양쪽 문자 제거
SELECT TRIM(BOTH '#' FROM '# Do it! MySQL #');

-- LENGTH 함수로 문자열의 크기 반환
SELECT LENGTH('Do it! MySQL'), LENGTH('두잇 마이에스큐엘');

-- LENGTH 함수로 다양한 문자의 크기 반환
SELECT LENGTH('A'), LENGTH('강'), LENGTH('漢'), LENGTH('◁'), LENGTH(' ');

-- CHAR_LENGTH 함수로 문자열의 개수 반환
SELECT CHAR_LENGTH('Do it! MySQL'), CHAR_LENGTH('두잇 마이에스큐엘');

-- LENGTH와 CHAR_LENGTH 함수에 열 이름 전달
SELECT first_name, LENGTH(first_name), CHAR_LENGTH(first_name) FROM customer;

-- POSITION 함수로 특정 문자까지의 크기 반환
SELECT 'Do it!! SQL', POSITION('!' IN 'Do it!! MySQL');

-- 탐색 문자가 없는 경우
SELECT 'Do it!! SQL', POSITION('#' IN 'Do it!! MySQL');

-- LEFT와 RIGHT 함수로 왼쪽과 오른쪽 2개의 문자열 반환
SELECT 'Do it! MySQL', LEFT('Do it! MySQL', 2), RIGHT('Do it! MySQL', 2);

-- SUBSTRING 함수로 지정한 범위의 문자열 반환
SELECT 'Do it! MySQL', SUBSTRING('Do it! MySQL', 4, 2);

-- SUBSTRING 함수에 열 이름 전달
SELECT first_name, SUBSTRING(first_name, 2, 3) FROM customer;

-- SUBSTRING과 POSITOIN 함수 조합
SELECT SUBSTRING('abc@email.com', 1, POSITION('@' IN 'abc@email.com') -1);

-- REPLACE 함수로 문자 변경
SELECT first_name, REPLACE(first_name, 'A', 'C') FROM customer WHERE first_name LIKE 'A%';

-- REPEAT 함수로 문자 반복
SELECT REPEAT('0', 10);

-- REPEAT과 REPLACE 함수 조합
SELECT first_name, REPLACE(first_name, 'A', REPEAT('C', 10)) FROM customer WHERE first_name LIKE '%A%';

-- SPACE 함수로 공백 문자 반복
SELECT CONCAT(first_name, SPACE(10), last_name) FROM customer;

-- REVERSE 함수로 문자열을 역순으로 반환
SELECT 'Do it! MySQL', REVERSE('Do it! MySQL');

-- REVERSE 함수와 다른 여러 함수 조합
WITH ip_list (ip)
AS (
	SELECT '192.168.0.1' UNION ALL
	SELECT '10.6.100.99' UNION ALL
	SELECT '8.8.8.8' UNION ALL
	SELECT '192.200.212.113'
)
SELECT 
	ip, SUBSTRING(ip, 1, CHAR_LENGTH(ip) - POSITION('.' IN REVERSE(ip)))
FROM ip_list;

-- STRCMP 함수로 두 문자열을 비교: 동일한 경우
SELECT STRCMP('Do it! MySQL', 'Do it! MySQL');

-- STRCMP 함수로 두 문자열을 비교: 동일하지 않은 경우
SELECT STRCMP('Do it! MySQL', 'Do it! MySQL!');