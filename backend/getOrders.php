<?php
include 'core/func.php';

$sql = "SELECT user_order.*, Books.title 
        FROM user_order 
        LEFT JOIN Books ON user_order.book_id = Books.id";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $orders = array();

    while($row = $result->fetch_assoc()) {
        $orders[] = $row;
    }

    header('Content-Type: application/json');
    echo json_encode($orders);
} else {
    echo json_encode(array('NotExit' => 'Заявок нету'));
}
?>