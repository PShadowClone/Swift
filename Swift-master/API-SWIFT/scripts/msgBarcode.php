<?php

require('../db/Connection.php');
include('../db/DBINFO.php');

if(empty($_REQUEST['barcodeid']) || empty($_REQUEST['shopid'])){
    $json = array("status" => 302, "message" => "missing required information");
    echo json_encode($json);
    return;
}

$barcodeid = htmlentities($_REQUEST['barcodeid']);
$shopid = htmlentities($_REQUEST['shopid']);

$conn = new Connection($dbhost, $dbusername, $dbpassword, $dbname);
$conn->openConnection();

$msgProduct = $conn->getMessageBarcode($barcodeid, $shopid);

if(empty($msgProduct)){
    $json = array("status" => 302, "message" => "No Product Founded");
    echo json_encode($json);
    return;
}

else{
    echo json_encode($msgProduct);
}

$conn->closeConnection();