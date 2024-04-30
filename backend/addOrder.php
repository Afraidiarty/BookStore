<?
include 'core/func.php';

$fio = $_POST['FIO'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$book_id = $_POST['book_id'];
$myName = $_POST['MyName'];

$sql = "INSERT INTO user_order (FIO, email, phone, book_id, name) VALUES ('$fio', '$email', '$phone', '$book_id', '$myName')";

if ($conn->query($sql) === TRUE) {
  echo "Данные успешно добавлены";
} else {
  echo "Ошибка: " . $sql . "<br>" . $conn->error;
}

?>