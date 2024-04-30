<?php


if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header('Access-Control-Allow-Origin: http://localhost:8080');
    header('Access-Control-Allow-Methods: POST');
    header('Access-Control-Allow-Headers: Content-Type');
    header('Content-Type: application/json');

    exit();
}

include 'core/func.php';


$username = $_POST['username'];
$password = $_POST['password'];

echo $username;

$stmt = $conn->prepare("SELECT * FROM User_Table WHERE name = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 1) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        http_response_code(200);
        header('Content-Type: application/json');
        echo json_encode(array('message' => 'Login successful.'));
    } else {
        http_response_code(401);
        header('Content-Type: application/json');
        echo json_encode(array('message' => 'Invalid username or password.'));
    }
} else {
    http_response_code(401);
    header('Content-Type: application/json');
    echo json_encode(array('message' => 'Invalid username or password.'));
}
?>