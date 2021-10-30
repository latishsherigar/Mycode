<?php
$con;

function connect_db(){
 $con = mysql_connect("localhost","root","");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
mysql_select_db("SDES", $con);

}

function close_db(){
mysql_close($con);
}


function pop_combo($name,$rs){
 echo("<SELECT name=" .$name. " >");
 echo("<option value='select' selected>Select....</option>");
 while ($vrow = mysql_fetch_array($rs))
 { 
   echo("<option value='".$vrow[0]."'>" . $vrow[1]. "</option>");
 }
 echo("</SELECT>");
}

function pop_fin_period(){
$rs=mysql_query("SELECT MASTERCODE,ANSW1 FROM generic_master");
pop_combo("fin_period",$rs);
echo "sdsda";
} 


connect_db();
pop_fin_period();
close_db();
?>
me here
