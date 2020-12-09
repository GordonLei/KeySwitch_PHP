<html>
    <head>
    <title> </title>
    </head>

    <body>
    <form action="updateform.php" method="post">
        Keyboard: 
        <select name="keyboard">
            <?php
                    session_start();
                    //this is the defualy postgresql username and password
                    $user = 'postgres';
                    $password = 'password';
                    $database = 'KeySwitch';

                    $PSQL_conn = pg_connect("host=localhost port=5432 dbname=$database user= $user password= $password");

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
                        echo '<option value="'.htmlspecialchars($row['keyboard_name']).'">';
                        echo htmlspecialchars($row['keyboard_name']).' '.htmlspecialchars($row['color']);
                        echo '</option>';
                    }
                   
            ?>
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
        <select name="switch">
            <?php
                    $result = pg_query($PSQL_conn, "SELECT * FROM KeyCap");

                    while ($row = pg_fetch_assoc($result)) {
                        echo '<option value="'.htmlspecialchars($row['set_name']).'">';
                        echo htmlspecialchars($row['set_name']);
                        echo '</option>';
                    }
                   
            ?>
        </select>
    </form>


    
    </body>
</html>

