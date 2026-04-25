INSERT INTO market.tempbooks
SELECT second_name, first_name, title, price
FROM market.authors 
JOIN market.books ON market.authors.id_author = market.books.id_author;

DELETE FROM market.tempbooks
WHERE tempbooks.title LIKE "%компьютер%";

UPDATE market.tempbooks
SET price = CASE
		WHEN tempbooks.second_name = "Пушкин"
			THEN tempbooks.price * 2
		WHEN tempbooks.second_name = "Иванова"
			THEN tempbooks.price - 50
		ELSE tempbooks.price
        END;
        
DELETE FROM market.tempbooks;

UPDATE market.books
JOIN market.authors ON market.books.id_author = market.authors.id_author
SET price = price + 100
WHERE country = "Россия";

DELETE FROM market.customers
WHERE id_customer NOT IN (
	SELECT DISTINCT id_customer 
    FROM market.orders);

REPLACE INTO market.authors 
(second_name, first_name, country) 
VALUES ('Джорж', 'Оруэлл', 'Англия');

INSERT INTO market.authors
(id_author, second_name, first_name, country)
VALUES (9, 'Джорж','Оруэлл','Англия')
ON DUPLICATE KEY UPDATE market.authors.country = 'Англия'

