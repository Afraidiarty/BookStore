-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 30 2024 г., 17:33
-- Версия сервера: 8.0.30
-- Версия PHP: 8.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Books`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Books`
--

CREATE TABLE `Books` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `izdatel` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `description` text,
  `pageCount` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `coverImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Books`
--

INSERT INTO `Books` (`id`, `title`, `author`, `izdatel`, `genre`, `description`, `pageCount`, `price`, `coverImage`) VALUES
(16, 'Ведьмак', 'Ведьмаковский', 'Издатель', 'фантастика', 'Описание книи', 11, 153, '662121bdea60d.jpeg'),
(18, 'Harry Potter', 'Роулинг', 'Издатель', 'фантастика', 'Описание', 231, 11, '66213f76b2a5e.jpeg'),
(19, 'Запомни меня навсегда', 'Дюран Сабин', 'Издатель', 'триллер', 'описание', 11, 1, '662a4ed12adc5.jpeg'),
(20, 'В тихом омуте', 'Уокер', 'Издатель', 'триллер', 'Серия «Психологический триллер» объединяет бестселлеры жанра, написанные популярными зарубежными авторами. Среди них — экранизированная «Девушка в поезде» Пола Хокинса, «Запомни меня навсегда» Сабин Дюран, «Подарок» Луизы Дженсен, «Каменная пациентка» Эрин Келли, «Ваш муж мертв» Джейн Корри, «Секретарь» Рени Найт, «Выжить любой ценой» Эмили Барр и не только.', 432, 15, '662a4f2891cbe.jpeg'),
(22, '1984', 'Джордж Оруэлл', 'Penguin Books', 'фантастика', '\"1984\" — это захватывающий роман, который касается вопросов свободы, контроля, истории и личной идентичности. Оруэлл создал мир, где правительство всегда следит за каждым шагом, истерзая индивидуальность и свободу мысли.', 328, 10, '6630c7936769d.jpeg'),
(23, 'Игра престолов', 'Джордж Р. Р. Мартин', 'Bantam Books', 'фэнтези', '\"Игра престолов\" — это первая книга в серии \"Песнь Льда и Пламени\", которая описывает борьбу за власть в вымышленном мире Вестерос. Сложные персонажи, непредсказуемые интриги и неожиданные повороты событий делают эту книгу захватывающим читательским опытом.', 694, 15, '6630c85ce9de8.jpeg'),
(24, 'Война и мир', 'Лев Толстой', 'Vintage Classics', 'роман', '\"Война и мир\" - это великолепный эпический роман, который охватывает период Наполеоновских войн и их влияние на жизнь русской знати. Толстой мастерски описывает битвы, любовь, семейные отношения и моральные дилеммы.', 1392, 18, '6630c8b6d1b69.jpeg'),
(25, 'Убить пересмешника', 'Харпер Ли', 'J. B. Lippincott & Co.', 'роман', '\"Убить пересмешника\" — это история о расизме и невинности в Алабаме 1930-х годов, рассказанная через глаза ребенка, Скаута Финча. Это произведение обращается к глубоким вопросам справедливости и сострадания.', 324, 10, '6630c8dd26b47.jpeg'),
(26, 'Алиса в Стране чудес', 'Льюис Кэрролл', 'Macmillan Publishers', 'приключения', '\"Алиса в Стране чудес\" — это классическая сказка о приключениях девочки по имени Алиса, которая попадает в волшебный мир, полный странных существ и необъяснимых явлений. Это путешествие открывает для нее новые миры и самопонимание.', 192, 7, '6630c902684fd.jpeg'),
(27, 'Атлант расправил плечи', 'Айн Рэнд', 'Random House', 'роман', 'Этот роман рассказывает историю борьбы индивидуализма и креативности против коллективизма и конформизма в современном обществе. Айн Рэнд исследует идеи эгоизма и капитализма через глаза своих героев.', 1168, 20, '6630ca80c2fc3.jpeg'),
(28, 'Тень ветра', 'Карлос Руис Сафон', 'Planeta', 'роман', 'В этом захватывающем романе рассказывается история о поисках таинственной книги, которая становится обреченной любовью, тайнами и загадками в доживающем до наших дней Барселоне.', 576, 14, '6630cac074e19.jpeg'),
(29, 'Сто лет одиночества', 'Габриэль Гарсиа Маркес', 'Editorial Sudamericana', 'фэнтези', 'Этот роман рассказывает историю о семье Буэндиа и их долгом пути через поколения, полный странных событий, чудес и трагедий.', 432, 11, '6630cafbe561e.jpeg'),
(30, 'Преступление и наказание', 'Фёдор Достоевский', 'Vintage Classics', 'роман', '\"Преступление и наказание\" — это классический роман о моральных дилеммах, преступлении и его последствиях. Достоевский исследует вопросы вины, искупления и нравственной ответственности через историю студента Раскольникова.', 576, 13, '6630cbd7471ae.jpeg'),
(31, 'Имя ветра', 'Патрик Ротфусс', 'DAW Books', 'фэнтези', '\"Имя ветра\" — это первая книга в серии \"Хроника убийцы королей\", рассказывающая историю Квотэ Квотрена, легендарного героя и чародея. Это история о приключениях, магии и поиске собственного места в мире.', 672, 16, '6630cc3ce9a45.jpeg');

