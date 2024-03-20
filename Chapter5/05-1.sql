-- 내부 조인한 테이블에서 조건에 맞는 데이터 조회
SELECT
	a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id AS a_address_id,
	b.address_id AS b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';

-- 열 이름이 유일하지 않은 경우
SELECT
	address_id
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';

-- 2개의 조인 조건으로 조인한 테이블에서 조건에 맞는 데이터 조회
SELECT
	a.customer_id, a.first_name, a.last_name,
	b.address_id, b.address, b.district, b.postal_code
FROM customer AS a
	INNER join address AS b ON a.address_id = b.address_id AND a.create_date = b.last_update
WHERE a.first_name = 'ROSA';

-- 3개의 테이블을 조인한 테이블에서 조건에 맞는 데이터 조회
SELECT
	a.customer_id, a.first_name, a.last_name,
	b.address_id, b.address, b.district, b.postal_code,
	c.city_id, c.city
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id
	INNER JOIN city AS c ON b.city_id = c.city_id
WHERE a.first_name = 'ROSA';

-- LEFT OUTER JOIN한 결과 조회
SELECT
	a.address, a.address_id AS a_address_id,
	b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id;

-- LEFT OUTER JOIN으로 조회한 결과에서 NULL만 조회
SELECT
	a.address, a.address_id AS a_address_id,
	b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

-- RIGHT OUTER JOIN한 결과 조회
SELECT
	a.address, a.address_id AS a_address_id,
	b.address_id AS b_address_id, b.store_id
FROM address AS a
	RIGHT OUTER JOIN store AS b ON a.address_id = b.address_id;

-- RIGHT OUTER JOIN으로 조회한 결과에서 NULL만 조회
SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

-- FULL OUTER JOIN한 결과 조회
SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a	
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id;

-- FULL OUTER JOIN으로 조회한 결과에서 NULL만 조회
SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

-- 샘플 데이터 생성
CREATE TABLE doit_cross1(num INT);
CREATE TABLE doit_cross2(name VARCHAR(10));

INSERT INTO doit_cross1 VALUES (1), (2), (3);
INSERT INTO doit_cross2 VALUES ('Do'), ('It'), ('SQL');

-- CROSS JOIN 문을 적용한 쿼리
SELECT
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
ORDER BY a.num;

-- WHERE 문을 사용한 CROSS JOIN
SELECT
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
WHERE a.num = 1;

-- SELF JOIN 문을 적용한 쿼리 1
SELECT 
	a.customer_id AS a_customer_id, b.customer_id AS b_customer_id
FROM customer AS a
	INNER JOIN customer AS b ON a.customer_id = b.customer_id

-- SELF JOIN 문을 적용한 쿼리 2
SELECT
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount AS profit_amount
FROM payment AS a
	LEFT OUTER JOIN payment AS b ON a.payment_id = b.payment_id -1;