<?php
include("lib.php") ;
 connect_db();

$cmp_name=strtolower(trim($_REQUEST["cmp_name"]));
$cmpname_txtbox=trim($_REQUEST["cmpname_txtbox"]);
$cmpcode_txtbox=trim($_REQUEST["cmpcode_txtbox"]);
?>

<script>
function select_cmp_code(cmp_code,cmp_name){
  var cmpname_txtbox=opener.document.getElementById('<?php echo $cmpname_txtbox ?>');
  var cmpcode_txtbox=opener.document.getElementById('<?php echo $cmpcode_txtbox ?>');
 
  cmpname_txtbox.value=cmp_name;
  cmpcode_txtbox.value=cmp_code;
  window.close();
}
</script>

<center><h3>Company Search</h3></center>
<form name="cmp_search" method="post">
<table align="center" border="0">
<tr>
<td>Company Name: </td>
<td><input type="text" name="cmp_name" value=""></td>
</tr>
</table>
<p>
<table align="center" border="1">
<tr>
<td><input type="submit" value="Search"></td>
<td><input type="button" value="Close" onclick="window.close();"></td>
</tr>
</table>
<hr>

<?php
$str_query="SELECT * 
           FROM entity_details
           WHERE ed_entity_type='COMPANY'
           AND   LCASE(ed_name) LIKE '".$cmp_name."%'
";
//echo $str_query;

$rs = execute_query($str_query);

if(mysql_num_rows($rs) > 0 ){
  echo'Search Results';
?>
<table align="center" border="1">
<tr>
<th>Name</th>
</tr>
<?php
while($vrow=mysql_fetch_array($rs)){
 echo '<tr><td><a href="#" onclick="select_cmp_code(\''.$vrow["ed_code"].'\',\''.$vrow["ed_name"].'\');">'.$vrow["ed_name"].'</a></td></tr>';
}

?>
</table>
<?php
}
?>

</form>

<?php
close_db();
?>
