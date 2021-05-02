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