-- --------------------------------------------------------

--
-- Структура таблицы `commercial`
--

CREATE TABLE `commercial` (
  `ID` int NOT NULL,
  `book_id` int DEFAULT NULL,
  `rating` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `commercial`
--

INSERT INTO `commercial` (`ID`, `book_id`, `rating`) VALUES
(11, 16, 0),
(13, 18, 0),
(14, 19, NULL),
(15, 20, 0),
(16, 21, NULL),
(17, 22, NULL),
(18, 23, NULL),
(19, 24, NULL),
(20, 25, NULL),
(21, 26, 0),
(22, 27, 4.5),
(23, 28, NULL),
(24, 29, NULL),
(25, 30, NULL),
(26, 31, NULL),
(27, 32, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `history_buy`
--

CREATE TABLE `history_buy` (
  `id` int NOT NULL,
  `book_name` varchar(122) NOT NULL,
  `name` varchar(122) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `history_buy`
--

INSERT INTO `history_buy` (`id`, `book_name`, `name`) VALUES
(13, 'Война и мир', '1234');

-- --------------------------------------------------------

--
-- Структура таблицы `rating`
--

CREATE TABLE `rating` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `rating`
--

INSERT INTO `rating` (`id`, `user_id`, `book_id`, `rating`, `review_id`) VALUES
(25, 11, 26, 1, 25),
(26, 11, 27, 4, 26),
(27, 11, 27, 5, 27);

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int UNSIGNED NOT NULL,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `text` text NOT NULL,
  `name` varchar(122) NOT NULL,
  `rating` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `book_id`, `user_id`, `text`, `name`, `rating`) VALUES
(25, 26, 11, 'книга фигня', '1234', 1),
(27, 27, 11, '3456456', '1234', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `user_order`
--

CREATE TABLE `user_order` (
  `id` int NOT NULL,
  `FIO` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `book_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `User_Table`
--

CREATE TABLE `User_Table` (
  `UserID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `levelAccess` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `User_Table`
--

INSERT INTO `User_Table` (`UserID`, `name`, `password`, `levelAccess`, `email`) VALUES
(1, NULL, NULL, 1, NULL),
(2, NULL, NULL, 1, NULL),
(3, NULL, NULL, 1, NULL),
(4, NULL, NULL, 1, NULL),
(5, NULL, NULL, 1, NULL),
(6, NULL, NULL, 1, NULL),
(7, '3456', '546', 1, '456456@gmail.com'),
(8, NULL, NULL, 1, NULL),
(9, 'лоин', '123456', 1, '43454525@gmail.com'),
(10, '3546456', '$2y$10$o.i1wBn7dH2xHYkWehX.ueWUC0fMC/Tt0YpVQNHFuV0G3/iuh.RhS', 1, '5463456@gmail.com'),
(11, '1234', '$2y$10$sPhrPUWvm/YHNCTvq0xjL.VIRqzXgkG0tzFX/kKqGd.xrJNitRM9e', 2, '4564356@gmail.com'),
(12, '12345', '$2y$10$MHEitDBmd.9giSCuxsR7OutVymxQXpWCHXyAPnJtgCVJoBDg9skVy', 1, '4354656456@gmail.com'),
(13, '123476', '$2y$10$g.3YBRMCntwKgV/CVGuN9uLLvbftF//dC34b2HP64zxX4DP2k2TZ.', 1, '456456@gmail.com3'),
(14, 'login', '$2y$10$nTHtjo6ea9u2WBlkPucheO/YMzKWXTU3P6wUTRzHzkxgH3F3cPZgq', 1, '45126456@gmail.com'),
(15, 'Логин', '$2y$10$izk0FjOvQ27zRRDwpGw7geLhSCpWJ09MgGtG9v0a5sjRci8FJJtgq', 1, 'foerf435@gmail.com'),
(16, '123456', '$2y$10$8ZiA05nLSyYU81FgwLGpaOQn2gDNwPZGZYbxannOBqVYTML//pyIm', 1, '11456456@gmail.com'),
(17, 'vova', '$2y$10$6K28gOQTT7BYCOicMHYyV.9SoHsDULfOUfE3W/WwouPhhM4TTKiR.', 2, 'vova1234@gmail.com');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `commercial`
--
ALTER TABLE `commercial`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `history_buy`
--
ALTER TABLE `history_buy`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_order`
--
ALTER TABLE `user_order`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `User_Table`
--
ALTER TABLE `User_Table`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Books`
--
ALTER TABLE `Books`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `commercial`
--
ALTER TABLE `commercial`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `history_buy`
--
ALTER TABLE `history_buy`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `user_order`
--
ALTER TABLE `user_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `User_Table`
--
ALTER TABLE `User_Table`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
