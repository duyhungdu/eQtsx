<?php
    /* Database setup information */
    $dbhost = 'localhost';  // Database Host
    $dbuser = 'root';       // Database Username
    $dbpass = '';           // Database Password
    $dbname = 'itemsdb';      // Database Name

    /* Connect to the database and select database */
    $conn = mysql_connect($dbhost, $dbuser, $dbpass) or die(mysql_error());
    mysql_select_db($dbname);


    $return_arr = array();
    $param = $_GET["term"];

    $fetch = mysql_query("SELECT * FROM items WHERE itemCode REGEXP '^$param' LIMIT 5");

    /* Retrieve and store in array the results of the query.*/
    while ($row = mysql_fetch_array($fetch, MYSQL_ASSOC)) {

        $row_array['itemCode'] 		    = $row['itemCode'];
        $row_array['itemDesc'] 		    = $row['itemDesc'];
        $row_array['itemPrice']      	= $row['itemPrice'];

        array_push( $return_arr, $row_array );
    }

    /* Free connection resources. */
    mysql_close($conn);

    /* Toss back results as json encoded array. */
    echo json_encode($return_arr);

