create database if not exists course_project;
use course_project;

CREATE TABLE IF NOT EXISTS Students (
  student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор пользователя',
  first_name VARCHAR(50) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(50) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(255) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(50) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Студенты";
  
CREATE TABLE IF NOT EXISTS Profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  last_login DATETIME COMMENT "Последний вход в систему",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 


CREATE TABLE IF NOT EXISTS Instructors (
  instructor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор преподавателя",
  first_name VARCHAR(50) NOT NULL COMMENT "Имя преподавателя",
  last_name VARCHAR(50) NOT NULL COMMENT "Фамилия преподавателя"
  ) COMMENT "Преподаватели";
  
CREATE TABLE IF NOT EXISTS Courses (
  course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Индетификатор курса",
  tittle VARCHAR(255) NOT NULL COMMENT "Название курса",
  price DECIMAL (5,2) NOT NULL COMMENT "Цена",
  instructor_id SMALLINT NOT NULL COMMENT "Индетификатор преподавателя"
  ) COMMENT "Выбранный курс";
  
CREATE TABLE IF NOT EXISTS Enrollment (
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  date DATETIME NOT NULL,
  price DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (student_id,course_id)
) COMMENT "Зачислен на выбранный курс";

CREATE TABLE IF NOT EXISTS Tags (
  tag_id INT NOT NULL PRIMARY KEY COMMENT "Индитификатор тега",
  name VARCHAR(50) NOT NULL COMMENT "Название тега"
  ) COMMENT "Теги";

CREATE TABLE IF NOT EXISTS Course_tags (
  course_id int not null,
  tag_id int not null,
  primary key (course_id, tag_id)
  ) COMMENT "Теги курсов";

CREATE TABLE IF NOT EXISTS Academic_perfomance_type (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT  PRIMARY KEY COMMENT "Индитификатор успеваемости",
  name VARCHAR(50) NOT NULL COMMENT "Прогресс учебы"
  ) COMMENT "типы прохождения курсов";
  
CREATE TABLE IF NOT EXISTS Academic_perfomances (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT "Индитификатор успеваемости",
  student_id INT UNSIGNED NOT NULL COMMENT "Ссылка на прогресс пользователя",
  PRIMARY KEY (id, student_id)
  ) COMMENT " Успеваемость"



  
  