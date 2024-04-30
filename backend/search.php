<?php
include 'core/func.php';

$data = json_decode(file_get_contents("php://input"));

if(isset($data->query)) {
    $searchQuery = $data->query;

    $query = "SELECT * FROM `Books` WHERE `title` LIKE '%$searchQuery%' LIMIT 5";
    $result = mysqli_query($conn, $query);

    if (!$result) {
        // Query failed, output error message
        echo json_encode("Query failed: " . mysqli_error($conn));
    } else {
        $books = array();

        while($row = mysqli_fetch_assoc($result)){
            $books[] = $row;
        }

        echo json_encode($books);
    }
} else {
    echo json_encode("Query parameter is missing");
}
?>