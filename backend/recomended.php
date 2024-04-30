<?php
include 'core/func.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['name'])) {
        $name = $_POST['name'];

        // Получаем список купленных книг пользователя
        $query = "SELECT DISTINCT book_name FROM history_buy WHERE name = '$name'";
        $result = mysqli_query($conn, $query); 
        if (!$result) {
            die('Ошибка выполнения запроса: ' . mysqli_error($conn));
        }

        $data = array();
        $genre = array();

        while ($row = mysqli_fetch_assoc($result)) {
            $book_name = $row['book_name'];

            $query_book = "SELECT * FROM books WHERE title = '$book_name'";
            $result_book = mysqli_query($conn, $query_book); 
            if (!$result_book) {
                die('Ошибка выполнения запроса: ' . mysqli_error($conn));
            }

            // Получаем жанр книги
            $book_genre = "";
            while ($book_row = mysqli_fetch_assoc($result_book)) {
                $book_genre = $book_row['genre'];
                $data[] = $book_row;
            }

            if (!empty($book_genre)) {
                $query_genre = "SELECT * FROM books WHERE genre = '$book_genre'";
                $result_genre = mysqli_query($conn, $query_genre);
                if (!$result_genre) {
                    die('Ошибка выполнения запроса: ' . mysqli_error($conn));
                }

                while ($genre_row = mysqli_fetch_assoc($result_genre)) {
                    $genre[] = $genre_row;
                }

                mysqli_free_result($result_genre);
            }

            mysqli_free_result($result_book);
        }

        mysqli_free_result($result);
        mysqli_close($conn);

        header('Content-Type: application/json');

        echo json_encode(array_intersect_key($genre));
    }
}
?>