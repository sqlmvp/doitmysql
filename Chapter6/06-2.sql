-- 날짜 함수로 현재 날짜나 시간 반환
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP(), NOW();

-- 정밀한 시각을 반환
SELECT CURRENT_DATE(), CURRENT_TIME(3), CURRENT_TIMESTAMP(3), NOW(3);

-- UTC_DATE, UTC_TIME, UTC_TIMESTAMP 함수로 세계 표준 날짜나 시간 반환
SELECT CURRENT_TIMESTAMP(3), UTC_DATE(), UTC_TIME(3), UTC_TIMESTAMP(3);

-- DATE_ADD 함수로 1년 증가한 날짜 반환
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR);

-- DATE_ADD 함수로 1년 감소한 날짜 반환
SELECT NOW(), DATE_ADD(NOW(), INTERVAL -1 YEAR);

-- DATE_SUB 함수로 1년 감소한 날짜 반환
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 1 YEAR), DATE_SUB(NOW(), INTERVAL -1 YEAR);

-- DATEDIFF 함수로 날짜 간의 일수 차 반환
SELECT DATEDIFF('2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

-- TIMESTAMPDIFF 함수로 날짜 간의 개월 수 차 반환
SELECT TIMESTAMPDIFF(MONTH, '2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

-- DAYNAME 함수로 특정 날짜의 요일 반환
SELECT DAYNAME('2023-08-20');

-- YEAR, MONTH, WEEK, DAY 함수로 연, 월, 주, 일을 별도의 값으로 반환
SELECT
	YEAR('2023-08-20'),
	MONTH('2023-08-20'),
	WEEK('2023-08-20'),
	DAY('2023-08-20');

-- DATE_FORMAT 함수로 날짜 형식 변경
SELECT DATE_FORMAT('2023-08-20 20:23:01', '%m/%d/%Y');

-- GET_FORMAT 함수로 국가나 지역별 날짜 형식 확인
SELECT 
	GET_FORMAT(DATE, 'USA') AS USA,
	GET_FORMAT(DATE, 'JIS') AS JIS,
	GET_FORMAT(DATE, 'EUR') AS Europe,
	GET_FORMAT(DATE, 'ISO') AS ISO,
	GET_FORMAT(DATE, 'INTERNAL') AS INTERNAL;

-- DATE_FORMAT과 GET_FORMAT 함수 조합
SELECT 
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'USA')) AS USA,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'JIS')) AS JIS,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'EUR'))AS Europe,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'ISO')) AS ISO,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'INTERNAL')) AS INTERNAL;
