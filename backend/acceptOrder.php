<?php
include 'core/func.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    if (isset($_POST["name"]) && isset($_POST["book_name"]) && isset($_POST["id_order"])) {
        
        $name = $_POST["name"];
        $book_name = $_POST["book_name"];
        $id_order = $_POST["id_order"];
        
        
        $stmt = $conn->prepare("INSERT INTO history_buy (name, book_name) VALUES (?, ?)");

        $stmt->bind_param("ss", $name, $book_name);

        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            $delete_stmt = $conn->prepare("DELETE FROM user_order WHERE id = ?");
            $delete_stmt->bind_param("i", $id_order);
            $delete_stmt->execute();

            if ($delete_stmt->affected_rows > 0) {
                echo json_encode(array("message" => "Данные успешно добавлены и заявка удалена"));
            } else {
                echo json_encode(array("message" => "Данные успешно добавлены, но ошибка при удалении заявки"));
            }
        } else {
            echo json_encode(array("message" => "Ошибка добавления данных"));
        }


    } else {
        echo "Ошибка: Не все необходимые данные были отправлены";
    }
    
} else {
    echo "Ошибка: только метод POST";
}

?>