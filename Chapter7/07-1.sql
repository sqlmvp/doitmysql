-- 스토어드 프로시저 생성
DELIMITER $$
CREATE PROCEDURE doit_proc()
BEGIN
	DECLARE customer_cnt INT;
	DECLARE add_number INT;
	
	SET customer_cnt = 0;
	SET add_number = 100;
	SET customer_cnt = (SELECT COUNT(*) FROM customer);
	
	SELECT customer_cnt + add_number;
END $$
DELIMITER ;

-- 스토어드 프로시저 호출
CALL doit_proc();

-- 스토어드 프로시저 내용 확인
SHOW CREATE PROCEDURE doit_proc;

-- 스토어드 프로시저 삭제
DROP PROCEDURE doit_proc;