<?php
include 'core/func.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->editedText) && isset($data->reviewId)) {
        $editedText = $data->editedText;
        $reviewId = $data->reviewId;
        
        $query = "UPDATE `reviews` SET `text` = ? WHERE `id` = ?";
        
        $stmt = $conn->prepare($query);
        $stmt->bind_param("si", $editedText, $reviewId);
        $stmt->execute();
    }
}
?>