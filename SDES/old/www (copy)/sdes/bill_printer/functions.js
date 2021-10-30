function inv_no_blur(inv_txtbox){
  if(trim(inv_txtbox.value)==''){
    return false; 
   }
 
  set_operation('load');
  document.frm_bill.submit();
}

function show_company_search(cmpname_txtbox,cmpcode_txtbox){
  window.open('../common/php/cmp_search.php?cmpname_txtbox='+cmpname_txtbox+'&cmpcode_txtbox='+cmpcode_txtbox,'cmp_search');
}

function cal_total_rs(){
var frm=document.frm_bill;

rs1=parseFloat(IsBlankString(frm.inv_det_rs1.value)?0:frm.inv_det_rs1.value);
rs2=parseFloat(IsBlankString(frm.inv_det_rs2.value)?0:frm.inv_det_rs2.value);
rs3=parseFloat(IsBlankString(frm.inv_det_rs3.value)?0:frm.inv_det_rs3.value);
rs4=parseFloat(IsBlankString(frm.inv_det_rs4.value)?0:frm.inv_det_rs4.value);
rs5=parseFloat(IsBlankString(frm.inv_det_rs5.value)?0:frm.inv_det_rs5.value);


frm.inv_total_rs.value=parseFloat(rs1) +
                       parseFloat(rs2) +
                       parseFloat(rs3) +
                       parseFloat(rs4) +
                       parseFloat(rs5) ;

}

function set_operation(op){
 document.frm_bill.operation.value=op;
 }

function save_click(){
 if(confirm('Are you sure you want to save the data for invoice no: '+ document.frm_bill.inv_no.value)){
   if(validate()){
   set_operation('save');
   document.frm_bill.submit();
   }
 }

}
 
function validate(){
var frm=document.frm_bill;

 if(IsBlankString(frm.inv_no.value)){
   alert('Please enter a valid Invoice No.');  
   frm.inv_no.focus();
   return false;
  }


 if(IsBlankString(frm.inv_dt.value)){
   alert('Please enter a valid Date.');  
   frm.inv_dt.focus();
   return false;
  }

 if(IsBlankString(frm.inv_cmp_code.value)){
   alert('Please Select a Company.');  
   frm.inv_cmp_code.focus();
   return false;
  }
  
 if(IsBlankString(frm.inv_total_rs.value)){
   alert('Please Enter some Particulars.');  
   frm.inv_det_part0.focus();
   return false;
  }  
  
  return true;
 }
