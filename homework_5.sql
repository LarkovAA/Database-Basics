USE homework_5

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 1. 
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.*/
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NOW(), NOW()),
  ('Наталья', '1984-11-12', NOW(), NOW()),
  ('Александр', '1985-05-20', NOW(), NOW()),
  ('Сергей', '1988-02-14', NOW(), NOW()),
  ('Иван', '1998-01-12', NOW(), NOW()),
  ('Мария', '2006-08-29', NOW(), NOW());
 
 SELECT * FROM users;
 

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 2.
 * Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
 * и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу
 *  DATETIME, сохранив введённые ранее значения. */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';


INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 4:32', '20.05.2016 4:32'), -- Почемуто не принимает время больше 12 часов не 16 не 20 меняю на 12 часов меньше
  ('Александр', '1985-05-20', '14.08.2016 8:10', '14.08.2016 8:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');

SELECT * FROM users;

-- Проверял работает ли запрос
SELECT STR_TO_DATE(created_at, '%d.%m.%Y %h:%i') FROM users;
SELECT STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i') FROM users;

ALTER TABLE users ADD COLUMN created_at_date DATETIME; 
ALTER TABLE users ADD COLUMN updated_at_date DATETIME;

UPDATE users SET created_at_date = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i');
UPDATE users SET updated_at_date = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

ALTER TABLE users RENAME COLUMN created_at_date TO created_at;
ALTER TABLE users RENAME COLUMN updated_at_date TO updated_at;


/* «Операторы, фильтрация, сортировка и ограничение». Для задания 3. В таблице складских запасов 
 * storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и 
 * выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они 
 * выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, 
 * после всех записей. */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
  
SELECT * FROM storehouses_products 
ORDER BY CASE WHEN value = 0 THEN 123456789 ELSE value END; -- этот ответ я нашел в интернете и он раюботает 

/* Я пытался другими способами через IF
SELECT * FROM storehouses_products IF(WHERE >= 1, ORDER BY value, ORDER BY value DESC);
Через CASE
SELECT * FROM storehouses_products 
CASE
	WHEN value >= 1 THEN ORDER BY value
ELSE
	ORDER BY value DESC
END;
Еще через объединение 2-х запросов:
SELECT * FROM storehouses_products WHERE value >= 1 ORDER BY value
UNION
SELECT * FROM storehouses_products WHERE value = 0 ORDER BY value DESC;

В итоге не чего не порлучилось.... Можно узнать почему ?? Я смог через изменение значения строчки сделать
а через изменение значения порядка сортировки нет....
 */

/* «Операторы, фильтрация, сортировка и ограничение». Для задания 4. (по желанию) Из таблицы users 
 * необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка 
 * английских названий (may, august)*/
SELECT id, name, birthday_at FROM users WHERE birthday_at LIKE '____-05%' OR birthday_at LIKE '____-08%';

/* «Агрегация данных». Для заданий 1,Подсчитайте средний возраст пользователей в таблице users.
 *  2.Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения. */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at)
VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '2006-08-29');
 
SELECT avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS middle_age FROM users; -- средний возраст 

SELECT name, CEILING(to_days(birthday_at) % 365.25 % 7) AS day_week FROM users; -- Определить дни недели получается 


-- Не получаеться перевести значения названия недель и посчитать сколько дней рождений
SELECT count(*), 
	CASE
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'пятница'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'суббота'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'воскресенье'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'понедельник'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'вторник'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'среда'
		WHEN day_week = (CEILING(to_days(birthday_at) % 365.25 % 7)) THEN 'четверг'
	END AS day_week
FROM users 
GROUP BY day_week;
-- Не получается перевести значения из цифр в названия дней недели.

	
/* «Операторы, фильтрация, сортировка и ограничение». Для задания 5. (по желанию) Из таблицы catalogs 
 * извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте 
 * записи в порядке, заданном в списке IN.*/

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 
SELECT * FROM catalogs id ORDER BY 
CASE 
	WHEN id = 5 THEN 1 
	WHEN id = 1 THEN 2
	WHEN id = 2 THEN 3
END
LIMIT 2, 3
;

/* «Агрегация данных». Для задания 3.(по желанию) Подсчитайте произведение чисел в столбце таблицы. */
CREATE TABLE x (id INT PRIMARY KEY);

INSERT INTO x VALUES (1), (2), (3), (4), (5);

SELECT exp(SUM(log(id))) FROM x;

