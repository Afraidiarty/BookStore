<?
include 'core/func.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['name'])) {
        $name = $_POST['name'];
        $query = "SELECT * FROM `history_buy` where `name` = '$name'";
        $result = mysqli_query($conn,$query);

        $history = array();

        while($row = mysqli_fetch_assoc($result)){
            $history[] = $row;
        }

        echo json_encode($history);
    }
}

?>