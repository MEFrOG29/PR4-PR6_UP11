SELECT DATABASE();
SELECT USER();
SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();

SELECT id_order AS 'Номер заказа',
date AS 'Дата',
DAY(date) AS 'День',
MONTHNAME(date) AS 'Месяц' 
FROM market.orders
WHERE YEAR(date) = YEAR(CURDATE());

UPDATE market.books
SET title = REPLACE(title, '  ', ' '), price = ROUND(price, -1);

SELECT CONCAT_WS(' ', second_name, SUBSTRING(first_name, 1, 1)) AS 'Автор',
CONCAT(title, ' ', price, 'руб') AS 'Книга и цена' 
FROM market.authors 
JOIN market.books ON market.authors.id_author = market.books.id_author;

SELECT second_name AS 'Фамилия',
first_name AS 'Имя',
country AS 'Страна',
GROUP_CONCAT(DISTINCT title) AS 'Книги'
FROM market.authors
JOIN market.books ON market.authors.id_author = market.books.id_author
GROUP BY second_name, first_name, country
ORDER BY 'Книги';

SELECT login AS 'Логин',
 second_name AS 'Фамилия',
 first_name AS 'Имя', 
CASE
	WHEN address = '-' 
		THEN address = null
	ELSE address
END AS 'Адрес',
IFNULL(phone,'-') AS 'Телефон'
FROM market.customers;

SELECT ROW_NUMBER() OVER() AS '№',
title AS 'Название',
genre AS 'Жанр',
price AS 'Цена',
weight AS 'Вес',
pages_count AS 'Кол-во страниц',
publish_year AS 'Год публикации'
FROM market.books
ORDER BY title;

SELECT title, genre, price, top3
FROM (SELECT *,
DENSE_RANK() OVER(PARTITION BY genre ORDER BY price DESC) AS top3
FROM market.books) AS tempbooks
WHERE top3 <= 3 

