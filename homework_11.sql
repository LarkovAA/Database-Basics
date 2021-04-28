/*
 * Задание 1.Создайте таблицу logs типа Archive. 
 * Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и 
 * содержимое поля name.
 */
USE shop;

SET @times = current_timestamp ;
SELECT @times;


CREATE TABLE logs (
	date_creation DATETIME,
	table_name VARCHAR(255),
	id INT,
	title_content VARCHAR(255)
) ENGINE = Archive;

SELECT * FROM users;

DELIMITER //
CREATE TRIGGER add_values_to_the_archive_users AFTER INSERT ON users
FOR EACH ROW
BEGIN 
	INSERT INTO logs (date_creation, table_name, id, title_content) VALUES
	(NEW.created_at, 'users', NEW.id, NEW.name);
END //
DELIMITER ;

SELECT * FROM catalogs ;

DELIMITER //
CREATE TRIGGER add_values_to_the_archive_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN 
	INSERT INTO logs (date_creation, table_name, id, title_content) VALUES
	(now(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;

SELECT * FROM products;

DELIMITER //
CREATE TRIGGER add_values_to_the_archive_products AFTER INSERT ON products
FOR EACH ROW
BEGIN 
	INSERT INTO logs (date_creation, table_name, id, title_content) VALUES
	(NEW.created_at, 'products', NEW.id, NEW.name);
END //
DELIMITER ;

-- Проверить не могу работает или нет. Делимитер не работает.

/*
 * Задание 2. Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
CREATE TABLE tabl_2 (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name Varchar(255),
	create_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE PROCEDURE millón_registros()
BEGIN
	DECLARE i INT DEFAULT 1; -- теперь тут синиактическая ошибка. Я не понимаю почему ??????
	WHILE i < 1000001
	INSERT INTO tabl_2 (name, create_at) VALUES (concat('user_',i)
	
END //
DELIMITER ;

CALL millón_registros();

