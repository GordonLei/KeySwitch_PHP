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

        $result = pg_query($PSQL_conn, "SELECT * FROM Switch;");
        if($result){
            echo '<table>
            <tr> 
            <th>switch_name</th>
            <th>switch_type</th>
            <th> actuation_distance (mm)</th>
            <th>bottom_out_distance (mm)</th>
            <th>operating_force (g)</th>
            <th>bottom_out_force (g)</th>
            <th>manufacturer</th>
            <th>pins</th>
            </tr>';
            //echo '<tr>';
            while ($row = pg_fetch_assoc($result)) {
                echo '<tr>
                <td>'.htmlspecialchars($row['switch_name']).'</td>'.
                '<td>'.htmlspecialchars($row['switch_type']).'</td>'.
                '<td>'.htmlspecialchars($row['actuation_distance']).'</td>'.
                '<td>'.htmlspecialchars($row['bottom_out_distance']).'</td>'.
                '<td>'.htmlspecialchars($row['operating_force']).'</td>'.
                '<td>'.htmlspecialchars($row['bottom_out_force']).'</td>'.
                '<td>'.htmlspecialchars($row['manufacturer']).'</td>'.
                '<td>'.htmlspecialchars($row['pins']).'</td>'.
                '</tr>';
            } 
            echo '</table>';
        }   
?>

</body>
</html>