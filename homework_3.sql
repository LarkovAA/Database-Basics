/*
Задание 1 Проанализировать структуру БД vk с помощью скрипта, который мы 
создали на занятии (les-3.sql), и внести предложения по усовершенствованию 
(если такие идеи есть). Создайте у себя БД vk с помощью скрипта из материалов урока. 
Напишите пожалуйста, всё ли понятно по структуре.

Предложений нет.
*/


/*
Задание 2 Придумать 2-3 таблицы для БД vk, которую мы создали на занятии 
(с перечнем полей, указанием индексов и внешних ключей).




*/

USE vk ;

-- Создаем таблицу с черным списком
CREATE TABLE IF NOT EXISTS black_list(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted boolean DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	INDEX fk_black_lists_from_user_id_idx(from_user_id),
	INDEX fk_black_list_to_user_id_idx(to_user_id),
	CONSTRAINT fk_black_list_users_1 FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_black_list_users_2 FOREIGN KEY (to_user_id) REFERENCES users(id),
);

-- Создаем таблицу с лайками.
CREATE TABLE IF NOT EXISTS likes (
	from_user_id BIGINT UNSIGNED,
	to_like_user bigint UNSIGNED,
	accepted boolean DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_like_user),
	CONSTRAINT fk_likes_users_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_likes_users_to_like_user FOREIGN KEY (to_like_user) REFERENCES media(id),
); 

-- Создаем таблицу репостов.

CREATE TABLE IF NOT EXISTS repostet (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	from_user BIGINT UNSIGNED,
	to_whom_repost BIGINT UNSIGNED,
	text_repost text DEFAULT NULL,
	media_repost bigint UNSIGNED, 
	CONSTRAINT fk_repostet_from_user FOREIGN KEY (from_user) REFERENCES users(id),
	CONSTRAINT fk_repostet_to_whom_repost FOREIGN KEY (to_whom_repost) REFERENCES users(id),
	CONSTRAINT fk_repostet_media_repost FOREIGN KEY (media_repost) REFERENCES media(id),
);



