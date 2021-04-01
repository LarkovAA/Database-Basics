/* Задание 2 Создайте базу данных example, разместите в ней таблицу users, 
состоящую из двух столбцов, числового id и строкового name*/

CREATE DATABASE IF NOT EXISTS example;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255)
) ;

SELECT * FROM users;

/* Задание 3 Создайте дамп базы данных example из предыдущего задания, 
 * разверните содержимое дампа в новую базу данных sample 

CREATE DATABASE IF NOT EXISTS samplee;

mysqldump example > dump_in_sample;
mysql dump_in_sample < sample; 

 * */






