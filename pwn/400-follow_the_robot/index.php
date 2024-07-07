<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap Image Grid</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .img-container {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>

<div class="container mt-4">

   
    <h1 class="text-center text-danger">Long live the bots!!!!!</h1>
    <p class="text-center text-dark font-weight-bold">
        Beep Beep Boop Beep Beep Boop, hello there robot....Wait a min, are you a robot? Prove it.....<br/>
        If you are a robot..... You will know where to look..... Beep Beep Beep booooooooooottttttttt
    </p>
   
    
    <div class="row">
        <?php
            $dir = new DirectoryIterator(dirname(__FILE__).'/robots/');
            foreach ($dir as $fileinfo) {
                if (!$fileinfo->isDot()) {

                    $image = 'robots/'.$fileinfo->getFilename();
                    $alt = $fileinfo->getFilename();

                    $html = <<<EOD
                        <div class="col-6 col-md-3 mb-4 img-container">
                                <img src="$image" alt="$alt">
                        </div>
                    EOD;
                    echo $html;
                }
            }
        ?>
    </div>

    <h1>Are you looking for a flag??????? </h1>
    <p><a href="https://youtu.be/u8fQqp4vRQs?t=16">Here You go</p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>