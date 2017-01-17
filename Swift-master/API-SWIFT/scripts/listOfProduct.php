<?php

require("../db/Connection.php");
include('../db/DBINFO.php');

$conn = new Connection($dbhost, $dbusername, $dbpassword, $dbname);
$conn->openConnection();

$shopid = isset($_REQUEST['shopid']) ? $_REQUEST['shopid'] :  "";

if(!empty($shopid)) {
    if (empty($conn->getProductDetails($shopid))) {
        $json = array("status" => 403, "message" => "No Product Founded");
        echo json_encode($json);
        return;
    } else {
        echo json_encode($conn->getProductDetails($shopid));
    }
}
else{
    $json = array("status" => 403, "message" => "shop ID not define");
    echo json_encode($json);
}
$conn->closeConnection();