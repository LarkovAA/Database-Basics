/* ������� 2 �������� ���� ������ example, ���������� � ��� ������� users, 
��������� �� ���� ��������, ��������� id � ���������� name*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255)
) ;

SELECT * FROM users;

/* ������� 3 �������� ���� ���� ������ example �� ����������� �������, 
 * ���������� ���������� ����� � ����� ���� ������ sample 

mysqldump (example) > dump_in_sample;
mysql dump_in_sample < sample; 

 * */






