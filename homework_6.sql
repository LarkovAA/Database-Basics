USE	vk_last6;

/* Задание 1. Пусть задан некоторый пользователь.
Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал пользователю 
наибольшее число сообщений. (можете взять пользователя с любым id).
*/

-- Возьмем пользователя под 6 id

SELECT count(*) AS numbers, 
	(SELECT concat(first_name,' ',last_name) FROM users WHERE id = from_user_id) AS Last_name , 
	from_user_id
FROM messages 
WHERE to_user_id = 6 
GROUP BY from_user_id 
ORDER BY numbers DESC LIMIT 1;

-- В итоге получилось что Demarco Eichmann больше всех отправил данному пользователю сообщений.

SELECT count(*) AS numbers, 
	(SELECT concat(first_name,' ',last_name) FROM users WHERE id = from_user_id) AS Last_name , 
	from_user_id
FROM messages 
WHERE to_user_id = 6 AND from_user_id IN 
(
SELECT to_user_id FROM friend_requests WHERE request_type = 1 AND from_user_id = 6
UNION
SELECT from_user_id FROM friend_requests WHERE request_type = 1 AND to_user_id = 6
)
GROUP BY from_user_id 
ORDER BY numbers DESC LIMIT 1;

-- А из друзей больше всего написал D'angelo Cruickshank.

/* Задание 2. Пусть задан некоторый пользователь.
Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.
*/

SELECT count(*) AS numbers
FROM posts_likes 
WHERE post_id IN (
	SELECT id 
	FROM posts 
	WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, now()) < 18)
) AND like_type = 1
GROUP BY like_type
;

-- Всего 6 лайков было поставлена постам пользователей младше 18 лет

/* Задание 3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?
*/

SELECT (
SELECT count(*) AS number 
FROM posts_likes 
WHERE user_id IN (
	SELECT user_id 
	FROM  profiles 
	WHERE gender = 'm'
) AND like_type = 1
GROUP BY like_type 
) AS like_mane,
(
SELECT count(*) AS number 
FROM posts_likes 
WHERE user_id IN (
	SELECT user_id 
	FROM  profiles 
	WHERE gender = 'f'
) AND like_type = 1
GROUP BY like_type 
) AS like_women
;

-- в итоге получилось что женщины поставили лайков больше 16 против мужчин 5

/* Задание 4. Найти пользователя, который проявляет наименьшую активность в использовании 
 * социальной сети (тот, кто написал меньше всего сообщений, отправил меньше всего заявок в друзья, ...).
*/

-- расчитываем сколько каждый пользователь поставил лайков
SELECT user_id, count(*) AS numbers 
FROM posts_likes 
WHERE user_id IN (SELECT id FROM users ORDER BY id) AND like_type = 1 
GROUP BY user_id
ORDER BY user_id

-- расчитываем сколько каждый пользователь отправил запросов в друзья
SELECT from_user_id, count(*) AS numbers 
FROM friend_requests 
WHERE from_user_id IN (SELECT id FROM users ORDER BY id)
GROUP BY from_user_id
ORDER BY from_user_id

-- расчитываем сколько каждый пользователь написал сообщений
SELECT from_user_id, count(*) AS numbers 
FROM messages 
WHERE from_user_id IN (SELECT id FROM users ORDER BY id)
GROUP BY from_user_id
ORDER BY from_user_id

/*
Дальше незнаю что сделать объединить в одну не получаеться пишет что подзапрос возвращает больше 1 значения.
 */


