<?php
// Connect to server and select database.
$con = mysqli_connect("DB_SERVER", "DB_USERNAME", "DB_PASSWORD", "DB_NAME") or die(mysqli_error());

//select values from visitor_counter table
$sql = "SELECT * FROM visitor_counter";
$result = mysqli_query($con, $sql);
$row = mysqli_fetch_array($result);
$counter = $row['counts'];

// setting counter = 1, if we have no counts value
if (empty($counter)) {
  $counter = 1;
  $sql1 = "INSERT INTO visitor_counter(counts) VALUES('$counter')";
  $result1 = mysqli_query($con, $sql1);
}

echo "You 're visitors No. ";
echo $counter;

// Incrementing counts value
$plus_counter = $counter + 1;
$sql2 = "update visitor_counter set counts='$plus_counter'";
$result2 = mysqli_query($con, $sql2);

mysqli_close($con);
?>