

-- Немогу сделать CONSTRAINT из этих таблиц
CREATE TABLE login_details(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id созданного пользователя
	mail varchar(255) NOT NULL, -- e-mail пользователя 
	passwords varchar(255) NOT NULL, -- пароль  пользователя
	name VARCHAR(255) NOT NULL, -- имя пользователя
	date_of_birth DATE NOT NULL, -- дата рождения пользователя
	date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- дата создания пользователя
	date_of_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- дата обновления пользователя
	UNIQUE INDEX login_details_mail_ind(mail),
	INDEX login_details_name_ind(name)
);

CREATE TABLE photos(
	id_photo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id фотографии
	name_photo VARCHAR(255) NOT NULL, -- название фото 
	who_posted INT NOT NULL, -- кто выложил фото 
	image_format ENUM('JPEG', 'EPS', 'PNG', 'SVG') NOT NULL, -- формат фото 
	date_of_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- когда была загружена
	CONSTRAINT fr_photos_who_posted_login_details FOREIGN     KEY (who_posted) REFERENCES login_details (id)
);




-- Немогу сделать CONSTRAINT из этих таблиц
CREATE TABLE picture(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id изображения мема
	name_picture VARCHAR(255) NOT NULL, -- название картинки
	image_format ENUM('JPEG', 'GIF', 'EPS', 'PNG', 'SVG') NOT NULL -- формат картинки
);

CREATE TABLE memes(
	id_memes INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- id мема
	id_picture INT NOT NULL, -- id изображения из какого сделан мем
	type_meme ENUM('абстрактные', 'с животными', 'исторические', 'демотиваторы', 'классические', 'мертвые', 'современные', 'эпичные фразы', 'фотожаба', 'локальные', 'музыкальные') NOT NULL, -- тип мема
	meme_structure ENUM('двусоставной ', 'персонажный', 'синтаксический ', 'ситуативный ', 'компаративный ') NOT NULL, -- структура мема
	CONSTRAINT fk_memes_picture FOREIGN KEY (id_picture) REFERENCES picture (id)
);