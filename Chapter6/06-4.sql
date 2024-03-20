-- ABS 함수에 입력한 숫자를 절댓값으로 반환
SELECT ABS(-1.0), ABS(0.0), ABS(1.0);

-- ABS 함수에 입력한 수식의 결과를 절댓값으로 반환
SELECT 
	a.amount - b.amount AS amount, ABS(a.amount - b.amount) AS abs_amount
FROM payment AS a
	INNER JOIN payment AS b ON a.payment_id = b.payment_id-1;

-- 암시적 형 변환으로 오버플로 없이 절댓값을 반환
SELECT ABS(-2147483648);

-- SIGN 함수로 입력한 숫자가 양수, 음수, 0인지를 판단
SELECT SIGN(-256), SIGN(0), SIGN(256);

-- SIGN 함수로 수식의 결과가 양수, 음수, 0인지를 판단
SELECT 
	a.amount - b.amount AS amount, SIGN(a.amount - b.amount) AS abs_amount
FROM payment AS a
	INNER JOIN payment AS b ON a.payment_id = b.payment_id-1;

-- CEILING 함수로 천장값 반환
SELECT CEILING(2.4), CEILING(-2.4), CEILING(0.0);

-- FLOOR 함수로 바닥값 반환
SELECT FLOOR(2.4), FLOOR(-2.4), FLOOR(0.0);

-- ROUND 함수로 소수점 셋째 자리까지 반올림
SELECT ROUND(99.9994, 3), ROUND(99.9995, 3);

-- ROUND 함수로 소수와 정수를 따로 반올림
SELECT ROUND(234.4545, 2), ROUND(234.4545, -2);

-- 정수 부분의 길이보다 큰 자릿수를 입력한 경우
SELECT ROUND(748.58, -1);
SELECT ROUND(748.58, -2);
SELECT ROUND(748.58, -4);

-- LOG 함수로 로그 10을 계산
SELECT LOG(10);

-- LOG 함수로 로그 10의 5를 계산
SELECT LOG(10, 5);

-- EXP 함수로 지수 1.0을 계산
SELECT EXP(1.0);

-- EXP 함수로 지수 10을 계산
SELECT EXP(10);

-- LOG 함수와 EXP 함수로 결과 확인
SELECT EXP(LOG(20)), LOG(EXP(20));

-- POWER 함수로 거듭제곱 계산
SELECT POWER(2,3), POWER(2,10), POWER(2.0, 3);

-- SQRT 함수로 제곱근 계산
SELECT SQRT(1.00), SQRT(10.00);

-- RAND 함수로 난수 계산
SELECT RAND(100), RAND(), RAND();

-- 인수가 없는 RAND 함수로 난수 계산
DELIMITER $$

CREATE PROCEDURE rnd()
BEGIN
	DECLARE counter INT;
	
	SET counter = 1;
	
	WHILE counter < 5 DO
		SELECT RAND() Random_Number;
	
		SET counter = counter + 1;
	END WHILE;

END $$

DELIMITER ;

call rnd();

-- COS 함수 계산
SELECT COS(14.78);

-- SIN 함수 계산
SELECT SIN(45.175643);

-- TAN 함수 계산
SELECT TAN(PI()/2), TAN(.45)

-- ATAN 함수 계산
SELECT 
	ATAN(45.87) AS atanCalc1,
	ATAN(-181.01) AS atanCalc2,
	ATAN(0) AS atanCalc3,
	ATAN(0.1472738) AS atanCalc4,
	ATAN(197.1099392) AS atanCalc5;

