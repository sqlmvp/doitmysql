-- special_features 열의 데이터를 그룹화
SELECT special_features FROM film GROUP BY special_features;

-- rating 열의 데이터를 그룹화
SELECT rating FROM film GROUP BY rating;

-- special_features, rating 열 순서로 데이터를 그룹화
SELECT special_features, rating FROM film GROUP BY special_features, rating;

-- rating, special_features 열 순서로 데이터를 그룹화
SELECT rating, special_features FROM film GROUP BY special_features, rating;

-- COUNT 함수로 그룹에 속한 데이터 개수 세기
SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features;

-- 두 열의 데이터 그룹에 속한 데이터 개수 세기
SELECT 
	special_features, rating, COUNT(*) AS cnt 
FROM film
GROUP BY special_features, rating 
ORDER BY special_features, rating, cnt DESC;

-- SELECT 문과 GROUP BY 문의 열 이름을 달리할 경우
SELECT special_features, rating, COUNT(*) AS cnt FROM film GROUP BY rating;

-- rating 열에서 G인 데이터만 필터링
SELECT 
	special_features, rating, 
FROM film
GROUP BY special_features, rating
HAVING rating = 'G';

-- special_features 열에서 데이터 개수가 70보다 큰 것만 필터링
SELECT 
	special_features, COUNT(*) AS cnt 
FROM film
GROUP BY special_features
HAVING cnt > 70;

-- 그룹화하지 않은 열을 필터링할 경우
SELECT
	special_features, COUNT(*) AS cnt 
FROM film
GROUP BY special_features
HAVING rating = 'G';

-- 오류 없이 필터링할 경우
SELECT 
	special_features, rating, COUNT(*) AS cnt 
FROM film
GROUP BY special_features, rating
HAVING rating = 'R' AND cnt > 8;

-- 두 열의 데이터 중복 제거
SELECT DISTINCT special_features, rating FROM film;

-- GROUP BY 문으로 두 열을 그룹화한 경우
SELECT special_features, rating FROM film GROUP BY special_features, rating;

-- DISTINCT 문에 COUNT 함수를 사용할 경우
SELECT DISTINCT special_features, rating, COUNT(*) AS cnt FROM film;

