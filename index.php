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
    


    <form action="add_data.php" method="post">
        Keyboard: 
        <select name="keyboard">
            <?php
                    session_start();
                    //this is the defualy postgresql username and password
                    $user = 'postgres';
                    $password = 'password';
                    $database = 'KeySwitch';

                    $PSQL_conn = pg_connect("host=localhost port=5432 dbname=$database user= $user password= $password");
                    //$_SESSION['connection'] = $PSQL_conn;

                    if($PSQL_conn === false){
                        die("Could not connect to the database<br>");
                    }
                    //echo "Hello World <br>";
                    /*
                    $stmt = $PSQL_conn->prepare("SELECT * FROM Keyboard;");
                    $stmt -> execute();
                    $res = $stmt -> get_result();
                    echo($prepared_query);
                    */

                    /*
                    $result = pg_prepare($PSQL_conn, "query_1", "SELECT $1 FROM Keyboard");
                    $result = pg_execute($PSQL_conn, "query_1", array("*"));
                    $val = pg_fetch_result($result, 1,0);
                    */
                    $result = pg_query($PSQL_conn, "SELECT * FROM Keyboard");
                    //$val = pg_fetch_all($result);
                    //print_r($val);

                    while ($row = pg_fetch_assoc($result)) {
                        echo '<option value="'.htmlspecialchars($row['keyboard_name']).' '.htmlspecialchars($row['color']).'">';
                        echo htmlspecialchars($row['keyboard_name']).' '.htmlspecialchars($row['color']);
                        echo '</option>';
                    }
                   
            ?>
        </select>
        <br>
        
        Layout
        <select name="layout">
            <option value="ansi"> ansi </option>
            <option value="iso"> iso </option>

        </select>

        <br>
        Plate
        <select name="plate">
            <option value="Aluminum"> Aluminum </option>
            <option value="Brass"> Brass</option>
            <option value="Carbon Fibre"> Carbon Fibre </option>
            <option value="FR4"> FR4 </option>
            <option value="Polycarbonate"> Polycarbonate </option>
        </select>

        <br>

        Stabilizer
        <select name="stabilizer">
            <option value="c3 stabilizer"> c3 stabilizer</option>
            <option value="cherry plate mount"> cherry plate mount</option>
            <option value="cherry screw in"> cherry screw in</option>
            <option value="zeal stabilizer"> zeal stabilizer </option>
            <option value="durock stabilizer"> durock stabilizer </option>
        </select>

        <br>

        Lube
        <select name="lube">
            <option value="Krytox GPL 205 GRADE 0"> Krytox GPL 205 GRADE 0 </option>
            <option value="Tribosys 3203"> Tribosys 3203 </option>
            <option value="Tribosys 3204"> Tribosys 3204 </option>
        </select>


        <br>
        Switch: 
        <select name="switch">
            <?php
                    $result = pg_query($PSQL_conn, "SELECT * FROM Switch");

                    while ($row = pg_fetch_assoc($result)) {
                        echo '<option value="'.htmlspecialchars($row['switch_name']).'">';
                        echo htmlspecialchars($row['switch_name']);
                        echo '</option>';
                    }
                   
            ?>
        </select>
        <br>
        KeyCap: 
        <select name="keycap">
            <?php
                $result = pg_query($PSQL_conn, "SELECT * FROM KeyCap");
                while ($row = pg_fetch_assoc($result)) {
                    echo '<option value="'.htmlspecialchars($row['set_name']).'">';
                    echo htmlspecialchars($row['set_name']);
                    echo '</option>';
                }   
            ?>
        </select>
        <br>
        <label for="description">Description:</label><br>
        <input type="text" id="description" name="description"><br>
        <input type="submit" value="Submit">
    </form>

    <?php
    //display the list 
        $result = pg_query($PSQL_conn, "SELECT * FROM list INNER JOIN build ON (list.list_id = build.list_id);");
        if($result){
            echo '<table>
            <tr> 
            <th>List ID</th>
            <th>Build ID</th>
            <th>Keyboard Name</th>
            <th>Color</th>
            <th>Layout</th>
            <th>Plate</th>
            <th>Stabilizer</th>
            <th>Lube</th>
            <th>Switch</th>
            <th>KeyCap</th>
            <th>Description</th> 
            </tr>';
            //echo '<tr>';
            while ($row = pg_fetch_assoc($result)) {
                echo '<tr>
                <td>'.htmlspecialchars($row['list_id']).'</td>'.
                '<td>'.htmlspecialchars($row['build_id']).'</td>'.
                '<td>'.htmlspecialchars($row['keyboard_name']).'</td>'.
                '<td>'.htmlspecialchars($row['color']).'</td>'.
                '<td>'.htmlspecialchars($row['layout']).'</td>'.
                '<td>'.htmlspecialchars($row['plate']).'</td>'.
                '<td>'.htmlspecialchars($row['stabilizer']).'</td>'.
                '<td>'.htmlspecialchars($row['lube']).'</td>'.
                '<td>'.htmlspecialchars($row['switch_name']).'</td>'.
                '<td>'.htmlspecialchars($row['set_name']).'</td>'.
                '<td>'.htmlspecialchars($row['description']).'</td>'.
                '</tr>';
            } 
            echo '</table>';
        }   
    ?>
    
    </body>
</html>

