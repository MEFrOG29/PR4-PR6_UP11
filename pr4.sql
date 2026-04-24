SELECT second_name, first_name, title, price
FROM market.authors INNER JOIN market.books
	ON market.authors.id_author = market.books.id_author
WHERE market.authors.country = 'Россия';

SELECT second_name, first_name, COUNT(*) AS countBooks
FROM market.authors LEFT JOIN market.books
	ON market.authors.id_author = market.books.id_author
GROUP BY market.authors.id_author;

SELECT second_name, first_name
FROM market.authors
WHERE market.authors.id_author 
NOT IN 
	( SELECT DISTINCT id_author 
		FROM market.books 
		WHERE title 
		LIKE '%linux%' OR title LIKE '%windows%');
        
SELECT 
    login,
    COUNT(market.orders.id_customer) AS orders,
    SUM(count) AS 'Кол-во купленных книг',
    SUM(price) AS 'Общая Цена'
FROM market.books
JOIN content ON content.id_book = books.id_book
JOIN orders ON orders.id_order = content.id_order
JOIN customers ON customers.id_customer = orders.id_customer

GROUP BY market.customers.login;

SELECT 
	login,
    SUM(count) AS 'Кол-во купленных книг',
    SUM(price) AS 'Общая Цена'
FROM market.books
JOIN content ON content.id_book = books.id_book
JOIN orders ON orders.id_order = content.id_order
JOIN customers ON customers.id_customer = orders.id_customer

GROUP BY market.customers.login
HAVING SUM(count) > 10
