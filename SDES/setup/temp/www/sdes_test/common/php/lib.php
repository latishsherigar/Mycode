<?php
$REPORT_SERVER_APP="report_server_test";
$REPORT_SERVER_PATH="http://localhost:8080/".$REPORT_SERVER_APP."/ReportEngine?rep_app_name=sdes&";

function connect_db(){
$DB_NAME="SDES_TEST";
$DB_HOST="";
$DB_USER="root";
$DB_PASS="";

 $con = mysql_connect($DB_HOST,$DB_USER,$DB_PASS);

if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
mysql_select_db($DB_NAME, $con);

}

function close_db(){
mysql_close($con);
}

function execute_query($strquery){
  $result = mysql_query($strquery);
  if (!$result) {
	$errno = mysql_errno();
	$error = mysql_error();

	die("Database Error (".$errno ."): ".$error) ;
  }
  
  return $result;
}


function number2words($number)
{

    if (($number < 0) || ($number > 999999999))
    {
        return "$number";
    }

    $Crn = floor($number / 10000000);  // Crore 
    $number -= $Crn * 1000000;

    $Lkn = floor($number / 100000);     // Lakhs 
    $number -= $Lkn * 100000;
    
    $Thn = floor($number / 1000);     // Thousands 
    $number -= $Thn * 1000;
    
    $Hdn = floor($number / 100);      // Hundreds 
    $number -= $Hdn * 100;
    
    $tn = floor($number / 10);       // Tens  
    
    $n = $number % 10;               // Ones 

    $res = "";

    if ($Crn)
    {
        $res .= number2words($Crn) . " Crore";
    }

    if ($Lkn)
    {
        $res .= " ". number2words($Lkn) . " Lakh";
    }

    if ($Thn)
    {
        $res .= " ". number2words($Thn) . " Thousand";
    }

    if ($Hdn)
    {
         $res .= " ". number2words($Hdn) . " Hundred";
    }

    $ones = array("", "One", "Two", "Three", "Four", "Five", "Six",
        "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen",
        "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eightteen",
        "Nineteen");
    $tens = array("", "", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty",
        "Seventy", "Eigthy", "Ninety");



$res .= " ". $tens[$tn] ;

if($tn==1){
  $res .= " ".$ones[$tn*10+$n] ;
 }

if($tn!=1){
  $res .= " " . $ones[$n] ;
 }
    
    return trim($res);

}


function clean_form_data($strdata){
  $strdata=trim($strdata);
  return $strdata;
}
?>
