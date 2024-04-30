<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');


$servername = "localhost"; // Имя сервера базы данных
$username = "root"; // Имя пользователя базы данных
$password = ""; // Пароль пользователя базы данных
$database = "Books"; // Название базы данных
// Создание подключения
$conn = new mysqli($servername, $username, $password, $database);

// Проверка соединения
if ($conn->connect_error) {
    //die("Ошибка подключения: " . $conn->connect_error);
} else {
    //echo "Подключение успешно!";
}


?>