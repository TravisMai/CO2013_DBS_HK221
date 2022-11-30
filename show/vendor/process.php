<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$dbname = "reality_show";
try {
    $ssn = $_POST['ssn'];
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $dob = $_POST['dob'];
    $photo = 'uploads/sheaf-of-rice.png';
    $company = $_POST['company'];
    $syear = $_POST['season'];
    $sql = "INSERT INTO `person` (Ssn,Fname,Lname,PAddress,Phone)
	 VALUES ($ssn,'$fname','$lname','$address','$phone'); 
     INSERT INTO `trainee` (Ssn,DoB,Photo,Company_ID) 
     VALUES ($ssn,'$dob','$photo','$company');
     INSERT INTO `seasontrainee` (`Syear`, `Ssn_trainee`) 
     VALUES ('$syear', '$ssn');";
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    /* set the PDO error mode to exception */
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conn->exec($sql);
    echo "New record created successfully";
} catch (PDOException $e) {

    echo $sql . "<br>" . $e->getMessage();
}

$conn = null;
?>