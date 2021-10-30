
<?php

function pop_combo($name,$rs,$selectval){
 echo("<SELECT name=" .$name. " onchange=".$name."_change()>");
 echo("<option value=''></option>");
 while ($vrow = mysql_fetch_array($rs))
 { 
   echo("<option value='".$vrow[0]."'");
   if($vrow[0]==$selectval){
     echo("selected");
   } 
   echo(" >" . $vrow[1]. "</option>");
 }
 echo("</SELECT>");

}

function pop_rfsc_desc(){
  global $fin_year,$fin_period,$rfsc_desc_count;

   $str_query="
   SELECT * 
   FROM  ret_filed_srvs_cat
   WHERE rfsc_fin_yr='".$fin_year ."' 
   AND   rfsc_fin_period_cd ='".$fin_period ."' ORDER BY rfsc_order_no" ;
  
   $rs = execute_query($str_query);

   while ($vrow = mysql_fetch_array($rs))
   { 
      echo "<tr><td><input type='text' name='rfsc_desc[]' value='"; 
      echo $vrow["rfsc_desc"]. "' size='50'></td><td>";
      echo "<input type='hidden' name='rfsc_desc_no[]' value='";
      echo $vrow["rfsc_order_no"]."'></td></tr>" ;
      ++$rfsc_desc_count;
   }
      echo "<script>document.getElementById('rfsc_desc_count').value=".$rfsc_desc_count."</script>";

}

function pop_ipsvcs_desc(){
  global $fin_year,$fin_period,$ipsvcs_desc_count;

   $str_query="
   SELECT * 
   FROM  ip_srvc_credit_srvs
   WHERE ipsvcs_fin_yr='".$fin_year ."' 
   AND   ipsvcs_fin_period_cd ='".$fin_period ."'" ;
  
   $rs = execute_query($str_query);

   while ($vrow = mysql_fetch_array($rs))
   { 
      echo "<tr><td><input type='text' name='ipsvcs_desc[]' value='" 
           .$vrow["ipsvcs_desc"]. "' size='50'></td></tr>" ;
      echo "<input type='hidden' name='ipsvcs_desc_no[]' value='";
      echo $vrow["ipsvcs_order_no"]."'></td></tr>" ;
      ++$ipsvcs_desc_count;
   }
   echo "<script>document.getElementById('ipsvcs_desc_count').value=".$ipsvcs_desc_count."</script>";

}



function pop_fin_period(){
  global $fin_year,$fin_period;

  $str_query="
             SELECT code1,answ1 
             FROM generic_master
             WHERE mastercode='FINANCIAL_PERIOD'";

  $rs = execute_query($str_query);
  pop_combo("fin_period",$rs,$fin_period);
} 


function load_data(){
  global $fin_year,$fin_period,$fst3_assessee_name,$fst3_premises_reg_no,
         $fst3_lastday_amt_payable;

   $str_query="
   SELECT * 
   FROM  form_st3
   WHERE fst3_fin_yr='".$fin_year ."' 
   AND   fst3_fin_period_cd ='".$fin_period ."'" ;
  
   $rs = execute_query($str_query);

   $fst3_assessee_name = '';
   $fst3_premises_reg_no = '' ;
   $fst3_lastday_amt_payable = '';

 while ($vrow = mysql_fetch_array($rs))
 { 
   $fst3_assessee_name = $vrow["fst3_assessee_name"];
   $fst3_premises_reg_no =  $vrow["fst3_premises_reg_no"];
   $fst3_lastday_amt_payable =  $vrow["fst3_lastday_amt_payable"];
 }

//fetch the pdsc data

   $str_query="
   SELECT * 
   FROM  pay_det_srvctax_cat
   WHERE pdsc_fin_yr ='".$fin_year ."' 
   AND   pdsc_fin_period_cd ='".$fin_period ."'" ;
  
   $rs = execute_query($str_query);
   
   if(mysql_num_rows($rs)==0){
     add_pdsc_data();
     
   }
}

