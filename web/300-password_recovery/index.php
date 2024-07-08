<?php
session_start();
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.html');
    exit;
}

// Database credentials
$servername = getenv("MYSQL_HOST");
$username = "root";
$password = "";
$dbname = "online_journal";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch entries
$sql = "SELECT entry_date, entry FROM entries WHERE user_id = 1 ORDER BY entry_date DESC";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ritchie's Diary</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: none; /* Hide the body initially */
        }
        .container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 90%;
            max-width: 600px;
            margin: 20px;
        }
        .entry {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .entry:last-child {
            border-bottom: none;
        }
        .date {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }
        .text {
            color: #333;
            line-height: 1.6;
        }
        .heading {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="heading">Ritchie's Diary</div>
        <?php
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<div class='entry'>";
                echo "<div class='date'>" . htmlspecialchars($row['entry_date']) . "</div>";
                echo "<div class='text'>" . htmlspecialchars($row['entry']) . "</div>";
                echo "</div>";
            }
        } else {
            echo "<div class='error'>No entries found.</div>";
        }
        $conn->close();
        ?>
    </div>
    <script src="script.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            document.body.style.display = "block";
        });
    </script>
</body>
</html>
