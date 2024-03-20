-- LAG와 LEAD 함수로 앞뒤 행 참조
SELECT 
	x.payment_date,
	LAG(x.amount) OVER(ORDER BY x.payment_date ASC) AS lag_amount, amount,
	LEAD(x.amount) OVER(ORDER BY x.payment_date ASC) AS lead_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
	) AS x
ORDER BY x.payment_date;

-- LAG와 LEAD 함수로 2칸씩 앞뒤 행 참조
SELECT 
	x.payment_date,
	LAG(x.amount, 2) OVER(ORDER BY x.payment_date ASC) AS lag_amount, amount,
	LEAD(x.amount, 2) OVER(ORDER BY x.payment_date ASC) AS lead_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
) AS x
ORDER BY x.payment_date;

-- CUME_DIST 함수로 누적 분폿값 계산
SELECT 
	x.customer_id, x.amount, CUME_DIST() OVER(ORDER BY x.amount DESC)
FROM (
	SELECT 
		customer_id, sum(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS X
ORDER BY x.amount DESC;

-- PERCENT_RANK 함수로 상위 분포 순위를 계산
SELECT 
	x.customer_id, x.amount, PERCENT_RANK() OVER (ORDER BY x.amount DESC)
FROM (
	SELECT 
		customer_id, sum(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS X
ORDER BY x.amount DESC;


-- FIRST_VALUE 함수로 가장 높은 값 조회
SELECT 
	x.payment_date, x.amount,
	FIRST_VALUE(x.amount) OVER(ORDER BY x.payment_date) AS f_value,
	LAST_VALUE(x.amount) OVER(ORDER BY x.payment_date RANGE BETWEEN UNBOUNDED
	PRECEDING AND UNBOUNDED FOLLOWING) AS l_value,
	x.amount - FIRST_VALUE(x.amount) OVER(ORDER BY x.payment_date) AS increase_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
	) AS x
ORDER BY x.payment_date;

