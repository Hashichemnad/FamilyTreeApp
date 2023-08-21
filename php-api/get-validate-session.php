<?php


class validateLogin {
    
    public $response = array();
    public $connect;
    
    public function __construct() {
        $this->connect = mysqli_connect("localhost", "username", "password", "database");
        if (!$this->connect) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }


    public function getLogin($sessionId) {
        session_start();
        $response = array();
        
        $sql = "SELECT * FROM login where sessionId = '$sessionId'";
        $result = mysqli_query($this->connect, $sql);
        $row = mysqli_fetch_array($result);
        
        if ($result->num_rows > 0) {
            if($row['isApproved']=='1'){
                $response = array(
                    "code" => "200",
                    "response" => "Success",
                    "sessionId" => $row['sessionId'],
                    "isApproved" => '1',
                );
            }
            else{
                $response = array(
                    "code" => "200",
                    "response" => "Success",
                    "sessionId" => $row['sessionId'],
                    "isApproved" => '',
                );
            }
            
        }
        else{
            
            $response = array(
                "code" => "400",
                "response" => "No Record",
                "sessionId" => '',
                "isApproved" => '',
            );
            
            
        }

        return $response;
    }
}

$validateLogin = new validateLogin();

$session = $_POST['sessionId'];

$resLogin = $validateLogin->getLogin($session);

$jsonResponse = json_encode($resLogin);

header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Credentials: true");

echo $jsonResponse;

?>
