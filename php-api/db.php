<?php
/* Database connection settings */
$host = 'localhost';
$user = 'username';
$pass = 'password';
$db = 'database';
$mysqli = new mysqli($host,$user,$pass,$db) or die($mysqli->error);
$connect = mysqli_connect("localhost", "username", "password", "database"); 

// DB credentials.
define('DB_HOST','localhost');
define('DB_USER','username');
define('DB_PASS','password');
define('DB_NAME','database');
// Establish database connection.
try
{
$dbo = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME,DB_USER, DB_PASS,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"));
}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}
?>
