<?
include 'core/func.php';


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->bookID)) {
        $bookID = $data->bookID;
        
        $query = "DELETE FROM `Books` WHERE `id` = ?";
        
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $bookID);
        $stmt->execute();
    }
}
?>