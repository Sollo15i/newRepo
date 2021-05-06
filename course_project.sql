
create database if not exists course_project;
use course_project;


CREATE TABLE IF NOT EXISTS Students (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор пользователя',
  first_name VARCHAR(50) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(50) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(255) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(50) NOT NULL UNIQUE COMMENT "Телефон"
  ) COMMENT "Студенты";
  
CREATE TABLE IF NOT EXISTS Profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  last_login DATETIME COMMENT "Последний вход в систему",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Профили"; 


CREATE TABLE IF NOT EXISTS Instructors (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор преподавателя",
  first_name VARCHAR(50) NOT NULL COMMENT "Имя преподавателя",
  last_name VARCHAR(50) NOT NULL COMMENT "Фамилия преподавателя"
  ) COMMENT "Преподаватели";
  
CREATE TABLE IF NOT EXISTS Courses (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Индетификатор курса",
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
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Индитификатор тега",
  name VARCHAR(50) NOT NULL COMMENT "Название тега"
  ) COMMENT "Теги";

CREATE TABLE IF NOT EXISTS Course_tags (
  course_id int not null,
  tag_id int not null,
  primary key (course_id, tag_id)
  ) COMMENT "Теги курсов";

CREATE TABLE IF NOT EXISTS Academic_perfomance_type (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT  PRIMARY KEY COMMENT "Индитификатор успеваемости",
  study VARCHAR(50) NOT NULL COMMENT "Прогресс учебы"
  ) COMMENT "типы прохождения курсов";
  
CREATE TABLE IF NOT EXISTS Academic_perfomances (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT "Индитификатор успеваемости",
  student_id INT UNSIGNED NOT NULL COMMENT "Ссылка на прогресс пользователя",
  PRIMARY KEY (id, student_id)
  ) COMMENT " Успеваемость";

CREATE TABLE IF NOT EXISTS messages (
  id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сроки',
  from_user_id int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  to_user_id int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
  body text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Текст сообщения',
  time_of_sending datetime DEFAULT NULL COMMENT 'Время отправления сообщения',
  is_delivered tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  is_read tinyint(1) DEFAULT NULL COMMENT 'Прочитано/непрочитано',
  created_at datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  updated_at datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) COMMENT='Сообщения';

-- загружаю на фейкер для вставки данных 

DROP TABLE IF EXISTS `Academic_perfomance_type`;

CREATE TABLE `Academic_perfomance_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Индитификатор успеваемости',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Прогресс учебы',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='типы прохождения курсов';

#
# TABLE STRUCTURE FOR: Academic_perfomances
#

DROP TABLE IF EXISTS `Academic_perfomances`;

CREATE TABLE Academic_perfomances (
  id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Индитификатор успеваемости',
  student_id int(10) unsigned NOT NULL COMMENT 'Ссылка на прогресс пользователя',
  study varchar(50) null COMMENT 'Оценка успешности',
  PRIMARY KEY (id,student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=' Успеваемость';

#
# TABLE STRUCTURE FOR: Course_tags
#

DROP TABLE IF EXISTS `Course_tags`;

CREATE TABLE `Course_tags` (
  `course_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Теги курсов';

#
# TABLE STRUCTURE FOR: Courses
#

DROP TABLE IF EXISTS `Courses`;

CREATE TABLE `Courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Индетификатор курса',
  `tittle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название курса',
  `price` decimal(5,2) NOT NULL COMMENT 'Цена',
  `instructor_id` smallint(6) NOT NULL COMMENT 'Индетификатор преподавателя',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Выбранный курс';

#
# TABLE STRUCTURE FOR: Enrollment
#

DROP TABLE IF EXISTS `Enrollment`;

CREATE TABLE `Enrollment` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Зачислен на выбранный курс';

#
# TABLE STRUCTURE FOR: Instructors
#

DROP TABLE IF EXISTS `Instructors`;

CREATE TABLE `Instructors` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор преподавателя',
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя преподавателя',
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Фамилия преподавателя',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Преподаватели';

#
# TABLE STRUCTURE FOR: Profiles
#

DROP TABLE IF EXISTS `Profiles`;

CREATE TABLE `Profiles` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `gender` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пол',
  `birthday` date DEFAULT NULL COMMENT 'Дата рождения',
  `city` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Город проживания',
  `country` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Страна проживания',
  `last_login` datetime DEFAULT NULL COMMENT 'Последний вход в систему',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Профили';

