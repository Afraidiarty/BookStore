<?php
include 'core/func.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];
}

$query = "SELECT * FROM books WHERE id = '$id'";
$result = $conn->query($query);

if (!$result) {
    die("Ошибка запроса: " . $conn->error);
}

$books = [];
$row = mysqli_fetch_assoc($result);
$books[] = $row;

header('Content-Type: application/json');
echo json_encode($books);
?>