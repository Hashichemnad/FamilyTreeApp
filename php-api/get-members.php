<?php

require 'db.php';


class FamilyMember {
    public $familyMembers = array();
    public $connect;

    public function __construct() {
        $this->connect = mysqli_connect("localhost", "username", "password", "database");
        if (!$this->connect) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }

    public function checkchild($mid, $fathername) {
        $query1 = "SELECT * FROM members where ansc = $mid ORDER BY dob ASC, mid ASC";
        $result1 = mysqli_query($this->connect, $query1);
        $rownum1 = mysqli_num_rows($result1);

        while ($row1 = mysqli_fetch_array($result1)) {
            if ($row1['gender'] == 'M') {
                $father = 'S/O ' . $fathername;
            } else {
                $father = 'D/O ' . $fathername;
            }

            if (file_exists('path  to image/' . $row1['mid'] . '.jpg')) {
                $image = "path to image/" . $row1['mid'] . ".jpg?" . filemtime('path to image' . $row1['mid'] . '.jpg');
            } else {
                $image = "path to image/head.png";
            }

            if($row1['late']==0){
                $familyMember = array(
                    "id" => $row1["mid"],
                    "name" => $row1["name"],
                    "fatherName" => $father,
                    "profileImageUrl" => $image,
                    "contact"=>$row1['contact'],
                    "familyId"=>$row1['uid'],
                );
                $this->familyMembers[] = $familyMember;
            }

            $queryc = "SELECT * FROM couple where mid=" . $row1['mid'] . " limit 1";
            $resultc = mysqli_query($this->connect, $queryc);
            $rownumc = mysqli_num_rows($resultc);

            if ($rownumc != 0) {
                $rowc = mysqli_fetch_array($resultc);

                if ($row1['gender'] == 'M') {
                    $father = 'W/O ' . $row1["name"];
                } else {
                    $father = 'H/O ' . $row1["name"];
                }

                if (file_exists('path to image/' . $rowc['cid'] . '.jpg')) {
                    $image = "path to image/" . $rowc['cid'] . ".jpg?" . filemtime('path to image/' . $rowc['cid'] . '.jpg');
                } else {
                    $image = "path to image/head.png";
                }

                if($rowc['late']==0){
                    $familyMember = array(
                        "id" => $rowc["cid"],
                        "name" => $rowc["name"],
                        "fatherName" => $father,
                        "profileImageUrl" => $image,
                        "contact"=>$rowc['contact'],
                        "familyId"=>$rowc['uid'],
                    );
                    $this->familyMembers[] = $familyMember;
                }
                
            }

            $this->checkchild($row1['mid'], $row1["name"]);
        }
    }

    public function getFamilyMembers($sessionId) {
        
        $sql = "SELECT * FROM login where sessionId='$sessionId' and isApproved='1'";
        $result = mysqli_query($this->connect, $sql);
        if(mysqli_num_rows($result)<1){
            http_response_code(401);
            return NULL;
        }
        
        
        $sql = "SELECT * FROM members where ansc = 1 order by dob asc, mid asc";
        $result = mysqli_query($this->connect, $sql);

        while ($row = mysqli_fetch_array($result)) {
            if ($row['gender'] == 'M') {
                $father = 'S/O Head';
            } else {
                $father = 'D/O Head wife';
            }

            if (file_exists('path to image/' . $row['mid'] . '.jpg')) {
                $image = "path to image/" . $row['mid'] . ".jpg?" . filemtime('path to image/' . $row['mid'] . '.jpg');
            } else {
                $image = "path to image/head.png";
            }

            if($row['late']==0){
                $familyMember = array(
                    "id" => $row["mid"],
                    "name" => $row["name"],
                    "fatherName" => $father,
                    "profileImageUrl" => $image,
                    "contact"=>$row['contact'],
                    "familyId"=>$row['uid'],
                );
                $this->familyMembers[] = $familyMember;
            }

            $queryc = "SELECT * FROM couple where mid=" . $row['mid'] . " limit 1";
            $resultc = mysqli_query($this->connect, $queryc);
            $rownumc = mysqli_num_rows($resultc);

            if ($rownumc != 0) {
                $rowc = mysqli_fetch_array($resultc);

                if ($row['gender'] == 'M') {
                    $father = 'W/O ' . $row['name'];
                } else {
                    $father = 'H/O ' . $row['name'];
                }

                if (file_exists('path to image/' . $rowc['cid'] . '.jpg')) {
                    $image = "path to image/" . $rowc['cid'] . ".jpg?" . filemtime('path to image/' . $rowc['cid'] . '.jpg');
                } else {
                    $image = "path to image/head.png";
                }

                if($rowc['late']==0){
                    $familyMember = array(
                        "id" => $rowc["cid"],
                        "name" => $rowc["name"],
                        "fatherName" => $father,
                        "profileImageUrl" => $image,
                        "contact"=>$rowc['contact'],
                        "familyId"=>$rowc['uid'],
                    );
                    $this->familyMembers[] = $familyMember;
                }
            }

            $this->checkchild($row['mid'], $row["name"]);
        }

        return $this->familyMembers;
    }
}

$familyMemberObj = new FamilyMember();

$sessionId=$_POST['sessionId'];

$familyMembers = $familyMemberObj->getFamilyMembers($sessionId);

$jsonResponse = json_encode($familyMembers);

header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Credentials: true");

echo $jsonResponse;

?>
