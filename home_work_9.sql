USE shop;

/*
Задание 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
 */

START TRANSACTION;
INSERT INTO sample.users (SELECT * FROM shop.users WHERE id = 1); -- Вопрос. посему если ставлю после названия таблицы values выдает ошибку а без него все норм ?? 
COMMIT;

/*
CREATE OR REPLACE  VIEW view_shop_user_1
AS
	SELECT * FROM shop.users WHERE id = 1
	WITH CHECK OPTION;

SELECT * FROM view_shop_user_1;

START TRANSACTION;
INSERT INTO sample.users view_shop_user_1; 
COMMIT;

так же пытаюсь через представление сделать то же ошибка. Почему если условие представления одно
 и то же с условием добавления ??
*/

/*
Задание 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
 */
SELECT * FROM products;
SELECT * FROM catalogs;

CREATE VIEW name_is_products_and_catalogs
AS
	SELECT p.name AS product_name , c.name AS catalogs_name 
	FROM products AS p
	JOIN catalogs AS c ON p.catalog_id  = c.id 
	WITH CHECK OPTION;
	
SELECT * FROM name_is_products_and_catalogs;

/*
Задание 3. Пусть имеется таблица с календарным полем created_at. 
В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
 Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

SELECT * FROM storehouses;
SELECT DATE_FORMAT(created_at, '%d') FROM storehouses;

CREATE TABLE day_august
(
	days int
);

/*
DELIMITER //

CREATE PROCEDURE sp_filling_days_august()
BEGIN	
	DECLARE i BIGINT DEFAULT 1 ;
	WHILE i < 32
	UPDATE day_august SET days = @i;
	END WHILE;
END //
-- возникает ошибка я незнаю что делать ?? Не могу в цикле добавить эти значения.
*/

INSERT INTO day_august VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),(31);

SELECT day_august.days,
	CASE
	WHEN DATE_FORMAT(storehouses.created_at, '%d') = day_august.days THEN 1
	ELSE 0
	END AS date_included
FROM day_august
	JOIN storehouses  
	;
-- Что бы отсортировать к 1 дате значение 1 значение 0 или 1 я не могу понять. 
/*
Задание 4. Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

SELECT @number = (SELECT count(*) FROM storehouses) - 5;
SELECT @number;


CREATE OR REPLACE VIEW sorted
AS
	SELECT id FROM storehouses
	ORDER BY created_at
	LIMIT 7
	-- 	LIMIT @number -- Почемуто ошибка ???
;

SELECT * FROM sorted;

DELETE FROM storehouses WHERE id = sorted.id; 

SELECT * FROM storehouses;
--  То же не получается сделать по схеме с добавлением удаление не раб и ошибка когда пытаьсь присвоить значения таблицы



/*
 * Задание 1.
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
 * "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 */

SELECT DATE_FORMAT(now(), '%H');

DELIMITER //
SELECT DATE_FORMAT(now(), '%H') //

CREATE FUNCTION fun_hello()
RETURNS VARCHAR(150) DETERMINISTIC 
BEGIN
	DECLARE times_hour INT; -- Тут какая то ошибка я не могу понять откуда ????? И из за нее код дальше не идет.  You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 5
	SET times_hour = DATE_FORMAT(now(), '%H');
	IF(times_hour <= 6) THEN
		RETURN 'Добрый ночи';
	ELSEIF(times_hour > 6 AND times_hour <= 12) THEN 
		RETURN 'Доброго утра';
	ELSEIF(times_hour > 12 AND times_hour <= 18) THEN
		RETURN 'Доброго день';
	ELSE 
		RETURN 'Доброй ночи';
	END IF;

END //

SELECT fun_hello()//

/*
 * Задание 2.
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */

DELIMITER // -- У меня еще и делимитер не работает 

SELECT * FROM products;

CREATE TRIGGER trig_checking_name_description BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF((NEW.name = NULL OR NEW.name = FALSE) AND (NEW.description = NULL OR NEW.description = FALSE)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You did not enter the product name and description!'; --  You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 5 снова эта ошибка 
	END IF;
END //



