<?php

$config = parse_ini_file('../DBINFO.ini');

$dbhost = trim($config["dbhost"]);
$dbusername = trim($config["dbusername"]);
$dbpassword = trim($config["dbpassword"]);
$dbname = trim($config["dbname"]);