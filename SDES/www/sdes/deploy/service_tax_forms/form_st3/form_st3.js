
function pop_fin_yr(stryear)
{
var d = new Date();
var sel_yr_text ;
var curr_year;

if(stryear==""){
  curr_year = d.getFullYear();
}
else{
  curr_year = stryear;   
}

curr_year = parseInt(curr_year);

 document.write('<SELECT name="fin_year" onchange=loaddata();>');
 for(i=2000;i<=parseInt(d.getFullYear()) + 1;++i){
    
    sel_yr_text=""; 
    
    j = String(i+1).substr(2);
    //alert('<option value=' + i + '-' + j + ' ' + sel_yr_text );
    
    if( i==curr_year)
      {
       sel_yr_text="selected";
      }
     document.write('<option value=' + i + '-' + j + ' ' + sel_yr_text +' >' 
                    + i + '-' + j + '</option>');
  }
 document.write('</SELECT>');

}


function add_pay_srv_tax_cat()
{
document.form_st3.operation.value ="add_pdsc";
document.form_st3.submit();
}

function del_pay_srv_tax_cat(pdsc_group_no)
{
if(confirm('Are you sure u wish to continue ?')){
  document.form_st3.operation.value ="del_pdsc";
  document.form_st3.pdsc_group_no.value =pdsc_group_no;
  document.form_st3.submit();
 } 
}


function removeEvent(divNum)
{
var d = document.getElementById('pay_srv_tax_cat_Div');
var olddiv = document.getElementById(divNum);
d.removeChild(olddiv);
}

function validate_input(){


}

function loaddata(){
  document.form_st3.operation.value="loaddata";
  document.form_st3.submit();
}

function fin_period_change(){
  loaddata();
}

function submitform(){
  document.form_st3.operation.value = "savedata";
  return confirm("Are you sure you want to save the data ?");
}

function add_rfsc()
{
 var v_rfsc_desc_count = parseInt(document.getElementById('rfsc_desc_count').value);
 var v_div_rfsc = document.getElementById('div_rfsc');
 var divIdName = 'div_child_rfsc' ;
 var v_div = document.createElement('div');
 v_div.setAttribute("id",divIdName);
 v_div.innerHTML = replaceAll(document.getElementById('div_template_rfsc').innerHTML,"_no%", v_rfsc_desc_count);
 v_div_rfsc.appendChild(v_div);
 ++document.getElementById('rfsc_desc_count').value; 
}


function add_ipsvcs()
{
 var v_ipsvcs_desc_count = parseInt(document.getElementById('ipsvcs_desc_count').value);
 var v_div_ipsvcs = document.getElementById('div_ipsvcs');
 var divIdName = 'div_child_ipsvcs' ;
 var v_div = document.createElement('div');
 v_div.setAttribute("id",divIdName);
 v_div.innerHTML = replaceAll(document.getElementById('div_template_ipsvcs').innerHTML,"_no%", v_ipsvcs_desc_count);
 v_div_ipsvcs.appendChild(v_div);
 ++document.getElementById('ipsvcs_desc_count').value; 

}

function validate_pdsc_cell(e,txtbox,data_type){

  if(data_type=='NUMBER'){  
    return numbersonly(e);
    }
    
  return true;
  
}
  

function cal_total_values(txtbox,pdsc_id,pdsc_code,pdsc_data_type){
var frm = document.form_st3;
var txta = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_a.value");
var txtb = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_b.value");
var txtc = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_c.value");
var txtd = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_d.value");
var txte = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_e.value");
var txtf = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_f.value");


if(pdsc_data_type=='NUMBER'){  
   inta=parseFloat(IsBlankString(txta)?0:txta);
   intb=parseFloat(IsBlankString(txtb)?0:txtb);
   intc=parseFloat(IsBlankString(txtc)?0:txtc);
   intd=parseFloat(IsBlankString(txtd)?0:txtd);
   inte=parseFloat(IsBlankString(txte)?0:txte);
   intf=parseFloat(IsBlankString(txtf)?0:txtf);
   totaltxtbox = eval("frm.pdsc_" + pdsc_id + "_" + pdsc_code + "_g");
   totaltxtbox.value = inta + intb + intc + intd + inte + intf;
   if(totaltxtbox.value == 0){
     if(IsBlankString(txta)||IsBlankString(txtb)||IsBlankString(txtc)||
        IsBlankString(txtd)||IsBlankString(txte)||IsBlankString(txtf)){
          totaltxtbox.value = '';         
       }
   }
}   

return true;

}
