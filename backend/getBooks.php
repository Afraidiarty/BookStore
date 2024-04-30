<?php
include 'core/func.php';

$query = "SELECT * FROM books";
$result = $conn->query($query);

if (!$result) {
    die("Ошибка запроса: " . $conn->error);
}

// Получение данных
$books = [];
while ($row = $result->fetch_assoc()) {
    $books[] = $row;
}

// Установка заголовка и вывод данных в формате JSON
header('Content-Type: application/json');
echo json_encode($books);
?>