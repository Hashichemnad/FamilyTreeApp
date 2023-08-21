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
    
    function count_descendents($p_kids, $member) {
        if( !isset($p_kids[$member]) )
          return 0;
    
        if( $p_kids[$member] == [] )
          return 0;
    
        $desc = 0;
        foreach( $p_kids[$member] as $child ) {
          $rows = mysqli_fetch_array(mysqli_query($this->connect, "SELECT * FROM members where mid=".$child.""));
          $desc = $desc + 1 + $rows['married'] + $this->count_descendents($p_kids, $child);
        }
        return $desc;
    }
    
    function build_tree($rows1) {
      /* mid => [children... ] */
      $PARENT_KIDS = [];
    
      foreach($rows1 as $r) {
        $self = $r['mid'];
        $parent = $r['ansc'];
    
        if(! isset($PARENT_KIDS[$parent]) )
          $PARENT_KIDS[$parent] = [];
    
        $PARENT_KIDS[$parent][] = $self;
      }
    
      return $PARENT_KIDS;
    }
    

    public function getFamilyMemberDetails($familyMemberId,$sessionId) {
        
        //ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL);
        
        $querys = "SELECT * FROM members";  
        $results = mysqli_query($this->connect, $querys);  
        $rowss = [];
        while($rows = mysqli_fetch_array($results))  {
        	$rowss[] = $rows;
        }
        $FTREE = $this->build_tree($rowss);
        
        $sql = "SELECT * FROM login where sessionId='$sessionId' and isApproved='1'";
        $result = mysqli_query($this->connect, $sql);
        if(mysqli_num_rows($result)<1){
            http_response_code(401);
            return NULL;
        }
        
        $familyMemberId = intval($familyMemberId);
        
        $response = array();
        
        $sql = "SELECT * FROM members where mid = $familyMemberId";
        $result = mysqli_query($this->connect, $sql);
        
        if ($result->num_rows > 0) {
            $row = mysqli_fetch_array($result);
            $allcnt = $this->count_descendents($FTREE, $familyMemberId);
            
            if (file_exists('path to image/' . $row['mid'] . '.jpg')) {
                $image = "path to image/" . $row['mid'] . ".jpg?" . filemtime('path to image/' . $row['mid'] . '.jpg');
            } else {
                $image = "path to image/head.png";
            }
            if($row['dob']!=null){
                $bday = new DateTime($row['dob']);
                $today = new Datetime(date('m.d.y'));
                $age=strval($today->diff($bday)->y);
            }
            else{
                $age='-';
            }
            if($row['late']==1){
                $uid = 'LATE';
            }
            else{
                $uid=$row['uid'];
            }
            if($row['blood']==null){
                $blood = '-';
            }
            else{
                $blood=$row['blood'];
            }
            
            $response = array(
                "id" => $row["mid"],
                "name" => $row["name"],
                "contact" => $row["contact"],
                "education" => $row["study"],
                "whatsapp" => "-",
                "age" => $age,
                "familyId"=>$uid,
                "blood"=>$blood,
                "profileImageUrl" => $image,
                "count"=>strval($allcnt)
            );
            
            if ($row['married'] == 1) {
                $sql2 = "SELECT * FROM couple WHERE mid = $familyMemberId";
                $result2 = mysqli_query($this->connect, $sql2);

                if ($result2->num_rows > 0) {
                    $row2 = mysqli_fetch_array($result2);
                    if (file_exists('path to image/' . $row2['cid'] . '.jpg')) {
                        $image = "path to image/" . $row2['cid'] . ".jpg?" . filemtime('path to image/' . $row2['cid'] . '.jpg');
                    } else {
                        $image = "path to image/head.png";
                    }
                    if($row2['dob']!=null){
                        $bday = new DateTime($row2['dob']);
                        $today = new Datetime(date('m.d.y'));
                        $age=strval($today->diff($bday)->y);
                    }
                    else{
                        $age='-';
                    }
                    if($row2['late']==1){
                        $uid = 'LATE';
                    }
                    else{
                        $uid=$row2['uid'];
                    }
                    if($row2['blood']==null){
                        $blood = '-';
                    }
                    else{
                        $blood=$row2['blood'];
                    }
            
                    $spouse = array(
                        "id" => $row2["cid"],
                        "name" => $row2["name"],
                        "contact" => $row2["contact"],
                        "education" => $row2["study"],
                        "whatsapp" => "-",
                        "age" => $age,
                        "familyId"=>$uid,
                        "blood"=>$blood,
                        "profileImageUrl" => $image,
                        "count"=>strval($allcnt)
                    );
                    $response['spouse']=$spouse;
                }
                else{
                    $spouse=null;
                }
                
                $childrenData=null;
                $sql3 = "SELECT * FROM members where ansc = $familyMemberId";
                $result3 = mysqli_query($this->connect, $sql3);
                
                while ($row3 = mysqli_fetch_array($result3)) {
                    $allcnt = $this->count_descendents($FTREE, $row3['mid']);
                    
                    if (file_exists('path to image/' . $row3['mid'] . '.jpg')) {
                        $image = "path to image/" . $row3['mid'] . ".jpg?" . filemtime('path to image/' . $row3['mid'] . '.jpg');
                    } else {
                        $image = "path to image/head.png";
                    }
                    if($row3['dob']!=null){
                        $bday = new DateTime($row3['dob']);
                        $today = new Datetime(date('m.d.y'));
                        $age=strval($today->diff($bday)->y);
                    }
                    else{
                        $age='-';
                    }
                    if($row3['late']==1){
                        $uid = 'LATE';
                    }
                    else{
                        $uid=$row3['uid'];
                    }
                    if($row3['blood']==null){
                        $blood = '-';
                    }
                    else{
                        $blood=$row3['blood'];
                    }
        
                    $childMember = array(
                        "id" => $row3["mid"],
                        "name" => $row3["name"],
                        "contact"=>$row3['contact'],
                        "education" => $row3["study"],
                        "whatsapp" => "-",
                        "age" => $age,
                        "familyId"=>$uid,
                        "blood"=>$blood,
                        "profileImageUrl" => $image,
                        "count"=>strval($allcnt)
                        
                    );
                    $childrenData[] = $childMember;
        
        
                }
                
                $response['children'] = $childrenData;
                
                
                
            }else {
                $spouse = null;
            }
            
            
        }
        else{
            return null;
        }
        

        return $response;
    }
}

$familyMemberObj = new FamilyMember();
$familyMemberId = $_GET['id'];
$sessionId=$_POST['sessionId'];
$familyMembers = $familyMemberObj->getFamilyMemberDetails($familyMemberId,$sessionId);

$jsonResponse = json_encode($familyMembers);

header("Content-Type: application/json");

header("Access-Control-Allow-Origin: *");

header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

header("Access-Control-Allow-Headers: Content-Type");

header("Access-Control-Allow-Credentials: true");

echo $jsonResponse;

?>
