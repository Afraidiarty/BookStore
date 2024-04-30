<?php
include 'core/func.php';

$query = "SELECT DISTINCT Books.id, Books.title, Books.author, Books.izdatel, Books.genre, Books.description, Books.pageCount, Books.price, Books.coverImage, commercial.rating
          FROM Books
          INNER JOIN commercial ON Books.id = commercial.book_id
          ORDER BY commercial.rating DESC
          LIMIT 5";

$result = mysqli_query($conn, $query);

if (mysqli_num_rows($result) > 0) {
    $books = array(); 
    while ($row = mysqli_fetch_assoc($result)) {
        $books[] = $row; 
    }
    echo json_encode($books);
} else {
    echo json_encode(array("message" => "Результатов не найдено")); 
}

mysqli_close($conn);
?>