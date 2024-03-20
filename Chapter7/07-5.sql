-- 함수 생성 권한 부여
SET GLOBAL log_bin_trust_function_creators = 1;

-- 스토어드 함수 생성
USE doitsql;

DROP FUNCTION IF EXISTS user_sum;

DELIMITER $$
CREATE FUNCTION user_sum(num_1 INT, num_2 INT)
RETURNS INT
BEGIN
	RETURN num_1 + num_2;
END $$
DELIMITER ;

-- 스토어드 함수 호출
SELECT user_sum (1, 5);

-- 스토어드 함수 내용 확인
SHOW CREATE FUNCTION user_sum;

-- 스토어드 함수 삭제
DROP FUNCTION user_sum;

-- 커서 생성
DROP PROCEDURE IF EXISTS doit_cursor;

DELIMITER $$
CREATE PROCEDURE doit_cursor()
BEGIN
	DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 마지막 커서 행인지를 저장하기 위한 변수 설정(기본값: FALSE)
	
	-- 커서에 사용할 변수
	DECLARE user_payment_id INT; -- payment_id를 저장할 변수
	DECLARE user_amount DECIMAL(10,2) DEFAULT 0; -- amount를 저장할 변수
	DECLARE idCursor CURSOR FOR -- 커서 선언
	
	SELECT payment_id FROM payment WHERE staff_id = 1;
	
	-- 반복 조건 선언
	DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 TRUE 대입
	FOR NOT FOUND SET endOfRow = TRUE;
	
	-- 커서 열기
	OPEN idCursor;
	
	-- 반복 구문
	sum_loop : LOOP
		FETCH idCursor INTO user_payment_id; -- 첫 번째 데이터 가져오기
		
		IF endOfRow THEN
			LEAVE sum_loop; -- 마지막 행이면 종료
		END IF;
	
		-- 데이터 처리
		SET user_amount = user_amount + (SELECT amount FROM payment WHERE payment_id = user_payment_id);
	
	END LOOP sum_loop;
	
	-- 데이터 결과 반환
	SELECT user_amount;
	
	-- 커서 닫기
	CLOSE idCursor;
END$$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_cursor();

-- 결과 비교를 위한 쿼리 입력
SELECT sum(amount) FROM payment WHERE staff_id = 1;