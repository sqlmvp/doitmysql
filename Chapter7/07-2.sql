-- IF 문을 활용한 데이터 조회
SELECT store_id, IF(store_id = 1, '일', '이') AS one_two FROM customer GROUP BY store_id;

-- IF 문을 실행하기 위한 스토어드 프로시저 생성
DROP PROCEDURE IF EXISTS doit_if;

DELIMITER $$
CREATE PROCEDURE doit_if (customer_id_input INT)
BEGIN
	DECLARE store_id_i INT;
	DECLARE s_id_one INT;
	DECLARE s_id_two INT;
	SET store_id_i = (SELECT store_id FROM customer WHERE customer_id = customer_id_input);
	
	IF store_id_i = 1 THEN SET s_id_one = 1;
		ELSE SET s_id_two = 2;
	END IF;
	
	SELECT store_id_i, s_id_one, s_id_two;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_if(1);

-- CASE 문을 활용한 데이터 조회
SELECT 
	customer_id, SUM(amount) AS amount,
	CASE
		WHEN SUM(amount) >= 150 THEN 'VVIP'
		WHEN SUM(amount) >= 120 THEN 'VIP'
		WHEN SUM(amount) >= 100 THEN 'GOLD'
		WHEN SUM(amount) >= 80 THEN 'SILVER'
		ELSE 'BRONZE'
	END AS customer_level
FROM payment GROUP BY customer_id;

-- CASE 문을 실행하기 위한 스토어드 프로시저 생성
DROP PROCEDURE IF EXISTS doit_case;

DELIMITER $$
CREATE PROCEDURE doit_case (customer_id_input INT)
BEGIN
	DECLARE customer_level VARCHAR(10);
	DECLARE amount_sum float;

	SET amount_sum = (SELECT SUM(amount) FROM payment WHERE customer_id = customer_id_input GROUP BY customer_id);
	
	CASE
		WHEN amount_sum >= 150 THEN SET customer_level = 'VVIP';
		WHEN amount_sum >= 120 THEN SET customer_level = 'VIP';
		WHEN amount_sum >= 100 THEN SET customer_level = 'GOLD';
		WHEN amount_sum >= 80 THEN SET customer_level = 'SILVER';
		ELSE SET customer_level = 'BRONZE';
	END CASE;
	
	SELECT customer_id_input as customer_id, amount_sum, customer_level;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_case(4);

-- WHILE 문을 실행하기 위한 스토어드 프로시저 생성
DROP PROCEDURE IF EXISTS doit_while;

DELIMITER $$
CREATE PROCEDURE doit_while (param_1 INT, param_2 INT)
BEGIN
	DECLARE i INT;
	DECLARE while_sum INT;
	
	SET i = 1;
	SET while_sum = 0;
	
	WHILE (i <= param_1) DO
		SET while_sum = while_sum + param_2;
		SET i = i + 1;
	END WHILE;
	
	SELECT while_sum;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_while(10, 3);

-- WHILE ~ LEAVE 문을 실행하기 위한 스토어드 프로시저 생성
DROP PROCEDURE IF EXISTS doit_while;

DELIMITER $$
CREATE PROCEDURE doit_while (param_1 INT, param_2 INT)
BEGIN
	DECLARE i INT;
	DECLARE while_sum INT;
	
	SET i = 1;
	SET while_sum = 0;
	
	myWhile:
		WHILE (i <= param_1) DO
			SET while_sum = while_sum + param_2;
			SET i = i + 1;
			
			IF (while_sum > 100) THEN LEAVE myWhile;
			END IF;
		END WHILE;

	SELECT while_sum;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_while(1000, 3);

-- 동적 SQL을 활용한 데이터 조회
PREPARE dynamic_query FROM 'SELECT * FROM customer WHERE customer_id = ?';
SET @a = 1;

EXECUTE dynamic_query USING @a;

DEALLOCATE PREPARE dynamic_query;

-- 동적 SQL을 실행하기 위한 스토어드 프로시저 생성
DROP PROCEDURE IF EXISTS doit_dynamic;

DELIMITER $$
CREATE PROCEDURE doit_dynamic (t_name VARCHAR(50), c_name VARCHAR(50), customer_id INT)
BEGIN
	SET @t_name = t_name;
	SET @c_name = c_name;
	SET @customer_id = customer_id;
	SET @sql = CONCAT('SELECT ', @c_name, ' FROM ', @t_name, ' WHERE customer_id =', @customer_id);
	
	SELECT @sql;
	
	PREPARE dynamic_query FROM @sql;
	
	EXECUTE dynamic_query;
	
	DEALLOCATE PREPARE dynamic_query;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행
CALL doit_dynamic('payment', '*', 1);

