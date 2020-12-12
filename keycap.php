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

        $result = pg_query($PSQL_conn, "SELECT * FROM KeyCap;");
        if($result){
            echo '<table>
            <tr> 
            <th>Set Name</th>
            <th>Cap Manufacturer</th>
            <th>Cap Profile</th>
            <th>Material</th>
            </tr>';
            //echo '<tr>';
            while ($row = pg_fetch_assoc($result)) {
                echo '<tr>
                <td>'.htmlspecialchars($row['set_name']).'</td>'.
                '<td>'.htmlspecialchars($row['cap_manufacturer']).'</td>'.
                '<td>'.htmlspecialchars($row['cap_profile']).'</td>'.
                '<td>'.htmlspecialchars($row['material']).'</td>'.
                '</tr>';
            } 
            echo '</table>';
        }   
?>

</body>
</html>