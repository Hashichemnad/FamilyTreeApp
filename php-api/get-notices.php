<?php

require 'db.php';


class Notices {
    public $familyMembers = array();
    public $connect;

    public function __construct() {
        $this->connect = mysqli_connect("localhost", "username", "password", "database");
        if (!$this->connect) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }


    public function getNotices($sessionId) {
        
        $sql = "SELECT * FROM login where sessionId='$sessionId' and isApproved='1'";
        $result = mysqli_query($this->connect, $sql);
        if(mysqli_num_rows($result)<1){
            http_response_code(401);
            return NULL;
        }
        
        $response = array();
        
        $sql = "SELECT * FROM notice order by nid desc";
        $result = mysqli_query($this->connect, $sql);
        
        while($row = mysqli_fetch_array($result)) {
        
            $response = array(
                "id" => $row["nid"],
                "title" => $row["title"],
                "date" => $row["date"],
                "details" => $row["details"]
            );
            
         $this->familyMembers[] = $response;   
        }
        
 
        return $this->familyMembers;
    }
}

$noticesObj = new Notices();

$sessionId=$_POST['sessionId'];
$notices = $noticesObj->getNotices($sessionId);

$jsonResponse = json_encode($notices);

header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Credentials: true");

echo $jsonResponse;

?>
