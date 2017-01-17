<?php

class Connection{

    var $dbhost = null;
    var $dbusername = null;
    var $dbpassword = null;
    var $dbname = null;
    var $conn;
    var $result = null;

   function __construct($dbhost, $dbusername, $dbpassword, $dbname){
       $this->dbhost = $dbhost;
       $this->dbusername = $dbusername;
       $this->dbpassword = $dbpassword;
       $this->dbname = $dbname;
    }

    function openConnection(){
        $this->conn = new mysqli($this->dbhost, $this->dbusername, $this->dbpassword, $this->dbname);
        if(!$this->conn)
            throw new Exception('Could not connect to database!');
    }

    function closeConnection(){
        if($this->conn != null)
            $this->conn->close();
    }

    function getUserDetails($userMobileNumber , $password){
        $returnValue = array();
        $returnValue["status"] = "200";
        $query = "select * from employee WHERE Mobile = '".$userMobileNumber."' and password = '".$password."'";

        $result = $this->conn->query($query);

        if($result != null && (mysqli_num_rows($result) >= 1)){
            $row = $result->fetch_array(MYSQLI_ASSOC);
            if(!empty($row))
                $returnValue = $row;
        }
        return $returnValue;
    }

    function getProductDetailsByBarcode($barcodeid, $shopid){

        $products = array();
        $query = "select * from products WHERE Barcode = '".$barcodeid."' and Shop_ID = ".$shopid."";

        $result = $this->conn->query($query);

        if(mysqli_num_rows($result)){
            while($product = mysqli_fetch_assoc($result)){
                $products[] = array('product' => $product);
            }
        }

        return $products;
    }

    function getProductDetails($shopid){

        $products = array();
        $query = "select * from products WHERE Shop_ID = ".$this->conn->real_escape_string($shopid)."";

        $result = $this->conn->query($query);

        $products["status"] = "200";
        if(mysqli_num_rows($result)){
         while($product = mysqli_fetch_assoc($result)){
             $products[] = array('product'=>$product);
         }
            
        }

        return $products;
    }

    function getTraderDetails($uid){

        $traders = array();
        $query = "select * from trader,owntraders WHERE owntraders.EID = ".$this->conn->real_escape_string($uid)." and owntraders.TID = trader.TID";

        $result = $this->conn->query($query);

        $traders["status"] = "200";
            if(mysqli_num_rows($result)){
            while($trader = mysqli_fetch_assoc($result)){
                $traders[] = array('trader'=>$trader);
            }
        }

        return $traders;

    }

    function getMessageBarcode($barcodeid, $shopid){

        $msg = array();
        $query = "select * from products WHERE Barcode = '".$barcodeid."' and Shop_ID = ".$shopid."";

        $result = $this->conn->query($query);

        if(mysqli_num_rows($result)){
            $msg["msg"] = "Product has been saled";
        }

        return $msg;
    }

}