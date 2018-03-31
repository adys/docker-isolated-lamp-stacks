<?php
$mysqli = new mysqli("mysql","dbuser","test","db");

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = $mysqli->query("SHOW TABLES");
$tables = $result->fetch_all();

foreach($tables as $table)
{
    echo "<h2>" . $table[0] . "</h2>";
    $query = "DESCRIBE " . $table[0];
    $result = $mysqli->query($query);
    $columns = $result->fetch_all();
    foreach($columns as $column)
    {
        echo $column[0] . "<br />";
    }
}
$mysqli->close();
?>