function del_pdsc_data(){
 global $fin_year,$fin_period;
 
 $pdsc_group_no=$_REQUEST["pdsc_group_no"];
 
   $str_query="
   DELETE 
   FROM  pay_det_srvctax_cat_det
   WHERE pdscd_pdsc_id IN
      (SELECT pdsc_id
       FROM   pay_det_srvctax_cat
       WHERE  pdsc_fin_yr ='".$fin_year ."' 
       AND    pdsc_fin_period_cd ='".$fin_period ."'
       AND    pdsc_group_no = '".$pdsc_group_no ."'
       )" ;
  
  //echo $str_query;
  
   $rs = execute_query($str_query);
 
   $str_query="
       DELETE
       FROM   pay_det_srvctax_cat
       WHERE  pdsc_fin_yr ='".$fin_year ."' 
       AND    pdsc_fin_period_cd ='".$fin_period ."'
       AND    pdsc_group_no = '".$pdsc_group_no ."'
       " ;
  
   $rs = execute_query($str_query);


}


function add_pdsc_data(){
  global $fin_year,$fin_period;

   $str_query="
   SELECT MAX(pdsc_group_no) AS pdsc_max_group_no 
   FROM  pay_det_srvctax_cat
   WHERE pdsc_fin_yr ='".$fin_year ."' 
   AND   pdsc_fin_period_cd ='".$fin_period ."'" ;

 
   $rs = execute_query($str_query);

  $pdsc_max_group_no = 0;
   
   if(mysql_num_rows($rs) > 0){
    $vrow = mysql_fetch_array($rs);
    $pdsc_max_group_no = $vrow["pdsc_max_group_no"]; 
   }

  ++$pdsc_max_group_no ;
  
   $str_query="
   INSERT INTO pay_det_srvctax_cat
   (pdsc_fin_yr,pdsc_fin_period_cd,pdsc_group_no)
   VALUES('".$fin_year ."','".$fin_period ."','".$pdsc_max_group_no."')" ;

    //echo $str_query;

   $rs = execute_query($str_query);

   $pdsc_id = mysql_insert_id();
   
   $str_query ="
   INSERT INTO pay_det_srvctax_cat_det
   (pdscd_pdsc_id,pdscd_desc_cd)
   (SELECT '".$pdsc_id ."',code1
    FROM   generic_master
    WHERE  mastercode = 'PAY_DET_SRV_TAX_CAT'    
    )" ;
  
   $rs = execute_query($str_query);
   
   //echo $str_query;
   
}

function save_pdsc_data(){
  global $fin_year,$fin_period;

   $str_query="
   SELECT pdsc_id 
   FROM  pay_det_srvctax_cat
   WHERE pdsc_fin_yr ='".$fin_year ."' 
   AND   pdsc_fin_period_cd ='".$fin_period ."'" ;

   $rs = execute_query($str_query);
  
   while ($vrow = mysql_fetch_array($rs)){
    
    
     $pdsc_header = $_REQUEST["pdsc_header_".$vrow["pdsc_id"]];

     $str_query="
     UPDATE pay_det_srvctax_cat
     SET pdsc_header='".$pdsc_header."'
     WHERE pdsc_id ='".$vrow["pdsc_id"] ."'";

     execute_query($str_query);

     $str_query="
     SELECT pdscd_desc_cd
     FROM  pay_det_srvctax_cat_det
     WHERE pdscd_pdsc_id ='".$vrow["pdsc_id"]."'";

     $rs_pdscd = execute_query($str_query);
  
     while ($vrow_pdscd = mysql_fetch_array($rs_pdscd)){
       $fa_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_a"];  
       $fb_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_b"];  
       $fc_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_c"];  
       $fd_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_d"];  
       $fe_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_e"];  
       $ff_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_f"];  
       $fg_val = $_REQUEST["pdsc_".$vrow["pdsc_id"]."_".$vrow_pdscd["pdscd_desc_cd"]."_g"];  
     
       $str_query="
       UPDATE pay_det_srvctax_cat_det
       SET pdscd_f1='".$fa_val."',
           pdscd_f2='".$fb_val."',
           pdscd_f3='".$fc_val."',
           pdscd_f4='".$fd_val."',
           pdscd_f5='".$fe_val."',
           pdscd_f6='".$ff_val."',
           pdscd_ftotal='".$fg_val."'
       WHERE pdscd_pdsc_id ='".$vrow["pdsc_id"] ."'
       AND   pdscd_desc_cd ='".$vrow_pdscd["pdscd_desc_cd"]."'";

       //echo $str_query . "<br>";
       execute_query($str_query);
  
      }   
   
   }

}



