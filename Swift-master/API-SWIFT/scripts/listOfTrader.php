<?php

require("../db/Connection.php");
include('../db/DBINFO.php');

$conn = new Connection($dbhost, $dbusername, $dbpassword, $dbname);
$conn->openConnection();

$uid = isset($_REQUEST['uid']) ? $_REQUEST['uid'] : "" ;

if(!empty($uid)) {
    if (empty($conn->getTraderDetails($uid))) {
        $json = array("status" => "302", "message" => "No Trader Founded");
        echo json_encode($json);
        return;
    } else {
        echo json_encode($conn->getTraderDetails($uid));
    }
}
else{
    $json = array("status" => "302", "message" => "user ID not found");
    echo json_encode($json);
}
$conn->closeConnection();