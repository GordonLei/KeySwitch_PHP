<?php 
    session_start();
    $switch = htmlspecialchars($_POST['switch']);
    $keyboard = htmlspecialchars($_POST['keyboard']);
    $lube = htmlspecialchars($_POST['lube']);
    $stabilizer = htmlspecialchars($_POST['stabilizer']);
    $layout= htmlspecialchars($_POST['layout']);
    $plate = htmlspecialchars($_POST['plate']);
    $keycap = htmlspecialchars($_POST['keycap']);
    $description = htmlspecialchars($_POST['description']);

    //get stuff from the session
    //donm't know why this doesn't work
    //$PSQL_conn =$_SESSION['connection'];
    $user = 'postgres';
    $password = 'password';
    $database = 'KeySwitch';

    $PSQL_conn = pg_connect("host=localhost port=5432 dbname=$database user= $user password= $password");

    //get the keyboard_name and keyboard color:
    $wrd_array = preg_split("/[\s,]+/", $keyboard);
    //echo $keyboard.'<br>';
    print_r($wrd_array);
    for ($i=0, $len=count($wrd_array); $i<$len; $i++) {
        $keyboard_name = '';
        $keyboard_color = '';
        for ($i2=0, $counter = $i + 1; $i2<$counter; $i2++) {
            $keyboard_name = $keyboard_name.$wrd_array[$i2];
            if($i2 + 1 < $counter){
                $keyboard_name = $keyboard_name.' ';
            }
        }
        for ($i3 = $i + 1; $i3<$len; $i3++){
            $keyboard_color= $keyboard_color.$wrd_array[$i3];
            if($i3 + 1 < $len){
                $keyboard_color = $keyboard_color.' ';
            }
        }
        //do this to wipe any saved prepared statement
        pg_query($PSQL_conn, "DEALLOCATE ALL");
        $query = pg_prepare($PSQL_conn, "query_0", "SELECT * FROM Keyboard WHERE keyboard_name = $1 AND color = $2;");
        $query = pg_execute($PSQL_conn, "query_0", array($keyboard_name,$keyboard_color));
        $res = pg_fetch_all($query);
        

        echo 'keyboard name: '.$keyboard_name.'<br>';
        echo 'keyboard color: '.$keyboard_color.'<br>';

        //echo $res;
        //echo 'END RES<br>';
        if($res){
            //echo 'true';
            break;
        }

    }

    //get the list_id to make the build
    $query = pg_prepare($PSQL_conn, "query_1", "INSERT INTO List (description) VALUES ($1) RETURNING list_id;");
    $query = pg_execute($PSQL_conn, "query_1", array($description));
    //echo $query;
    $list_id = pg_fetch_result($query,0,0);
    echo $keyboard_name;
    echo $keyboard_color;
    //echo $list_id;
    //create the build 
    $query2 = pg_prepare($PSQL_conn, "query_2", "INSERT INTO Build (list_id, keyboard_name, color, switch_name, set_name, plate, layout, stabilizer, lube) VALUES ($1, $2,$3,$4,$5,$6,$7,$8,$9);");
    $query2 = pg_execute($PSQL_conn, "query_2", array($list_id, $keyboard_name, $keyboard_color, $switch, $keycap, $plate, $layout, $stabilizer, $lube));
    //$val = pg_fetch_result($result, 1,0);


    //return to index.php
    header("Location: index.php"); 
?>