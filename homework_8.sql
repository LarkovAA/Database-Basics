USE	vk_last6;

/* Задание 1. Пусть задан некоторый пользователь.
Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал пользователю 
наибольшее число сообщений. (можете взять пользователя с любым id).
*/

-- Возьмем пользователя под 6 id

SELECT 
	u.id,
	concat(u.first_name, '', u.last_name) AS firs_last_name,
	count(*) AS numbers
FROM 
	users u 
	JOIN messages AS m ON m.to_user_id = 6 AND u.id = m.from_user_id 
GROUP BY firs_last_name
ORDER BY numbers DESC LIMIT 1;
	;
	

-- В итоге получилось что Demarco Eichmann больше всех отправил данному пользователю сообщений.

SELECT 
	u.id,
	concat(u.first_name, '', u.last_name) AS firs_last_name,
	count(*) AS numbers
FROM 
	users u 
	JOIN messages AS m ON m.to_user_id = 6 AND u.id = m.from_user_id 
	JOIN friend_requests AS fr ON fr.request_type = 1 AND fr.to_user_id = 6 AND u.id = fr.from_user_id
GROUP BY firs_last_name
ORDER BY numbers DESC LIMIT 1
;
-- А из друзей больше всего написал D'angelo Cruickshank.

/* Задание 2. Пусть задан некоторый пользователь.
Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.
*/

SELECT * FROM posts_likes;
SELECT * FROM posts; 
SELECT * FROM profiles;

-- 1 2 5 6 8 10 11 сделали посты 

SELECT prs.user_id, (TIMESTAMPDIFF(YEAR, prs.birthday, now())) AS 'age', count(*)
	FROM profiles prs
	JOIN posts pos ON prs.user_id = pos.user_id
	JOIN posts_likes pl ON pos.id = pl.post_id AND pl.like_type = 1
WHERE (TIMESTAMPDIFF(YEAR, prs.birthday, now())) < 18
GROUP BY prs.user_id
;

-- Всего 6 лайков было поставлена постам пользователей младше 18 лет

/* Задание 3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?
*/

SELECT
	CASE p.gender 
	WHEN 'f' THEN 'female'
	WHEN 'm' THEN 'man'
	WHEN 'x' THEN 'not defined'
	END AS genders,
	count(*) AS numbers_like
FROM profiles p 
	JOIN posts_likes pl ON pl.user_id = p.user_id AND pl.like_type = 1
GROUP BY genders
HAVING genders != 'not defined'
;

-- в итоге получилось что женщины поставили лайков больше 16 против мужчин 5

/* Задание 4. Найти пользователя, который проявляет наименьшую активность в использовании 
 * социальной сети (тот, кто написал меньше всего сообщений, отправил меньше всего заявок в друзья, ...).
*/

SELECT * FROM posts_likes;
SELECT * FROM friend_requests;
SELECT * FROM messages;
SELECT * FROM users ;

SELECT u.id, count(*)
FROM users u 
	JOIN posts_likes p_l ON u.id = p_l.user_id AND p_l.like_type = 1
	JOIN friend_requests f_r ON u.id = f_r.from_user_id
	JOIN messages m ON u.id = m.from_user_id 
GROUP BY u.id 
;