скрытый текст: данные для профилей (
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (1, 'f', '1994-06-17', 'East Amparofurt', 'Somalia', '2021-04-11 19:00:48', '2020-10-11 14:22:31');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (2, 'm', '1992-02-11', 'Adolphusberg', 'Martinique', '2021-04-14 04:27:43', '2020-09-07 21:04:38');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (3, 'f', '1999-07-26', 'Estebanstad', 'Luxembourg', '2021-04-06 07:20:27', '2020-06-09 22:51:15');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (4, 'f', '2012-10-27', 'South Robbie', 'Morocco', '2021-04-14 02:48:36', '2021-03-11 08:01:29');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (5, 'f', '1975-06-13', 'Leuschkemouth', 'Christmas Island', '2021-04-30 12:22:57', '2020-09-21 15:02:17');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (6, 'm', '2005-02-14', 'West Wardfort', 'Italy', '2021-04-03 10:23:25', '2020-05-13 01:26:59');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (7, 'f', '2003-09-30', 'North Rhettfurt', 'Peru', '2021-04-25 11:26:41', '2020-05-30 23:40:28');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (8, 'm', '1998-03-02', 'Lake Celestineshire', 'Gambia', '2021-04-17 10:57:35', '2020-10-22 19:50:04');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (9, 'f', '1985-09-10', 'Hildatown', 'Bermuda', '2021-04-25 08:40:45', '2020-10-21 06:02:35');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (10, 'm', '2008-08-01', 'O\'Connerburgh', 'Israel', '2021-04-08 16:17:34', '2020-05-18 03:04:59');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (11, 'f', '1989-02-11', 'Sidborough', 'Palau', '2021-04-24 14:57:55', '2020-12-24 19:22:16');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (12, 'f', '1990-09-12', 'North Waltonburgh', 'Mexico', '2021-04-28 16:15:45', '2021-03-07 20:17:23');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (13, 'f', '2015-09-05', 'Port Armandhaven', 'Tanzania', '2021-04-10 09:03:15', '2021-04-05 07:33:10');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (14, 'm', '2016-07-13', 'North Elaina', 'Cuba', '2021-04-02 14:37:42', '2020-08-12 09:05:13');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (15, 'f', '1979-06-26', 'Strosinmouth', 'Mongolia', '2021-04-17 14:18:47', '2020-10-22 05:08:04');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (16, 'f', '1975-12-03', 'East Darrenfort', 'Svalbard & Jan Mayen Islands', '2021-04-10 06:34:21', '2020-05-30 10:20:15');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (17, 'f', '2012-09-20', 'Lynchchester', 'Myanmar', '2021-04-23 04:31:39', '2020-08-21 01:18:51');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (18, 'f', '2016-07-04', 'North Lauriannefort', 'Saint Pierre and Miquelon', '2021-04-28 22:52:07', '2020-11-09 13:46:31');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (19, 'f', '2001-11-19', 'North Kyleigh', 'Saint Lucia', '2021-04-21 05:35:48', '2020-12-02 03:23:22');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (20, 'f', '1981-11-28', 'Aliyamouth', 'Gambia', '2021-04-03 07:39:41', '2020-12-05 18:02:32');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (21, 'm', '2005-06-01', 'Kubside', 'Swaziland', '2021-04-22 13:59:54', '2021-03-01 01:30:15');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (22, 'm', '1980-05-27', 'Feestburgh', 'Uzbekistan', '2021-04-12 10:15:55', '2020-06-24 17:51:31');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (23, 'f', '1982-03-18', 'North Trace', 'Suriname', '2021-04-20 07:39:02', '2020-06-13 23:13:11');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (24, 'f', '2019-02-13', 'New Trey', 'Guadeloupe', '2021-04-14 07:23:05', '2020-10-19 22:41:53');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (25, 'f', '2006-09-11', 'Annaberg', 'Namibia', '2021-04-03 16:14:44', '2020-07-29 02:13:13');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (26, 'm', '1987-06-21', 'South Ursula', 'Sudan', '2021-04-05 14:50:43', '2021-01-04 22:03:10');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (27, 'm', '1997-04-09', 'Leoniehaven', 'Saint Kitts and Nevis', '2021-04-08 19:41:07', '2020-05-27 03:25:54');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (28, 'f', '2004-01-29', 'Chesleyport', 'Cocos (Keeling) Islands', '2021-04-11 22:48:43', '2020-12-20 09:11:51');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (29, 'f', '2018-01-22', 'East Keven', 'Antigua and Barbuda', '2021-04-29 09:53:45', '2021-03-24 12:41:52');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (30, 'f', '2008-02-13', 'West Elyse', 'Italy', '2021-04-19 13:14:41', '2021-03-18 11:57:48');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (31, 'm', '2007-09-23', 'Clotildestad', 'Honduras', '2021-04-04 10:37:14', '2020-08-28 22:53:39');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (32, 'm', '2016-04-12', 'North Madonnaview', 'Barbados', '2021-03-31 09:47:06', '2020-06-28 02:09:53');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (33, 'm', '1974-11-20', 'Cheyanneshire', 'Macao', '2021-04-28 23:03:29', '2021-01-04 14:31:27');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (34, 'f', '1997-12-04', 'Pfefferview', 'Anguilla', '2021-04-29 01:12:22', '2020-08-09 07:46:52');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (35, 'f', '1989-05-28', 'Wardland', 'Rwanda', '2021-04-10 22:36:52', '2021-01-13 05:12:59');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (36, 'm', '2008-10-03', 'Enachester', 'Tonga', '2021-04-04 07:41:03', '2020-12-03 19:13:19');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (37, 'm', '1996-01-02', 'Bergnaummouth', 'Macao', '2021-04-07 13:27:06', '2020-09-16 01:22:02');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (38, 'f', '2011-05-15', 'Port Hershelport', 'Sierra Leone', '2021-04-09 22:05:42', '2021-02-17 21:18:55');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (39, 'm', '1989-09-03', 'Wisokyhaven', 'Cocos (Keeling) Islands', '2021-04-28 20:33:09', '2020-12-12 05:06:30');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (40, 'm', '2003-07-31', 'West Donaldtown', 'Martinique', '2021-04-16 00:09:11', '2020-07-14 19:28:53');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (41, 'm', '1983-04-25', 'Daleville', 'Azerbaijan', '2021-04-15 05:21:30', '2021-01-14 11:20:02');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (42, 'm', '2000-11-24', 'Marcusmouth', 'Tunisia', '2021-04-17 16:09:59', '2021-04-19 14:13:48');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (43, 'm', '2017-01-16', 'Lake Kailynmouth', 'South Georgia and the South Sandwich Islands', '2021-04-08 14:31:00', '2020-05-18 15:00:08');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (44, 'f', '1973-05-12', 'Lake Lomahaven', 'Portugal', '2021-04-06 03:42:03', '2020-08-01 11:05:05');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (45, 'f', '1971-02-20', 'West Astrid', 'Maldives', '2021-04-10 05:07:18', '2020-09-22 15:08:04');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (46, 'm', '1994-08-14', 'New Raoul', 'Ireland', '2021-03-31 00:43:02', '2021-01-29 14:08:11');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (47, 'f', '1983-03-25', 'Antonioville', 'Mauritania', '2021-04-16 19:59:50', '2020-12-14 19:50:19');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (48, 'm', '1993-02-20', 'Kristopherton', 'Singapore', '2021-04-25 18:30:50', '2021-02-01 17:10:24');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (49, 'f', '1980-11-13', 'Javonville', 'Macao', '2021-04-04 01:08:18', '2020-05-09 19:13:16');
INSERT INTO `Profiles` (`user_id`, `gender`, `birthday`, `city`, `country`, `last_login`, `created_at`) VALUES (50, 'm', '1994-10-21', 'Prohaskaburgh', 'Cayman Islands', '2021-04-13 17:21:50', '2020-11-15 05:21:11');

)

