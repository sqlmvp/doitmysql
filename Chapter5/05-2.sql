-- 단일 행 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ROSA');

-- 잘못된 단일 행 서브 쿼리 적용 시 오류 발생 예
SELECT * FROM customer
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- IN을 활용한 다중 행 서브 쿼리 적용 1
SELECT * FROM customer WHERE first_name IN ('ROSA', 'ANA');

-- IN을 활용한 다중 행 서브 쿼리 적용 2
SELECT * FROM customer
WHERE customer_id IN (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- 테이블 3개를 조인하는 쿼리
SELECT
	a.film_id, a.title
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
	INNER JOIN category AS c ON b.category_id = c.category_id
WHERE c.name = 'Action';

-- IN을 활용한 서브 쿼리 적용
SELECT
	film_id, title
FROM film
WHERE film_id IN (
	SELECT a.film_id
	FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action'
	);

-- NOT IN을 활용한 서브 쿼리 적용
SELECT
	film_id, title
FROM film
WHERE film_id NOT IN (
	SELECT a.film_id
	FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action'
	);

-- = ANY를 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id = ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- < ANY를 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id < ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- > ANY를 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id > ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- EXISTS를 활용한 서브 쿼리 적용: TRUE를 반환하는 경우
SELECT * FROM customer
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- EXISTS를 활용한 서브 쿼리 적용: FALSE를 반환하는 경우
SELECT * FROM customer
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

-- NOT EXISTS를 활용한 서브 쿼리 적용: TRUE를 반환하는 경우
SELECT * FROM customer
WHERE NOT EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

-- ALL을 활용한 서브 쿼리 적용
SELECT * FROM customer
WHERE customer_id = ALL (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

-- 테이블 조인
SELECT
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
	INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

-- FROM 문에 서브 쿼리 적용
SELECT
	a.film_id, a.title, a.special_features, x.name
FROM film AS a
INNER JOIN (
	SELECT
		b.film_id, c.name
	FROM film_category AS b
		INNER JOIN category AS c ON b.category_id = c.category_id
	WHERE b.film_id > 10 AND b.film_id < 20
	) AS x ON a.film_id = x.film_id;

-- 테이블 조인
SELECT
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
	INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

-- SELECT 문에 서브 쿼리 적용
SELECT
	a.film_id, a.title, a.special_features, (SELECT c.name FROM film_category as
	b INNER JOIN category AS c ON b.category_id = c.category_id WHERE a.film_id =
	b.film_id) AS name
FROM film AS a
WHERE a.film_id > 10 AND a.film_id < 20;