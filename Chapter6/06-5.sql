-- ROW_NUMBER 함수로 순위 부여
SELECT 
	ROW_NUMBER() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- 내림차순 정렬한 결과에 ROW_NUMBER 함수로 순위 부여
SELECT 
	ROW_NUMBER() OVER(ORDER BY amount DESC, customer_id DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- PARTITION BY 문으로 사용해 그룹별 순위 부여
SELECT 
	staff_id,
	ROW_NUMBER() OVER(PARTITION BY staff_id ORDER BY amount DESC, customer_id ASC) AS num, 
	customer_id, 
	amount
FROM (
	SELECT 
		customer_id, staff_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id, staff_id
	) AS x;

-- RANK 함수로 순위 부여
SELECT 
	RANK() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- DENSE_RANK 함수로 순위 부여
SELECT 
	DENSE_RANK() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- 내림차순으로 정렬한 결과에 NTILE 함수로 순위 부여
SELECT 
	NTILE(100) OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;