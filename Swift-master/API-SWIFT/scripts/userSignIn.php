<?php

require("../db/Connection.php");
include('../db/DBINFO.php');

$returnValue = array();

if(empty($_REQUEST["userMobileNumber"]) || empty($_REQUEST["userPassword"])){
    $returnValue["status"] = "400";
    $returnValue["message"] = "missing required information";
    echo json_encode($returnValue);
    return;
}

$userMobileNumber = htmlentities($_REQUEST["userMobileNumber"]);
$userPassword = htmlentities($_REQUEST["userPassword"]);

$conn = new Connection($dbhost, $dbusername, $dbpassword, $dbname);
$conn->openConnection();

$userDetails = $conn->getUserDetails($userMobileNumber,$userPassword);

if(empty($userDetails)){
    $returnValue["status"] = "403";
    $returnValue["message"] = "User not found";
    echo json_encode($returnValue);
    return;
}
else{
    
    $userDetails["status"] = "200";
    echo json_encode($userDetails);
}

$conn->closeConnection();