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


    public function getLogin($username,$password) {
        session_start();
        $response = array();
        
        
        if (strlen($username)<8 || strlen($username)>12 || !is_numeric($username)) {
          $emailErr = "Invalid mobile number format";
          $response = array(
                "code" => "500",
                "response" => $emailErr,
                "sessionId" => '',
                "isApproved" => '',
            );
            http_response_code(401);
            return $response;
          
        }
        if(strlen($password)<6 or strlen($password)>50){
            $response = array(
                "code" => "500",
                "response" => "Password Error",
                "sessionId" => '',
                "isApproved" => '',
            );
            http_response_code(401);
            return $response;
        }
        
        $sql = "SELECT * FROM login where username = '$username'";
        $result = mysqli_query($this->connect, $sql);
        $row = mysqli_fetch_array($result);
        
        if ($result->num_rows > 0) {
            if($row['password']==$password){
                $id = session_id();
                $response = array(
                    "code" => "200",
                    "response" => "Success",
                    "sessionId" => $id,
                    "isApproved" => $row['isApproved'],
                );
                $sql = "UPDATE login set sessionId='$id' where username='$username'";
                $result = mysqli_query($this->connect, $sql);
            }
            else{
                $response = array(
                    "code" => "400",
                    "response" => "Login Failed",
                    "sessionId" => '',
                    "isApproved" => '',
                );
                http_response_code(401);
            }
            
        }
        else{
            
            $sql = "INSERT into login (username,password) VALUES('$username','$password')";
            $result = mysqli_query($this->connect, $sql);
            
            if($result){
                $id = session_id();
                $response = array(
                    "code" => "201",
                    "response" => "Success Registered",
                    "sessionId" => $id,
                    "isApproved" => '',
                );
                $sql = "UPDATE login set sessionId='$id' where username='$username'";
                $result = mysqli_query($this->connect, $sql);
            }
            else{
                $response = array(
                    "code" => "401",
                    "response" => "Failed Register",
                    "sessionId" => '',
                    "isApproved" => '',
                );
                http_response_code(401);
            }
            
        }
        
       

        return $response;
    }
}

$validateLogin = new validateLogin();

$username = $_POST['mobileNumber'];
$password = $_POST['password'];

$resLogin = $validateLogin->getLogin($username,$password);

$jsonResponse = json_encode($resLogin);

header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Credentials: true");

echo $jsonResponse;

?>