DROP TABLE IF EXISTS `Students`;

CREATE TABLE `Students` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор пользователя',
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Почта',
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Телефон',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Студенты';
 скрытый текст : Данные для студентов(
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (1, 'Millie', 'Hintz', 'micheal85@example.com', '1-595-639-5838x82724');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (2, 'Johann', 'Bogisich', 'eluettgen@example.net', '00639107598');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (3, 'Jerad', 'Pacocha', 'ycrist@example.com', '911.627.4327x86174');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (4, 'Lionel', 'Collins', 'annie75@example.net', '(804)365-1335x746');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (5, 'Jordi', 'Skiles', 'jabari.gaylord@example.com', '(352)724-6869');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (6, 'Nichole', 'Hodkiewicz', 'parker.suzanne@example.org', '1-987-140-6184x7647');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (7, 'Barbara', 'Stroman', 'meggie49@example.com', '(999)060-4714');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (8, 'Annabel', 'Langosh', 'destini98@example.com', '(384)142-3368x03843');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (9, 'Lemuel', 'Kessler', 'julianne.schulist@example.net', '238.047.5898x41605');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (10, 'Eula', 'Wilderman', 'craig.zieme@example.net', '(421)712-3686x962');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (11, 'Forest', 'Weimann', 'nicolas.branson@example.net', '1-506-247-4674x2660');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (12, 'Lelia', 'Crooks', 'flatley.jaeden@example.net', '(279)367-1572x929');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (13, 'Arlie', 'Simonis', 'swift.judd@example.com', '1-505-951-6076');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (14, 'Hilton', 'Eichmann', 'alice13@example.org', '1-191-207-8788x85108');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (15, 'Abner', 'Pouros', 'melyssa87@example.com', '524.605.8717');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (16, 'Mollie', 'Quigley', 'nasir91@example.org', '(373)071-7514');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (17, 'Patrick', 'Treutel', 'nfeest@example.com', '(213)938-5706');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (18, 'Maynard', 'Hahn', 'carroll.lou@example.com', '226.104.3056x157');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (19, 'Robb', 'Harber', 'doyle.stiedemann@example.org', '07884294977');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (20, 'Evans', 'Jenkins', 'drake.watsica@example.com', '+33(6)5078127569');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (21, 'Katharina', 'Feest', 'tkemmer@example.org', '+35(9)8060398281');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (22, 'Braden', 'Toy', 'amari.torphy@example.com', '(599)166-9037x4335');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (23, 'Audie', 'Torphy', 'alesch@example.org', '(762)289-7941x76661');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (24, 'Bud', 'Koepp', 'jazlyn.olson@example.org', '1-968-983-7473x52382');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (25, 'Gus', 'Wolf', 'nglover@example.net', '442.056.0033');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (26, 'Ana', 'Howell', 'ondricka.chelsea@example.net', '00200144267');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (27, 'Letha', 'Ebert', 'newell.schowalter@example.com', '05496967453');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (28, 'Linnea', 'Gaylord', 'foster69@example.org', '779-708-4066x514');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (29, 'Brandon', 'O\'Connell', 'ibeatty@example.com', '110.583.0040');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (30, 'Missouri', 'Hahn', 'manuel18@example.net', '527.066.6335');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (31, 'Kamron', 'Kemmer', 'alana52@example.org', '1-754-188-2816');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (32, 'Jakayla', 'Cruickshank', 'agustin.renner@example.org', '1-798-401-7106x777');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (33, 'Mallie', 'Nicolas', 'adriana.o\'reilly@example.org', '(843)482-4546x9677');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (34, 'Oda', 'Jerde', 'obins@example.com', '(246)847-3959');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (35, 'Weldon', 'Bednar', 'general87@example.com', '852.243.4480');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (36, 'Nicolas', 'Klein', 'virginia91@example.com', '+19(7)6992018438');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (37, 'Adell', 'Ledner', 'jadyn.howe@example.net', '492-914-9806x130');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (38, 'Karolann', 'Kuphal', 'doris89@example.net', '943-638-0652');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (39, 'Izabella', 'Hoeger', 'harvey.whitney@example.org', '(056)609-8578');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (40, 'Jamey', 'D\'Amore', 'olson.justine@example.com', '1-775-564-6745');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (41, 'Gilberto', 'Gerhold', 'chad16@example.net', '950-085-0805x05778');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (42, 'Hailie', 'Wisoky', 'cordell19@example.net', '+79(1)3118365075');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (43, 'Graham', 'Larkin', 'jeromy55@example.com', '1-716-183-5172x75736');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (44, 'Virginie', 'Olson', 'laila.hagenes@example.org', '796-027-5033');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (45, 'Tessie', 'Schultz', 'jackson41@example.com', '774-148-2672x005');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (46, 'Foster', 'Lemke', 'von.winston@example.org', '648-778-7768x5236');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (47, 'Loy', 'Reichert', 'cade55@example.net', '(979)500-1866x55668');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (48, 'Elsie', 'Kihn', 'icartwright@example.net', '318-622-1542x876');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (49, 'Leanne', 'Hane', 'vance31@example.com', '320.092.8539x058');
INSERT INTO `Students` (`id`, `first_name`, `last_name`, `email`, `phone`) VALUES (50, 'Justen', 'Herzog', 'ndubuque@example.net', '(202)262-5553x961');

)
#
# TABLE STRUCTURE FOR: Tags
#

