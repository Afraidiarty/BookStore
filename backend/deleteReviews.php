<?php
include 'core/func.php';


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->reviewId)) {
        $reviewId = $data->reviewId;
        
        $query = "DELETE FROM `reviews` WHERE `id` = ?";
        
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $reviewId);
        $stmt->execute();
    }
}
?>