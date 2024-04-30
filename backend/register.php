<?php
include 'core/func.php';

$name = $_POST['username'];
$email = $_POST['email'];
$pass = $_POST['password'];
$levelAccess = 1;

$hashedPassword = password_hash($pass, PASSWORD_DEFAULT);

$stmt_check = $conn->prepare("SELECT * FROM User_Table WHERE name = ? OR email = ?");
$stmt_check->bind_param("ss", $name, $email);
$stmt_check->execute();
$result = $stmt_check->get_result();

$response = array();

if ($result->num_rows > 0) {
    $response['isSuccess'] = false;
    $response['message'] = "Имя или Email уже заняты";
} else {
    
    $stmt_insert = $conn->prepare("INSERT INTO User_Table (name, email, password, levelAccess) VALUES (?, ?, ?, ?)");
    $stmt_insert->bind_param("sssi", $name, $email, $hashedPassword, $levelAccess);

    if ($stmt_insert->execute()) {
        $response['isSuccess'] = true;
        $response['message'] = "Успешная регестрация";
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Ошибка регистрации пользователя: " . $stmt_insert->error;
    }
}

echo json_encode($response);
?>