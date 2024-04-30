<?php
include 'core/func.php';

$request_body = file_get_contents('php://input');
$data = json_decode($request_body, true);

if ($data) {
    $id_book = $data['id_book'];
    $title = isset($data['title']) ? $data['title'] : '';
    $author = isset($data['author']) ? $data['author'] : '';
    $izdatel = isset($data['izdatel']) ? $data['izdatel'] : '';
    $genre = isset($data['genre']) ? $data['genre'] : '';
    $desc = isset($data['desc']) ? $data['desc'] : '';
    $PageCount = isset($data['PageCount']) ? $data['PageCount'] : '';
    $price = isset($data['price']) ? $data['price'] : '';
    

    if ($title || $author || $izdatel || $genre || $desc || $PageCount || $price) {
        $sql = "UPDATE Books SET ";
        $updates = [];
        if ($title) $updates[] = "title='$title'";
        if ($author) $updates[] = "author='$author'";
        if ($izdatel) $updates[] = "izdatel='$izdatel'";
        if ($genre) $updates[] = "genre='$genre'";
        if ($desc) $updates[] = "description='$desc'";
        if ($PageCount) $updates[] = "pageCount=$PageCount";
        if ($price) $updates[] = "price=$price";
        
        $sql .= implode(", ", $updates);
        $sql .= " WHERE id=$id_book";

        if ($conn->query($sql) === TRUE) {
            $response = array(
                'success' => true,
                'message' => 'Книга успешно обновлена!'
            );
        } else {
            $response = array(
                'success' => false,
                'message' => 'Ошибка при обновлении книги: ' . $conn->error
            );
        }
    } else {
        $response = array(
            'success' => false,
            'message' => 'Нет данных для обновления!'
        );
    }
} else {
    $response = array(
        'success' => false,
        'message' => 'Ошибка: Данные не были переданы!'
    );
}

echo json_encode($response);

$conn->close();
?>