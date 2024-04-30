<?php
include 'core/func.php';

$json = file_get_contents('php://input');
$data = json_decode($json, true);

if (isset($data['username'])) {
    $username = $data['username'];
    $query = "SELECT * FROM User_Table WHERE name = '$username'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        $users_info = mysqli_fetch_assoc($result);
        if ($users_info) {
            echo json_encode($users_info); 
        } else {
            //echo json_encode(array('error' => 'Пользователь не найден'));
        }
    } else {
       // echo json_encode(array('error' => 'Ошибка запроса к базе данных: ' . mysqli_error($conn)));
    }
} else {
   // echo json_encode(array('error' => 'Ошибка: переменная "username" не определена.'));
}
?>