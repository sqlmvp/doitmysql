/*====================================================================
되새김 문제 정답 - 3장
=====================================================================*/
-- Q1 정답
1. 한 줄 주석은 해시(#) 또는 2개 연속의 하이픈(--) 을 사용합니다.
2. 여러 줄 주석은 시작과 끝에 열기(/*), 닫기(*/)를 사용 합니다.

-- Q2 정답
CREATE DATABASE doit_exam;

-- Q3 정답
USE doit_exam;
--테이블 생성
CREATE TABLE doit_exam_t1 (
id INT,
name VARCHAR(100),
create_date DATETIME
);
--데이터 입력
INSERT INTO doit_exam_t1 (id, name, create_date) VALUES (1, '강성욱', '2023-10-01 12:22:00');
INSERT INTO doit_exam_t1 (id, name, create_date) VALUES (2, '이지스퍼블리싱', '2024-01-03 15:31:00');
INSERT INTO doit_exam_t1 (id, name, create_date) VALUES (3, 'doitmysql', '2024-02-01 00:05:00');
--데이터 조회
SELECT * FROM doit_exam_t1;

-- Q4 정답
UPDATE doit_exam_t1 SET name = '출판사' where id = 1;

-- Q5 정답
DELETE FROM doit_exam_t1 WHERE id = 1;

-- Q6 정답
DROP TABLE doit_exam_t1;

-- Q7 정답 
DROP DATABASE doit_exam;

-- Q8 정답
• DBMS 구축에 필요한 다양한 기술을 효율적으로 적용하는 방안을 제시한다.
•데이터베이스 설계 및 생성 속도와 효율성을 촉진시킨다.
•조직의 데이터를 문서화하고 데이터 관련 시스템을 설계할 때 일관성을 조정한다.
•업무 조직과 기술 조직 간의 의사소통을 원활히 하는 도구 또는 중재의 역할을 한다.

-- Q9 정답
요구 사항 분석 > 개념 모델링 > 논리 모델링 > 물리 모델링 > DB 구현

-- Q10 정답
릴레이션이란 관계형 데이터베이스에서 두 개의 엔티티 타입 사이에 논리적인 관계로 업무의 흐름을 나타낸다.

-- Q11 정답
관계형 데이터베이스의 설계에서 중복을 안정적으로 구조화하는 과정을 말한다


/*====================================================================
되새김 문제 정답 - 4장
=====================================================================*/
-- Q1 정답
SELECT * FROM country WHERE Code = 'KOR';

-- Q2 정답
SELECT * FROM country WHERE Region LIKE '%Asia%';

-- Q3 정답
SELECT * FROM country WHERE name LIKE '_____';

-- Q4 정답
SELECT * FROM country ORDER BY Population DESC;

-- Q5 정답
SELECT * FROM country WHERE LifeExpectancy >= 60 AND LifeExpectancy <= 70

SELECT * FROM country WHERE LifeExpectancy BETWEEN 60 AND 70;

-- Q6 정답
SELECT * FROM country
WHERE Region NOT LIKE '%Asia%' AND name REGEXP '[g, u]'
ORDER BY Population DESC;

-- Q7 정답
SELECT Region, count(*) AS cnt FROM country
GROUP BY Region ORDER BY cnt DESC;

/*====================================================================
되새김 문제 정답 - 5장
=====================================================================*/
-- Q1 정답
SELECT a.*, b.*
FROM country AS a
	INNER JOIN city AS b ON a.Code = b.CountryCode
WHERE a.name = 'United States';

-- Q2 정답
---- 조인으로 작성
SELECT
	a.Name AS city_name, a.CountryCode, a.District, a.Population,
	b.name AS country_name, b.Population, b.LifeExpectancy, b.GNP
FROM city AS a
	INNER JOIN country AS b ON a.CountryCode = b.Code
ORDER BY a.Population DESC LIMIT 10;

---- FROM 서브 쿼리로 작성
SELECT
	a.Name AS city_name, a.CountryCode, a.District, a.Population,
	b.name AS country_name, b.Population, b.LifeExpectancy, b.GNP
FROM (
	SELECT
		Name, CountryCode, District, Population
	FROM city
	ORDER BY Population DESC LIMIT 10
) AS a
	INNER JOIN country AS b ON a.CountryCode = b.Code


-- Q3 정답
--- 조인으로 작성한 경우
SELECT b.*
FROM countrylanguage AS a
	INNER JOIN country AS b ON a.CountryCode = b.Code
WHERE a.Language = 'English';

--- 다중 행 서브쿼리로 작성하는 경우
SELECT * FROM country
WHERE Code IN (SELECT countrycode FROM countrylanguage WHERE Language = 'English');

-- Q4 정답
SELECT
	a.first_name, a.last_name, c.title, c.release_year, e.name AS category_name
FROM actor AS a
	INNER JOIN film_actor AS b ON a.actor_id = b.actor_id
	INNER JOIN film AS c ON b.film_id = c.film_id
	INNER JOIN film_category AS d ON c.film_id = d.film_id
	INNER JOIN category AS e ON d.category_id = e.category_id
WHERE e.name = 'Action'
ORDER BY title;

-- Q5 정답
WITH cte_film (film_id, title, category_name)
AS (
	SELECT 
		a.film_id, a.title, c.name as category_name
	FROM film AS a
		INNER JOIN film_category AS b ON a.film_id = b.film_id
		INNER JOIN category AS c ON b.category_id = c.category_id
), cte_payment (customer_id, amount, film_id)
AS (
	SELECT 
		a.customer_id, b.amount, c.film_id
	FROM rental AS a
	INNER JOIN payment AS b on a.rental_id = b.rental_id
	INNER JOIN inventory AS c ON a.inventory_id = c.inventory_id
)

SELECT
	a.customer_id, a.first_name, a.last_name,
	c.category_name,
	COUNT(*) AS rental_count,
	SUM(b.amount) AS amount
FROM customer AS a
	INNER JOIN cte_payment AS b on a.customer_id = b.customer_id
	INNER JOIN cte_film AS c ON b.film_id = c.film_id
GROUP BY a.customer_id, a.first_name, a.last_name, c.category_name
ORDER BY a.customer_id;

-- Q6 정답
WITH RECURSIVE cte_emp (employee_id, employee_name, manager_id, employee_level)
AS
(
	SELECT
		employee_id, employee_name, manager_id, 1 as employee_level
	FROM emp
	WHERE manager_id IS NULL
	
	UNION ALL
	
	SELECT
		e.employee_id, e.employee_name, e.manager_id, r.employee_level+ 1
	FROM emp AS e
		INNER JOIN cte_emp AS r ON e.manager_id = r.employee_id
)

SELECT
	employee_name, employee_level,
	(SELECT employee_name FROM emp WHERE employee_id = cte_emp.manager_id) AS Manager
FROM cte_emp
ORDER BY employee_level, manager_id;

/*====================================================================
되새김 문제 정답 - 6장
=====================================================================*/
-- Q1 정답
SELECT CONCAT(Name, ' ', Continent, ' ', Population) FROM country;

-- Q2 정답
SELECT name, IFNULL(IndepYear, '데이터 없음') AS IndepYear
FROM country WHERE IndepYear IS NULL;

-- Q3 정답
SELECT UPPER(name), LOWER(name) FROM country;

-- Q4 정답
SELECT LTRIM(name), RTRIM(name), TRIM(name) FROM country;

-- Q5 정답
SELECT
	name, LENGTH(name)
FROM country
WHERE LENGTH(name) > 20
ORDER BY LENGTH(name) DESE;

-- Q6 정답
SELECT name, SurfaceArea, POSITION('.' in SurfaceArea) FROM country;

-- Q7 정답
SELECT name, SUBSTRING(name, 2,4) FROM country;

-- Q8 정답
SELECT Code, REPLACE(Code, 'A', 'Z') FROM country;

-- Q9 정답
SELECT Code, REPLACE(code, 'A', REPEAT('Z', 10)) FROM country;

-- Q10 정답
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 24 HOUR);

