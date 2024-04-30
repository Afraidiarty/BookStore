-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 28 2024 г., 19:49
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
(16, '45', '45', 'Издатель', 'фантастика', 'Описание книи', 11, 153, '662121bdea60d.jpeg'),
(18, 'Harry Poter', 'Роулинг', 'Издатель', 'фэнтези', 'Описание', 231, 11, '66213f76b2a5e.jpeg'),
(19, 'Запомни меня навсегда', 'Дюран Сабин', 'Издатель', 'триллер', 'описание', 11, 1, '662a4ed12adc5.jpeg'),
(20, 'В тихом омуте', 'Уокер', 'Издатель', 'триллер', 'Серия «Психологический триллер» объединяет бестселлеры жанра, написанные популярными зарубежными авторами. Среди них — экранизированная «Девушка в поезде» Пола Хокинса, «Запомни меня навсегда» Сабин Дюран, «Подарок» Луизы Дженсен, «Каменная пациентка» Эрин Келли, «Ваш муж мертв» Джейн Корри, «Секретарь» Рени Найт, «Выжить любой ценой» Эмили Барр и не только.', 432, 15, '662a4f2891cbe.jpeg');

-- --------------------------------------------------------

--
-- Структура таблицы `commercial`
--

CREATE TABLE `commercial` (
  `ID` int NOT NULL,
  `book_id` int DEFAULT NULL,
  `countOfSales` int DEFAULT NULL,
  `rating` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `commercial`
--

INSERT INTO `commercial` (`ID`, `book_id`, `countOfSales`, `rating`) VALUES
(11, 16, NULL, 5),
(13, 18, NULL, 3.1429),
(14, 19, NULL, NULL),
(15, 20, NULL, 4),
(16, 21, NULL, NULL);

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
(6, 'Harry Poter', '1234'),
(7, 'Запомни меня навсегда', '1234'),
(8, 'Hamp', '1234'),
(9, 'Harry Poter', '1234');

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
(14, 16, 18, 5, 14),
(15, 16, 18, 1, 15),
(16, 16, 18, 3, 16),
(17, 16, 18, 4, 17),
(18, 16, 16, 5, 18),
(19, 11, 18, 2, 19),
(20, 11, 18, 2, 20),
(21, 11, 18, 5, 21),
(22, 11, 20, 4, 22);

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
(15, 18, 16, '((((((\n\n', '123456', 1),
(18, 16, 16, 'я в щуке!', '123456', 5),
(19, 18, 11, '5474567', '1234', 2),
(20, 18, 11, 'НЕБУЦО', '1234', 2),
(21, 18, 11, 'ДОБАВИЛ КОММЕНТ', '1234', 5);

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
(16, '123456', '$2y$10$8ZiA05nLSyYU81FgwLGpaOQn2gDNwPZGZYbxannOBqVYTML//pyIm', 1, '11456456@gmail.com');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `commercial`
--
ALTER TABLE `commercial`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `history_buy`
--
ALTER TABLE `history_buy`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `user_order`
--
ALTER TABLE `user_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `User_Table`
--
ALTER TABLE `User_Table`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
