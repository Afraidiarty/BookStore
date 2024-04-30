<?php
include 'core/func.php';

$data = json_decode(file_get_contents("php://input"));

    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->reviewText, $data->id_user, $data->id_book,$data->rating)) {

        $query_user = "SELECT name FROM `User_Table` WHERE UserID = ?";
        $stmt_user = $conn->prepare($query_user);
        $stmt_user->bind_param('i', $data->id_user);
        $stmt_user->execute();
        $result_user = $stmt_user->get_result();
        
        if ($result_user->num_rows > 0) {
            $username_row = $result_user->fetch_assoc();
            $username = $username_row['name'];
        
            $query = "INSERT INTO `reviews` (`book_id`, `user_id`, `text`, `name` ,`rating`) VALUES (?, ?, ?, ?,?)";
            $stmt = $conn->prepare($query);
        
            if (!$stmt) {
                die("Error: " . $conn->error);
            }
        
            $stmt->bind_param('iissi', $data->id_book, $data->id_user, $data->reviewText, $username, $data->rating);
            $stmt->execute();
        
            if ($stmt->affected_rows > 0) {
                $review_id = $stmt->insert_id; 
                echo "Review successfully added!";
            } else {
                echo "Error: Failed to add review.";
            }
        } else {
            echo "Error: User not found.";
        }
        

        $stmt->close();



            $query = "INSERT INTO `rating` (`book_id`, `user_id`, `rating`, `review_id`) VALUES (?, ?, ?, ?)";
            $stmt = $conn->prepare($query);

            if (!$stmt) {
                die("Error: " . $conn->error);
            }

            $stmt->bind_param('iiii', $data->id_book, $data->id_user, $data->rating, $review_id);
            $stmt->execute();

            if ($stmt->affected_rows > 0) {
                echo "Rating successfully added!";
            } else {
                echo "Error: Failed to add rating.";
            }

            $stmt->close();

        $query_count = "SELECT COUNT(*) AS count FROM rating WHERE book_id = ?";
        $stmt_count = $conn->prepare($query_count);

        if (!$stmt_count) {
            die("Error preparing statement: " . $conn->error);
        }

        $stmt_count->bind_param('i', $data->id_book);
        $stmt_count->execute();
        $stmt_count->bind_result($count);
        $stmt_count->fetch();
        $stmt_count->close();

        $query = "SELECT SUM(rating) / ? AS average_rating FROM rating WHERE book_id = ?";
        $stmt = $conn->prepare($query);

        if (!$stmt) {
            die("Error preparing statement: " . $conn->error);
        }

        $stmt->bind_param('ii', $count, $data->id_book);
        $stmt->execute();
        $stmt->bind_result($average_rating);
        $stmt->fetch();
        $stmt->close();

        $query = "UPDATE commercial SET rating = ? WHERE book_id = ?";
        $stmt = $conn->prepare($query);

        if (!$stmt) {
            die("Error preparing statement: " . $conn->error);
        }

        $stmt->bind_param('di', $average_rating, $data->id_book);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo "Average rating successfully updated!";
        } else {
            echo "Error: Failed to update average rating.";
        }

        $stmt->close();

} else {
    echo "Рейтинг: NULL";
}
?>