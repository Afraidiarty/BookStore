<?php

include 'core/func.php';

$Title = $_POST['title'];
$Author = $_POST['author'];
$Publisher = $_POST['izdatel'];
$Genre = $_POST['genre'];
$Description = $_POST['desc']; 
$PageCount = $_POST['PageCount'];
$price = $_POST['price'];

$CoverImage = $_FILES['file'];

// Разрешенные типы файлов
$allowedTypes = ['image/jpeg', 'image/png'];

if ($CoverImage['error'] === UPLOAD_ERR_OK) {
    $tempPath = $CoverImage['tmp_name'];
    $fileInfo = getimagesize($tempPath); // Получаем информацию о файле
    $fileMimeType = $fileInfo['mime']; // Тип MIME файла

    // Проверяем тип файла
    if (in_array($fileMimeType, $allowedTypes)) {
        $fileExtension = image_type_to_extension($fileInfo[2]); // Получаем расширение файла из типа изображения
        $fileName = uniqid() . $fileExtension;
        $uploadDir = '../front/src/uploads/';
        $targetPath = $uploadDir . $fileName;

        if (move_uploaded_file($tempPath, $targetPath)) {
            echo "Успешно";
        } else {
            echo "Провал";
        }
    } else {
        echo "Ошибка: Разрешены только файлы JPEG и PNG.";
        exit(); // Прерываем выполнение скрипта, чтобы предотвратить дальнейшее выполнение кода
    }
} else {
    echo "Ошибка: " . $CoverImage['error'];
    exit(); // Прерываем выполнение скрипта, чтобы предотвратить дальнейшее выполнение кода
}

$query = "INSERT INTO `Books` (title, author, izdatel, genre, description, pageCount, price , coverImage) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("sssssiis", $Title, $Author, $Publisher, $Genre, $Description, $PageCount, $price, $fileName);

if ($stmt->execute()) {
    $book_id = $conn->insert_id;
    $stmt->close();
    
    $query2 = "INSERT INTO `commercial` (book_id, rating) VALUES (?, ?, ?)";
    $stmt2 = $conn->prepare($query2);
    $stmt2->bind_param("iii", $book_id, $rating);

    if ($stmt2->execute()) {
        $stmt2->close();
        echo "Data inserted successfully.";
    } else {
        echo "Error inserting data into commercial table: " . $conn->error;
    }
} else {
    echo "Error inserting data into Books table: " . $conn->error;
}

// Закрыть соединение
$conn->close();

?>