<?php
include 'core/func.php';

$query = "SELECT * FROM `history_buy`";
$result = mysqli_query($conn, $query);

$history = [];

while ($row = mysqli_fetch_assoc($result)) {
    $history[] = $row;
}

echo json_encode($history);
?>