function first_save(){
  global $fin_year,$fin_period;

   $str_query="
   SELECT * 
   FROM  form_st3
   WHERE fst3_fin_yr='".$fin_year ."' 
   AND   fst3_fin_period_cd ='".$fin_period ."'" ;

   $rs = execute_query($str_query);
   if(mysql_num_rows($rs) == 0){
      $str_query="
                 INSERT INTO form_st3 
                 (fst3_fin_yr,fst3_fin_period_cd)
                 VALUES('".$fin_year."','".$fin_period."') 
		 ";
      execute_query($str_query);
   } 
}

function get_fin_period_text1(){
  global $fin_year,$fin_period;
  
     $str_query="
     SELECT answ2
     FROM  generic_master
     WHERE mastercode ='FINANCIAL_PERIOD'
     AND   code1 = '".$fin_period."'    
     ";
     
     $rs = execute_query($str_query);

     $vrow = mysql_fetch_array($rs);
     $a = $vrow[0];

     $b=substr($fin_year,2,2);
     $c=substr($fin_year+1,2,2);
     
     $a=str_replace("$1",$b,$a);
     $a=str_replace("$2",$c,$a);
  
     return $a;

}

function update_data(){
  global $fin_year,$fin_period,$fst3_assessee_name,$fst3_premises_reg_no,
         $fst3_lastday_amt_payable;

  $fst3_fin_period_text1 = get_fin_period_text1();

  $str_query="
             UPDATE form_st3 
             SET fst3_assessee_name = '".$fst3_assessee_name."',
	         fst3_premises_reg_no = '".$fst3_premises_reg_no."',
	         fst3_lastday_amt_payable = '".$fst3_lastday_amt_payable."',
	         fst3_fin_period_text1 ='".$fst3_fin_period_text1."'
	     WHERE 
		 fst3_fin_yr = '".$fin_year."'
 	     AND fst3_fin_period_cd = '".$fin_period."'";

      execute_query($str_query);

   save_rfsc_details();
  
   save_ipsvcs_details();
   
   save_pdsc_data();
}

function save_rfsc_details(){
  global $fin_year,$fin_period,$rfsc_desc,$rfsc_desc_no;

  $str_query="
             DELETE FROM ret_filed_srvs_cat 
	     WHERE 
		 rfsc_fin_yr = '".$fin_year."'
 	     AND rfsc_fin_period_cd = '".$fin_period."'";

      execute_query($str_query);

  for($i=0;$i<count($rfsc_desc);++$i){
      $str_query="
             INSERT INTO ret_filed_srvs_cat
             (rfsc_fin_yr,rfsc_fin_period_cd,rfsc_desc,rfsc_order_no)
             VALUES('".$fin_year."','".$fin_period."','".$rfsc_desc[$i]."',".$rfsc_desc_no[$i].")";  

     // echo $str_query."<br/>";
        execute_query($str_query);
   }
}