DROP TABLE IF EXISTS `Tags`;

CREATE TABLE `Tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Индитификатор тега',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название тега',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Теги';

#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сроки',
  `from_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `to_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Текст сообщения',
  `time_of_sending` datetime DEFAULT NULL COMMENT 'Время отправления сообщения',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  `is_read` tinyint(1) DEFAULT NULL COMMENT 'Прочитано/непрочитано',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Сообщения';


-- SET SQL_SAFE_UPDATES = 0;


-- начинаю приводить таблицу в нормальный вид
UPDATE profiles 
SET updated_at = NOW() 
WHERE updated_at < created_at;

alter table Students
	drop created_at
      drop updated_at
      
select *
from Courses;

-- исправляем цену курсов
update  Courses set
price = FLOOR(1 + RAND() * 1000)

-- изменяем название курсов


CREATE TEMPORARY TABLE tittle1(name VARCHAR(100));

INSERT INTO course_project.Courses (tittle, price, instructor_id) VALUES
  ('Artificial Intelligence',1,1),
  ('Web development',1,1),
  ('Python development',1,1),
  ('Frontend development',1,1),
  ('Smart Device Engineer',1,1),
  ('Fullstack JavaScript',1,1),
  ('C # development',1,1),
  ('C ++ development',1,1),
  ('VR / AR development',1,1);
  

update course_project.Courses
 set Artificial Intelligence = JavaScript

-- меняем id инструктора
update Courses
set instructor_id = FLOOR(1 + RAND() * 9)

-- instructors;

insert into course_project.Instructors (first_name, last_name) values
('Justin','Luis'),
('Poppy','Wood'),
('Mia','Boyka'),
('Anastasia','Krosh'),
('Ruby','Smith'),
('Ivan','Petrov'),
('Arcadiy','Tihonov'),
('Andrey','Vorobyev');

-- добавим типы успеваемости
insert into Academic_perfomance_type (name) values
('A*'),
('A'),
('B'),
('C'),
('D');
-- enrollment

-- как учаться студенты?



alter table course_project.Academic_perfomances
add study varchar(50) null;

-- копируем данные из одной таблице в другую

insert into Profiles (user_id)
select 'student_id' from course_project.Academic_perfomance


ALTER TABLE course_project.Academic_perfomance_type RENAME COLUMN name TO study;



insert into course_project.Academic_perfomances ('student_id')
select user_id from course_project.Profiles

INSERT INTO `Tags` VALUES 
(1,'introductory'),
(2,'initial'),
(3,'middle'),
(4,'advanced'),
(5,'Study'),
(6,'professional'),
(7,'expert')

INSERT INTO `Course_tags` VALUES 
(1,2),
(2,4),
(3,5),
(4,5),
(5,4),
(6,3),
(7,3),
(8,1),
(9,7),
(10,2);


-- создаем сообщения

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сроки',
  `from_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `to_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Текст сообщения',
  `time_of_sending` datetime DEFAULT NULL COMMENT 'Время отправления сообщения',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  `is_read` tinyint(1) DEFAULT NULL COMMENT 'Прочитано/непрочитано',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Сообщения';

(INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (1, 1, 1, 'Duchess, \'chop off her knowledge, as there was mouth enough for it to her very earnestly, \'Now, Dinah, tell me who YOU are, first.\' \'Why?\' said the Dormouse say?\' one of the country is, you ARE a.', '2021-04-16 18:55:28', 0, 1, '2021-04-05 00:16:46', '2020-09-26 22:13:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (2, 2, 2, 'Gryphon. \'Of course,\' the Gryphon replied rather impatiently: \'any shrimp could have been ill.\' \'So they were,\' said the Mock Turtle sighed deeply, and drew the back of one flapper across his eyes..', '2020-10-08 04:54:54', 0, 0, '2020-06-03 16:33:21', '2021-01-17 10:48:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (3, 3, 3, 'Alice, a little feeble, squeaking voice, (\'That\'s Bill,\' thought Alice,) \'Well, I should say what you had been (Before she had never forgotten that, if you were down here till I\'m somebody.', '2020-08-23 21:59:28', 0, 1, '2021-01-08 04:18:56', '2021-01-07 20:30:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (4, 4, 4, 'Mock Turtle: \'nine the next, and so on.\' \'What a funny watch!\' she remarked. \'It tells the day of the evening, beautiful Soup! Soup of the court. All this time the Queen never left off quarrelling.', '2020-06-19 05:54:34', 0, 0, '2020-08-05 11:17:34', '2020-12-31 13:24:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (5, 5, 5, 'WILL do next! If they had any sense, they\'d take the place where it had entirely disappeared; so the King said to herself; \'the March Hare said to herself. Imagine her surprise, when the White.', '2020-11-30 18:05:26', 1, 1, '2020-07-19 18:24:12', '2020-12-26 04:16:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (6, 6, 6, 'Alice remarked. \'Right, as usual,\' said the Lory. Alice replied very readily: \'but that\'s because it stays the same thing, you know.\' \'Not the same thing with you,\' said the Mock Turtle sang this,.', '2020-07-19 16:58:42', 1, 0, '2020-05-12 09:27:57', '2021-01-31 21:17:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (7, 7, 7, 'English coast you find a number of bathing machines in the pool was getting very sleepy; \'and they all stopped and looked anxiously over his shoulder as she did so, and were quite dry again, the.', '2020-09-01 00:34:59', 1, 0, '2020-06-03 13:27:21', '2020-06-27 21:19:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (8, 8, 8, 'Lizard in head downwards, and the Hatter went on for some time after the rest of my life.\' \'You are old, Father William,\' the young Crab, a little while, however, she went on saying to herself \'This.', '2021-02-12 15:50:56', 0, 0, '2021-01-26 17:25:06', '2020-06-15 01:20:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (9, 9, 9, 'Queen. \'You make me larger, it must be shutting up like a telescope.\' And so it was as much as serpents do, you know.\' Alice had learnt several things of this elegant thimble\'; and, when it saw mine.', '2020-05-29 16:38:38', 1, 1, '2021-01-19 09:30:44', '2020-05-10 22:38:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (10, 10, 10, 'Alice. \'Call it what you like,\' said the Duchess: you\'d better ask HER about it.\' \'She\'s in prison,\' the Queen to-day?\' \'I should think you\'ll feel it a violent shake at the mushroom for a minute,.', '2020-09-07 02:14:27', 1, 0, '2021-02-08 03:19:00', '2020-05-06 16:09:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (11, 11, 11, 'Alice thought she had never had fits, my dear, and that is rather a complaining tone, \'and they drew all manner of things--everything that begins with an important air, \'are you all ready? This is.', '2020-12-20 17:10:42', 1, 0, '2021-03-12 01:59:31', '2020-09-26 22:45:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (12, 12, 12, 'King said, for about the whiting!\' \'Oh, as to go down the chimney close above her: then, saying to her full size by this time). \'Don\'t grunt,\' said Alice; \'all I know I do!\' said Alice sharply, for.', '2020-06-08 17:58:01', 0, 1, '2020-11-18 21:15:04', '2021-01-08 20:17:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (13, 13, 13, 'Queen. \'Never!\' said the Mock Turtle replied, counting off the subjects on his spectacles and looked at the picture.) \'Up, lazy thing!\' said Alice, looking down at her hands, and was suppressed..', '2020-08-23 05:21:22', 0, 0, '2020-12-17 10:58:30', '2020-05-25 19:05:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (14, 14, 14, 'I know I have dropped them, I wonder?\' Alice guessed who it was, and, as the other.\' As soon as it is.\' \'Then you should say what you would have done that, you know,\' said Alice indignantly. \'Ah!.', '2020-11-05 10:41:18', 0, 0, '2020-07-14 15:25:54', '2021-02-18 18:38:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (15, 15, 15, 'Alice: \'allow me to him: She gave me a pair of white kid gloves, and she thought it would be of very little use without my shoulders. Oh, how I wish you were down here with me! There are no mice in.', '2020-09-23 15:01:20', 0, 1, '2021-04-09 20:52:07', '2020-06-02 10:28:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (16, 16, 16, 'Hatter went on, looking anxiously about as curious as it lasted.) \'Then the Dormouse fell asleep instantly, and neither of the window, and one foot to the dance. Will you, won\'t you, will you, won\'t.', '2020-12-14 22:43:35', 1, 1, '2020-08-27 18:59:38', '2020-12-31 15:36:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (17, 17, 17, 'King, \'and don\'t look at all what had become of me? They\'re dreadfully fond of beheading people here; the great puzzle!\' And she tried to get in?\' \'There might be some sense in your knocking,\' the.', '2021-04-11 02:40:44', 1, 1, '2020-12-17 05:35:10', '2020-10-24 18:02:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (18, 18, 18, 'Caterpillar. \'Well, perhaps your feelings may be ONE.\' \'One, indeed!\' said the Pigeon. \'I\'m NOT a serpent!\' said Alice very politely; but she knew she had quite a conversation of it appeared. \'I.', '2021-03-20 20:05:57', 1, 0, '2020-10-10 06:23:01', '2021-02-11 16:32:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (19, 19, 19, 'Five, in a tone of great curiosity. \'It\'s a Cheshire cat,\' said the Mock Turtle persisted. \'How COULD he turn them out with his tea spoon at the picture.) \'Up, lazy thing!\' said the King: \'leave out.', '2021-01-15 17:56:54', 0, 1, '2020-09-04 01:27:46', '2020-09-08 14:02:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (20, 20, 20, 'I suppose it were white, but there was generally a frog or a worm. The question is, Who in the sea. The master was an old Turtle--we used to it in the wood,\' continued the Hatter, \'you wouldn\'t talk.', '2020-08-27 19:49:21', 0, 1, '2020-05-08 19:45:30', '2021-01-16 02:04:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (21, 21, 21, 'Alice\'s elbow was pressed hard against it, that attempt proved a failure. Alice heard the Rabbit asked. \'No, I give it up,\' Alice replied: \'what\'s the answer?\' \'I haven\'t opened it yet,\' said the.', '2021-01-16 11:20:03', 0, 1, '2021-02-05 04:35:42', '2020-05-03 23:24:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (22, 22, 22, 'And certainly there was not quite sure whether it was quite tired of sitting by her sister on the floor, as it was addressed to the puppy; whereupon the puppy made another rush at Alice the moment.', '2021-03-03 14:21:08', 1, 1, '2020-08-26 18:59:46', '2021-02-11 09:08:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (23, 23, 23, 'WHAT?\' thought Alice; \'I must be the best cat in the pool, \'and she sits purring so nicely by the little door about fifteen inches high: she tried the effect of lying down on one knee as he wore his.', '2020-09-27 18:19:05', 0, 0, '2021-04-09 14:48:03', '2021-01-09 03:09:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (24, 24, 24, 'Alice remained looking thoughtfully at the top of her little sister\'s dream. The long grass rustled at her side. She was a large ring, with the tarts, you know--\' \'But, it goes on \"THEY ALL RETURNED.', '2020-09-14 03:19:09', 1, 1, '2020-05-11 23:48:09', '2020-10-25 11:45:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (25, 25, 25, 'I am to see how he can EVEN finish, if he had a little startled when she had somehow fallen into the sky all the right way to hear his history. I must have imitated somebody else\'s hand,\' said the.', '2020-06-05 04:06:52', 1, 0, '2020-09-04 16:30:02', '2020-11-08 14:44:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (26, 26, 26, 'Adventures of hers that you had been for some way, and nothing seems to like her, down here, that I should think you can find out the Fish-Footman was gone, and, by the whole thing very absurd, but.', '2020-11-20 01:34:50', 1, 1, '2021-03-29 19:43:15', '2020-06-09 18:53:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (27, 27, 27, 'Footman\'s head: it just grazed his nose, and broke to pieces against one of these cakes,\' she thought, \'and hand round the court and got behind Alice as he spoke, and then Alice dodged behind a.', '2020-10-17 12:41:02', 1, 0, '2021-03-22 01:01:08', '2020-12-14 18:57:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (28, 28, 28, 'While she was near enough to get into that lovely garden. I think you\'d take a fancy to cats if you like,\' said the King; and the small ones choked and had been running half an hour or so there were.', '2020-05-24 05:32:47', 0, 1, '2020-08-30 07:45:33', '2021-03-09 04:38:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (29, 29, 29, 'White Rabbit read:-- \'They told me you had been to the little golden key was lying on the spot.\' This did not like to be true): If she should meet the real Mary Ann, and be turned out of the day;.', '2020-05-24 16:57:15', 0, 1, '2021-04-21 10:01:42', '2021-04-20 22:43:23');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (30, 30, 30, 'Alice, \'to pretend to be trampled under its feet, ran round the thistle again; then the other, trying every door, she ran off at once: one old Magpie began wrapping itself up and down in a.', '2020-11-21 20:54:22', 1, 1, '2020-05-27 09:41:29', '2021-02-01 03:53:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (31, 31, 31, 'At last the Mouse, getting up and picking the daisies, when suddenly a White Rabbit interrupted: \'UNimportant, your Majesty means, of course,\' said the Hatter: \'as the things I used to read.', '2021-04-06 22:13:40', 1, 1, '2020-10-23 09:27:05', '2020-05-18 05:42:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (32, 32, 32, 'The Panther took pie-crust, and gravy, and meat, While the Panther received knife and fork with a soldier on each side to guard him; and near the entrance of the door between us. For instance, if.', '2021-04-14 02:11:40', 0, 1, '2020-10-31 01:39:13', '2020-11-21 14:13:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (33, 33, 33, 'That WILL be a lesson to you how the Dodo could not remember ever having seen in her pocket, and pulled out a box of comfits, (luckily the salt water had not a VERY good opportunity for making her.', '2021-03-09 21:28:45', 0, 1, '2021-03-31 22:54:40', '2020-11-15 00:13:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (34, 34, 34, 'Hatter, \'when the Queen to-day?\' \'I should think you\'ll feel it a violent shake at the corners: next the ten courtiers; these were ornamented all over their shoulders, that all the first figure,\'.', '2020-12-17 07:42:12', 0, 1, '2020-05-21 00:35:55', '2020-06-19 17:07:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (35, 35, 35, 'Some of the lefthand bit of the Queen\'s ears--\' the Rabbit came up to them she heard a voice she had finished, her sister was reading, but it was looking about for a minute, trying to explain the.', '2020-09-30 19:26:46', 0, 1, '2020-07-29 16:36:55', '2021-01-09 20:48:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (36, 36, 36, 'There was no \'One, two, three, and away,\' but they were nowhere to be lost: away went Alice like the right height to be.\' \'It is wrong from beginning to write out a history of the earth. Let me see:.', '2020-10-08 15:16:40', 1, 1, '2020-08-17 19:32:14', '2021-02-25 05:40:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (37, 37, 37, 'VERY good opportunity for repeating his remark, with variations. \'I shall do nothing of the jurymen. \'No, they\'re not,\' said the March Hare will be the right words,\' said poor Alice, who always took.', '2020-12-09 17:23:33', 0, 0, '2020-08-21 16:46:02', '2020-10-12 20:21:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (38, 38, 38, 'CHAPTER IX. The Mock Turtle a little girl or a watch to take the roof off.\' After a while she remembered trying to put his mouth close to her, though, as they were nowhere to be treated with.', '2020-08-18 08:49:42', 0, 1, '2020-09-03 06:48:09', '2020-12-30 09:03:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (39, 39, 39, 'She said the Hatter. \'It isn\'t directed at all,\' said the Gryphon, the squeaking of the suppressed guinea-pigs, filled the air, mixed up with the Queen never left off quarrelling with the time,\' she.', '2020-05-04 16:12:10', 1, 1, '2021-04-27 06:40:36', '2021-01-12 15:13:23');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (40, 40, 40, 'I begin, please your Majesty?\' he asked. \'Begin at the stick, and held it out into the darkness as hard as he spoke, \'we were trying--\' \'I see!\' said the Mouse was swimming away from her as she.', '2020-07-22 03:51:10', 1, 1, '2020-07-30 01:50:08', '2021-02-28 16:36:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (41, 41, 41, 'So she set to work throwing everything within her reach at the Duchess to play with, and oh! ever so many tea-things are put out here?\' she asked. \'Yes, that\'s it,\' said Alice, looking down at her.', '2020-12-28 08:51:29', 1, 0, '2021-02-13 01:27:25', '2021-04-27 21:33:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (42, 42, 42, 'I suppose?\' said Alice. \'Nothing WHATEVER?\' persisted the King. \'Shan\'t,\' said the Duchess. An invitation for the first really clever thing the King repeated angrily, \'or I\'ll have you executed on.', '2021-01-15 09:03:43', 1, 1, '2020-11-16 07:01:17', '2020-07-31 10:27:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (43, 43, 43, 'I don\'t like them raw.\' \'Well, be off, and had just upset the week before. \'Oh, I beg your pardon,\' said Alice desperately: \'he\'s perfectly idiotic!\' And she thought at first was moderate. But the.', '2021-01-03 09:21:47', 1, 1, '2021-02-18 19:24:43', '2020-09-22 10:24:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (44, 44, 44, 'I get\" is the use of a muchness\"--did you ever saw. How she longed to change the subject,\' the March Hare and the little thing grunted in reply (it had left off sneezing by this time, and was just.', '2020-11-25 11:23:51', 1, 0, '2020-05-19 10:40:11', '2020-06-27 11:24:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (45, 45, 45, 'And it\'ll fetch things when you come to the executioner: \'fetch her here.\' And the Gryphon repeated impatiently: \'it begins \"I passed by his face only, she would get up and say \"How doth the little.', '2020-11-07 14:24:53', 0, 0, '2020-06-01 00:35:27', '2020-10-24 00:23:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (46, 46, 46, 'She hastily put down her flamingo, and began staring at the stick, and made another rush at the stick, running a very pretty dance,\' said Alice doubtfully: \'it means--to--make--anything--prettier.\'.', '2020-10-01 17:36:56', 0, 0, '2020-12-05 22:06:59', '2020-05-07 13:18:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (47, 47, 47, 'Cat. \'I said pig,\' replied Alice; \'and I do so like that curious song about the games now.\' CHAPTER X. The Lobster Quadrille The Mock Turtle said: \'advance twice, set to work nibbling at the Lizard.', '2020-07-20 18:44:49', 0, 1, '2020-09-09 06:59:36', '2021-01-15 00:37:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (48, 48, 48, 'Oh, how I wish I hadn\'t gone down that rabbit-hole--and yet--and yet--it\'s rather curious, you know, and he wasn\'t going to be, from one minute to another! However, I\'ve got to the door, staring.', '2020-11-08 23:56:14', 0, 1, '2021-02-27 01:14:58', '2021-02-06 12:34:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (49, 49, 49, 'Pinch him! Off with his nose, and broke to pieces against one of the jurymen. \'It isn\'t directed at all,\' said Alice: \'--where\'s the Duchess?\' \'Hush! Hush!\' said the Mouse, sharply and very soon.', '2020-11-07 16:07:17', 0, 0, '2021-01-06 04:38:51', '2021-03-31 23:29:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `time_of_sending`, `is_delivered`, `is_read`, `created_at`, `updated_at`) VALUES (50, 50, 50, 'Hatter: \'as the things between whiles.\' \'Then you shouldn\'t talk,\' said the Mock Turtle sighed deeply, and began, in a minute or two sobs choked his voice. \'Same as if a fish came to the Gryphon..', '2020-12-29 00:40:13', 1, 0, '2021-01-24 12:32:45', '2020-05-26 17:53:26');
)

-- приводим в порядок временные метки.
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;

-- Исправляем ссылки на пользователей
UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 50),
  to_user_id = FLOOR(1 + RAND() * 50);
  
  -- Исправляем время отправки сообщения
UPDATE messages SET

UPDATE messages SET time_of_sending = NOW() WHERE time_of_sending < created_at;


-- academic_perfomances

update Academic_perfomances SET student_id = FLOOR(1 + RAND() * 50);



insert into course_project.Enrollment (student_id, course_id, date, price) values
('1','1','2021-03-03', '650.00');

insert into course_project.Enrollment set course_id = FLOOR(1 + RAND() * 10)


DROP TABLE IF EXISTS `Enrollment`;

CREATE TABLE `Enrollment` (
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Зачислен на выбранный курс';

скрытый текст. Вставляем данные для Зачисления. (
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (1, 5, '2021-04-09 16:24:13');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (2, 5, '2021-04-02 08:23:46');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (3, 4, '2021-04-12 18:26:50');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (4, 2, '2021-04-09 16:10:27');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (5, 1, '2021-04-13 00:01:28');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (6, 2, '2021-04-24 21:16:50');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (7, 9, '2021-04-13 12:29:07');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (8, 5, '2021-04-01 16:47:03');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (9, 1, '2021-04-05 16:02:39');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (10, 2, '2021-04-25 07:22:29');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (11, 4, '2021-04-25 09:47:45');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (12, 5, '2021-04-15 13:30:05');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (13, 4, '2021-04-23 06:05:47');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (14, 5, '2021-04-06 20:46:46');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (15, 8, '2021-04-26 23:08:19');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (16, 8, '2021-04-28 10:44:26');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (17, 10, '2021-04-15 20:48:41');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (18, 8, '2021-04-01 19:04:39');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (19, 2, '2021-04-14 23:48:14');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (20, 2, '2021-04-12 08:26:57');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (21, 3, '2021-04-10 07:57:11');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (22, 1, '2021-04-17 14:59:35');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (23, 2, '2021-04-13 21:26:08');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (24, 1, '2021-04-30 00:31:57');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (25, 7, '2021-04-15 09:46:09');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (26, 7, '2021-04-08 16:29:19');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (27, 3, '2021-04-02 05:12:09');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (28, 2, '2021-04-06 07:21:12');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (29, 2, '2021-04-23 02:10:59');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (30, 9, '2021-04-23 13:14:54');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (31, 2, '2021-04-02 14:35:58');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (32, 2, '2021-04-27 16:14:08');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (33, 2, '2021-04-17 21:27:09');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (34, 1, '2021-04-11 09:17:18');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (35, 2, '2021-04-21 09:40:50');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (36, 5, '2021-04-09 11:56:50');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (37, 9, '2021-04-12 21:41:43');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (38, 10, '2021-04-23 07:51:10');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (39, 1, '2021-04-03 02:07:06');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (40, 4, '2021-04-02 14:09:33');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (41, 5, '2021-04-13 14:09:08');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (42, 1, '2021-04-18 09:54:53');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (43, 2, '2021-04-09 06:50:54');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (44, 4, '2021-04-26 10:08:59');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (45, 2, '2021-04-19 08:33:12');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (46, 2, '2021-04-22 01:23:29');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (47, 7, '2021-04-21 20:49:40');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (48, 3, '2021-04-09 10:54:58');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (49, 10, '2021-04-07 10:19:03');
INSERT INTO `Enrollment` (`student_id`, `course_id`, `date`) VALUES (50, 9, '2021-04-14 15:15:27');
)

update
Academic_perfomances ap
join Profiles p
on ap.id = p.user_id
set ap.student_id = p.user_id 

-- итоговая бд готова!! делаем внешние ключи.

alter table Profiles
	add constraint profiles_user_id_fk
	foreign key (user_id) references Students(id)
      on delete cascade;
	
      
alter table Profiles
		add constraint profiles_user_id_messages_id_fk
            foreign key (user_id) references messages(id)
            on delete cascade;


alter table Profiles
	add constraint profiles_user_id_student_id_fk
	foreign key (user_id) references Enrollment(student_id)
      on delete cascade;
      
alter table Courses
	add constraint Courses_id_course_course_tags_fk
      foreign key (id) references Course_tags(course_id)
      on delete cascade;
      
alter table Course_tags
	add constraint Course_tags_course_id_tags_id_fk
      foreign key(tag_id) references Tags(id)
      on delete cascade;

alter table Courses
	add constraint Courses_id_Instructors_id_fk
      foreign key (id) references Instructors(id)
      on delete cascade;

alter table Enrollment
	add constraint  Enrollment_course_id_Courses_id_fk
      foreign key (course_id ) references Courses(id)
      on delete cascade;

alter table Academic_perfomance_type
	add constraint Academic_perfomance_type_id_academic_perfomance_id_fk
      foreign key (id) references Academic_perfomances(id)
      on delete cascade;

alter table Academic_perfomance_type
	add constraint Academic_perfomance_type_id_courses_id_fk
      foreign key(id) references Courses(id)
      on delete cascade;
      
-- создаем индексы, наиболее распространенных запросов.
create index courses_tittle_inx on Courses(tittle);
create index Tags_name_idx on Tags(name);
create index profiles_gender_idx on Profiles(gender);
create index profiles_country_idx on Profiles(country);
create index profiles_city_idx on Profiles(city);

      
-- делаем выборки. Например, нам нужны студенты, которые учатся отлично (А)

select concat(first_name, ' ', last_name) as 'Отличники'
from Students s
	join Profiles p
		on s.id = p.user_id
	join Academic_perfomances ap
		on ap.student_id = p.user_id
	join Academic_perfomance_type apt
		on ap.study = apt.id
where apt.study = 'A*'

-- сколько студентов учаться на курсе по javaScript

select count(*)
from Courses c
join Enrollment e
	on c.id = e.course_id
      where tittle = 'JavaScript'
      
-- Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы;
-- среднее количество пользователей в группах;
-- самый молодой пользователь в группе;
-- самый старший пользователь в группе;
-- общее количество пользователей в группе;

select distinct c.tittle as Name_course,
	count(e.student_id) over()/
      (select count(*) from Courses) as avg_users_groups,
	max(p.birthday) over (partition by e.course_id) as The_youngest,
      min(p.birthday) over (partition by e.course_id) as The_oldest,
      count(p.user_id) over (partition by e.course_id) as User_in_group,
      (select count(*) from Profiles) as Users_total,
	sum(p.user_id) over (partition by e.course_id) / sum(p.user_id) over () * 100 as '%%'
from Profiles p
	left join Enrollment e
		on p.user_id = e.student_id
	left join Courses c
		on e.course_id = c.id


-- хранимые процедуры и триггеры;

DELIMITER $$
create procedure get_courses()
begin
	select *
	from Courses
	where price > 600;
end $$
DELIMITER ;

call get_courses()

DELIMITER $$
CREATE PROCEDURE get_tags ()
BEGIN
select *
from Tags;
END$$
DELIMITER ;

call get_tags();

-- поиск студентов которые обучаются на курсе
delimiter $$
create procedure get_courses_by_student_id
(
	course_id int
)
begin
select *
from Enrollment e
where e.course_id = course_id;
END$$
delimiter ;

call get_courses_by_student_id(1)
