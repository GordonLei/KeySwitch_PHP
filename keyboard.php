<html>
    <head>
    <title> </title>
    <link rel="stylesheet" href="stylesheet.css">
    </head>

    <body>
    <a href = "index.php">Home page</a> <br>
    <a href = "keyboard.php">Keyboards</a> <br>
    <a href = "switch.php">Switches</a> <br>
    <a href = "keycap.php">Keycap Sets</a> <br>

<?php
        session_start();
        //this is the defualy postgresql username and password
        $user = 'postgres';
        $password = 'password';
        $database = 'KeySwitch';

        $PSQL_conn = pg_connect("host=localhost port=5432 dbname=$database user= $user password= $password");
        //$_SESSION['connection'] = $PSQL_conn;

        $result = pg_query($PSQL_conn, "SELECT * FROM Keyboard;");
        if($result){
            echo '<table>
            <tr> 
            <th>keyboard_name</th>
            <th>color</th>
            <th>keyboard_type</th>
            <th>mounting</th>
            </tr>';
            //echo '<tr>';
            while ($row = pg_fetch_assoc($result)) {
                echo '<tr>
                <td>'.htmlspecialchars($row['keyboard_name']).'</td>'.
                '<td>'.htmlspecialchars($row['color']).'</td>'.
                '<td>'.htmlspecialchars($row['keyboard_type']).'</td>'.
                '<td>'.htmlspecialchars($row['mounting']).'</td>'.
                '</tr>';
            } 
            echo '</table>';
        }   
?>

</body>
</html>