function save_ipsvcs_details(){
  global $fin_year,$fin_period,$ipsvcs_desc,$ipsvcs_desc_no;

  $str_query="
             DELETE FROM ip_srvc_credit_srvs 
	     WHERE 
		 ipsvcs_fin_yr = '".$fin_year."'
 	     AND ipsvcs_fin_period_cd = '".$fin_period."'";

      execute_query($str_query);

  for($i=0;$i<count($ipsvcs_desc);++$i){
      $str_query="
             INSERT INTO ip_srvc_credit_srvs
             (ipsvcs_fin_yr,ipsvcs_fin_period_cd,ipsvcs_desc,ipsvcs_order_no)
             VALUES('".$fin_year."','".$fin_period."','".$ipsvcs_desc[$i]."',".$ipsvcs_desc_no[$i].")"; 

      //echo $str_query."<br/>";
      execute_query($str_query);
    } 
}

function clean_submit_data(){
  global $fin_year,$fin_period,$fst3_assessee_name,$fst3_premises_reg_no,
         $rfsc_desc,$ipsvcs_desc,$rfsc_desc_no,$ipsvcs_desc_no,
         $fst3_lastday_amt_payable;

  $fin_year = trim($_REQUEST["fin_year"]);
  $fin_period = trim($_REQUEST["fin_period"]);
  $fst3_assessee_name = trim($_REQUEST["fst3_assessee_name"]);
  $fst3_premises_reg_no = trim($_REQUEST["fst3_premises_reg_no"]);
  $fst3_lastday_amt_payable = trim($_REQUEST["fst3_lastday_amt_payable"]);

  foreach ($_REQUEST["rfsc_desc"] as $v) {
   if(trim($v)!=""){
     $rfsc_desc[]=trim($v);
   } 
  } 

 
  foreach ($_REQUEST["ipsvcs_desc"] as $v) {
   if(trim($v)!=""){
     $ipsvcs_desc[]=trim($v);
   } 
  } 

  foreach ($_REQUEST["rfsc_desc_no"] as $v) {
   if(trim($v)!=""){
     $rfsc_desc_no[]=trim($v);
   } 
  } 

  foreach ($_REQUEST["ipsvcs_desc_no"] as $v) {
   if(trim($v)!=""){
     $ipsvcs_desc_no[]=trim($v);
   } 
  } 

}

function validate_data(){
  global $fin_year,$fin_period,$fst3_assessee_name,$fst3_premises_reg_no;

  if($fin_year ==""){
    disp_error_str("Invalid Financial Year.");
    return "false";
  }
 
  if($fin_period ==""){
    disp_error_str("Invalid Financial Period.");
    return false;
  }

  return true;
}

function disp_error_str($errorstr){
  echo "<center><b>".$errorstr."</b></center>"; 
}

function disp_save_message(){
  echo "<center><b>Data Saved Successfully.</b></center>"; 
}


function save_data(){
  first_save();
  update_data();
  disp_save_message();
}

