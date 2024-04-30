<?php
include 'core/func.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    
    
    $query = "SELECT * FROM `reviews` WHERE book_id = '$id'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        $data = array();

        while ($row = mysqli_fetch_assoc($result)) {
            $data[] = $row;
        }

        $json_output = json_encode($data);

        echo $json_output;
    }
} else {
    echo "Error: 'id' parameter is missing.";
}
?>