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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
        $csvFile = 'journal_entries.csv';

        if (($file = fopen($csvFile, 'r')) !== FALSE) {
            // Read the CSV header
            fgetcsv($file);

            while (($entry = fgetcsv($file)) !== FALSE) {
                echo "<div class='entry'>";
                echo "<div class='date'>" . htmlspecialchars($entry[0]) . "</div>";
                echo "<div class='text'>" . htmlspecialchars($entry[1]) . "</div>";
                echo "</div>";
            }

            fclose($file);
        } else {
            echo "<div class='error'>Error opening the file.</div>";
        }
        ?>
    </div>
</body>
</html>