function disp_pdsc(){
 global $fin_year,$fin_period;

   $str_query="
   SELECT pdsc.pdsc_id,
          pdsc.pdsc_group_no,
          pdsc.pdsc_header,
          gm.answ1 as pdsc_desc,
          gm.code1 as pdsc_code,
          gm.answ2 as pdsc_data_type,
          pdscd.*
   FROM  pay_det_srvctax_cat pdsc,
         pay_det_srvctax_cat_det pdscd,
         generic_master gm
   WHERE pdsc_fin_yr='".$fin_year ."' 
   AND   pdsc_fin_period_cd ='".$fin_period ."'
   AND   pdsc_id = pdscd_pdsc_id
   AND   pdscd_desc_cd = code1 
   AND   mastercode = 'PAY_DET_SRV_TAX_CAT'
   " ;
   $rs = execute_query($str_query);


$prev_group_no='xxxxxx';
$group_count = 0;

 while ($vrow = mysql_fetch_array($rs))
 { 
  if($vrow["pdsc_group_no"]!=$prev_group_no)
    {  
        if($prev_group_no!='xxxxxx'){
           echo "</table><p/>";
         }
        ++$group_count;  
        echo "<table border=1><tr>";
        echo "<td>Payment of Service Tax category of Service:</td>";
        echo "<td><input type=text name=pdsc_header_".$vrow["pdsc_id"]." 
                value='".$vrow["pdsc_header"]."' size=50 ></td>";
        echo "<td><input type=button value='Delete' onclick=del_pay_srv_tax_cat('".$vrow["pdsc_group_no"]."');></td>";
        echo "</tr></table>";
        echo "Payment Details:";
        echo "<table border='1' width=100%><tr>";
        echo "<td >&nbsp;</td>";

        if($fin_period=='01'){
           echo "<td align='center' width=8%>Apr.</td>";
           echo "<td align='center' width=8%>May.</td>";
           echo "<td align='center' width=8%>June.</td>";
           echo "<td align='center' width=8%>July.</td>";
           echo "<td align='center' width=8%>Aug.</td>";
           echo "<td align='center' width=8%>Sept.</td>";
         }
       else{
           echo "<td align='center' width=8%>Oct.</td>";
           echo "<td align='center' width=8%>Nov.</td>";
           echo "<td align='center' width=8%>Dec.</td>";
           echo "<td align='center' width=8%>Jan.</td>";
           echo "<td align='center' width=8%>Feb.</td>";
           echo "<td align='center' width=8%>Mar.</td>";
         }
       echo "<td align='center' width=8%>Total</td>";
    }    

       echo "<tr height='50'><td>".$vrow["pdsc_desc"]."</td>";
       echo "<td align='center' width=8%>
        <input type='text'  
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_a' 
          value='".$vrow["pdscd_f1"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=\"cal_total_values(this,'".$vrow["pdsc_id"]."','"
                   . $vrow["pdsc_code"]
                   ."','",$vrow["pdsc_data_type"],"')\"/td>";
       echo "<td align='center' width=8%>
        <input type='text' 
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_b'
          value='".$vrow["pdscd_f2"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=cal_total_values(this,'".$vrow["pdsc_id"]."','"
                   . $vrow["pdsc_code"]
                   ."','",$vrow["pdsc_data_type"],"')></td>";
       echo "<td align='center' width=8%>
        <input type='text' 
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_c' 
          value='".$vrow["pdscd_f3"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=cal_total_values(this,'".$vrow["pdsc_id"]."','"
                  . $vrow["pdsc_code"]
                  ."','",$vrow["pdsc_data_type"],"')></td>";
       echo "<td align='center' width=8%>
        <input type='text' 
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_d'
          value='".$vrow["pdscd_f4"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=cal_total_values(this,'".$vrow["pdsc_id"]
                  ."','". $vrow["pdsc_code"]
                  ."','",$vrow["pdsc_data_type"],"')></td>";
       echo "<td align='center' width=8%>
        <input type='text'
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_e'
          value='".$vrow["pdscd_f5"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=cal_total_values(this,'".$vrow["pdsc_id"]
                  ."','". $vrow["pdsc_code"]
                  ."','",$vrow["pdsc_data_type"],"')></td>";
       echo "<td align='center' width=8%>
        <input type='text' 
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_f'
          value='".$vrow["pdscd_f6"]."' size=5 
          onkeypress=\"return validate_pdsc_cell(event,this,'".$vrow["pdsc_data_type"]."')\"
          onblur=cal_total_values(this,'".$vrow["pdsc_id"]
                  ."','". $vrow["pdsc_code"]
                  ."','",$vrow["pdsc_data_type"],"')></td>";
       echo "<td align='center' width=8%>
        <input type='text' 
          name='pdsc_".$vrow["pdsc_id"]."_".$vrow["pdsc_code"]."_g'
          value='".$vrow["pdscd_ftotal"]."' size=5 readonly ></td></tr>";

   
 $prev_group_no = $vrow["pdsc_group_no"];
 
 }
 
   if($prev_group_no!='xxxxxx'){
        echo "</table><p/>";
     }
     
 echo "<input type='hidden' name='group_count' value='".$group_count."'>";

}


?>
