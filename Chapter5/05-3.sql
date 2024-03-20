-- 일반 CTE로 데이터 조회
WITH cte_customer (customer_id, first_name, email)
AS
(
SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10
AND customer_id < 100
)

SELECT * FROM cte_customer;

-- 일반 CTE에서 열 불일치로 인한 오류 발생 예
WITH cte_customer (customer_id, first_name, email)
AS
(
SELECT customer_id, first_name, last_name, email FROM customer WHERE customer_id >= 10 AND customer_id < 100
)

SELECT * FROM cte_customer;

-- UNION ALL로 CTE 결합
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15
	
	UNION ALL

	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 25 AND customer_id <= 30
)

SELECT * FROM cte_customer;

-- INTERSECT 문으로 CTE 결합
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15
	
	INTERSECT
	
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id <= 20
)

SELECT * FROM cte_customer;

-- EXCEPT 문으로 CTE 결합 1
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15
	
	EXCEPT

	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id <= 20
)

SELECT * FROM cte_customer;

-- EXCEPT 문으로 CTE 결합 2
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id <= 20
	
	EXCEPT

	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15
)

SELECT * FROM cte_customer;

-- 재귀 CTE로 피보나치 수열 생성
WITH RECURSIVE fibonacci_number (n, fibonacci_n, next_fibonacci_n)
AS(
	SELECT 1, 0, 1
	
	UNION ALL
	
	SELECT 
		n + 1, next_fibonacci_n, fibonacci_n + next_fibonacci_n
	FROM fibonacci_number 
	WHERE n < 20
	)

SELECT * FROM fibonacci_number;