-- Q11 정답
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 24 HOUR);

-- Q12 정답
SELECT DAYNAME('2024-01-01');

-- Q13 정답
SELECT COUNT(*) FROM country;

-- Q14 정답
SELECT SUM(GNP), AVG(GNP), MAX(GNP), MIN(GNP) FROM country;

-- Q15 정답
SELECT name, LifeExpectancy, ROUND(LifeExpectancy, 0) FROM country;

-- Q16 정답
SELECT 
	row_number() OVER (ORDER BY LifeExpectancy DESC, Name ASC), Name, LifeExpectancy
FROM country;

-- Q17 정답
SELECT 
	RANK() OVER (ORDER BY LifeExpectancy DESC), Name, LifeExpectancy
FROM country;

-- Q18 정답
SELECT 
	DENSE_RANK() OVER (ORDER BY LifeExpectancy DESC), Name, LifeExpectancy
FROM country;


/*====================================================================
되새김 문제 정답 - 7장
=====================================================================*/
-- Q1 정답
SELECT CountryCode, Language, Percentage, IF(Percentage >= 5, '5+', '5-')
FROM countrylanguage;

-- Q2 정답
SELECT 
	Name, LifeExpectancy,
	CASE
		WHEN LifeExpectancy >= 100 THEN 'Wow'
		WHEN LifeExpectancy >= 80 THEN 'Best'
		WHEN LifeExpectancy >= 70 THEN 'Good'
		WHEN LifeExpectancy >= 60 THEN 'Normal'
		WHEN LifeExpectancy < 60 THEN 'Sad'
	END AS Life_level
FROM country;

-- Q3 정답 : 입력값으로 0과 10을 넣었을 경우 출력값은 55가 나타난다.
DELIMITER $$
CREATE PROCEDURE doit_sum (
param_1 INT,
param_2 INT
)
BEGIN
	DECLARE while_sum INT;
	SET while_sum = param_1;
	
	myWhile:
		WHILE (param_1 <= param_2) DO
			SET while_sum = while_sum + param_1;
			SET param_1 = param_1 + 1;
			
			IF (param_1 > param_2) THEN
				LEAVE myWhile;
			END IF;
		END WHILE;
	
	SELECT while_sum;
END $$
DELIMITER ;

CALL doit_sum(0, 10);

-- Q4
DROP PROCEDURE IF EXISTS doit_sum;

-- Q5
-- 뷰 생성
CREATE VIEW v_country_language
AS
SELECT
	a.Name, a.Region, b.Language, b.IsOfficial, b.Percentage
FROM country AS a
	INNER JOIN countrylanguage AS b ON a.Code = b.CountryCode;

-- 뷰 조회
SELECT * FROM v_country_language;

-- Q6
DROP VIEW v_country_language;