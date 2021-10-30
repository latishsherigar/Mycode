
$( document ).ready(function() {
    console.log( "ready!" );
	
	displayStates();
	document.getElementById("divResults").style.visibility = "hidden";
	document.getElementById("div_api_download").style.visibility = "hidden";
	

});

function refreshData(){

	document.getElementById("div_api_download").style.visibility = "visible";
	document.getElementById("divResults").style.visibility = "hidden";

 var cowinUrl;
 var d = new Date();
 var day =  d.getDate();
 var hour_of_day = d.getHours();
 
 if(hour_of_day >= 18){
   day = day + 1; 
 }
 
 day = "" + day;
 
 var month =  d.getMonth() + 1;
 var year = "" + d.getFullYear();
 
 //console.log("day - " + day.length);
 
 if(day.length==1){
   day ="0" + day;
 }

 if(("" + month).length==1){
   month ="0" + month;
 }

var searchDate = day +"-"+ month +"-"+ year;
//console.log("searchDate - " + searchDate);

 
if(document.getElementById("radioDistrictCode").checked){
  var district_id = document.getElementById("districtList").value; 
  cowinUrl = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/calendarByDistrict?district_id="+ district_id + "&date=" + searchDate;
}else{
  var pincode = document.getElementById("pincode").value; 
  //alert(pincode);
  cowinUrl = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/calendarByPin?pincode=" + pincode+ "&date=" + searchDate;
}

    $.get(cowinUrl, function(data, status){
     //alert("Data: " + data + "\nStatus: " + status);
	  process_cowinapi_result(data);
	  
    })
	  .done(function() {
		//alert( "second success" );
	  })
	  .fail(function(jqXHR, textStatus) {
		//alert( "error" );
		console.log("data - " + jqXHR);
		console.log("textStatus - " + textStatus);
			document.getElementById("divResults").innerHTML="<center><h2>An error has occured. Please try again after sometime.</h2></center>";

		display_results_window();
		
		
	  })
	  .always(function() {
		//alert( "finished" );
	  });
}

//function filterByPinCode(item){
//   console.log("item -" + item);
//    return item.pincode == document.getElementById("pincode").text;     
//}

function displayStates(){
	var cowinUrl = "https://cdn-api.co-vin.in/api/v2/admin/location/states";
	
	
    $.get(cowinUrl, function(data, status){

		 var states = data.states;
		
	     for (var index = 0; index < states.length; index++) {
			//console.log("state -" + states[index].state_name);
			$('#stateNameList').append('<option value="' + states[index].state_id + '">' + states[index].state_name + '</option>');
			}
    })
	  .done(function() {
		//alert( "second success" );
	  })
	  .fail(function(jqXHR, textStatus) {
		//alert( "error" );
		console.log("data - " + jqXHR);
		console.log("textStatus - " + textStatus);
		document.getElementById("divResults").innerHTML="<center><h2>An error has occured. Please try again after sometime.</h2></center>";
		display_results_window();
		
		
	  });

}

function stateDropDownValueChange(){
   document.getElementById("radioDistrictCode").checked = true;

	getdistricts();
}


function pincodeValueChange(){
   document.getElementById("radioPinCode").checked = true;

}

function getdistricts(){

	var state_id = document.getElementById("stateNameList").value;
	var cowinUrl = "https://cdn-api.co-vin.in/api/v2/admin/location/districts/"+ state_id ;
	
	
    $.get(cowinUrl, function(data, status){

		 var districts = data.districts;
		 $('#districtList').empty();
		 $('#districtList').append('<option value=""></option>');
		 
	     for (var index = 0; index < districts.length; index++) {
			$('#districtList').append('<option value="' + districts[index].district_id + '">' + districts[index].district_name + '</option>');
			}
    })
	  .done(function() {
		//alert( "second success" );
	  })
	  .fail(function(jqXHR, textStatus) {
		//alert( "error" );
		console.log("data - " + jqXHR);
		console.log("textStatus - " + textStatus);
		document.getElementById("divResults").innerHTML="<center><h2>An error has occured. Please try again after sometime.</h2></center>";
		display_results_window();
		
		
	  });

}



function filterByFeeType(item){
	if(document.getElementById("feetypeFree").checked && !document.getElementById("feetypePaid").checked){
     return item.fee_type == "Free" || item.fee_type == ""; 
	}

	if(!document.getElementById("feetypeFree").checked && document.getElementById("feetypePaid").checked){
      return item.fee_type == "Paid" || item.fee_type == "";
	}

	//if both are checked
	if(document.getElementById("feetypeFree").checked && document.getElementById("feetypePaid").checked){
   	  return item.fee_type == item.fee_type|| item.fee_type == "";
	}

	//if both are unchecked
	if(!document.getElementById("feetypeFree").checked && !document.getElementById("feetypePaid").checked){
   	  return item.fee_type == item.fee_type|| item.fee_type == "";
	}

            
}


function filterCenterSessionsByAgeGroup(center){
	var min_age_limit = 0;

	 	if(document.getElementById("age_18_45").checked && !document.getElementById("age_45plus").checked){
			min_age_limit = 18; 
			//console.log("min_age_limit " + min_age_limit);
		}

		if(!document.getElementById("age_18_45").checked && document.getElementById("age_45plus").checked){
		  min_age_limit = 45;
			//console.log("min_age_limit " + min_age_limit);
		}

			//console.log("min_age_limit " + min_age_limit);
			//console.log("document.getElementById('age_18_45').checked " + document.getElementById('age_18_45').checked);
			//console.log("document.getElementById('age_45plus').checked " + document.getElementById('age_45plus').checked);
	
	for(var i=0;i<center.sessions.length;++i){

		if(min_age_limit != 0){
			var session = center.sessions[i];
			//console.log("session.min_age_limit " + session.min_age_limit);
			//console.log("min_age_limit " + min_age_limit);
			
			 if(session.min_age_limit != min_age_limit ){
			 console.log ("min age - deleting session  - " + center.sessions[i]);
			   center.sessions[i].session_id="";
			 }
		
		}

	}
return center;
}



function filterCenterSessionsByAvalability(center){
	//console.log("filterCenterSessionsByAvalability -" + center.center_id);
	
	for(var i=0;i<center.sessions.length;++i){
	

			var session = center.sessions[i];
			
			 if(session.available_capacity == 0 ){
			 console.log ("deleting session - " + center.sessions[i]);
			   center.sessions[i].session_id="";
			 }
		


	}
	
return center;
}





function process_cowinapi_result(response_data){
var centers = response_data.centers;


var filtered_centers = centers;
filtered_centers = filtered_centers.filter(filterByFeeType);



var resultsHtml = "<table id='centers'><th>Center</th>";
	console.log("centers: " + filtered_centers.length );

var atleast_1_session_present=false;

 for(var i=0;i<filtered_centers.length;++i){
    
	var center = filtered_centers[i];
	center = filterCenterSessionsByAgeGroup(center);
	center = filterCenterSessionsByAvalability(center);
	
	var session_present = false;
	var session_html="" ;
	var session_count =0;
	
	for(var j=0;j<center.sessions.length;++j){
	  if(center.sessions[j].session_id!=""){
	    session_present = true;
		atleast_1_session_present = true;
		++session_count;
		var session = center.sessions[j];
		session_html= session_html + "<td><br/><center>" + session.date +"<br/><br/>" + session.available_capacity +" </center><br/></td>";
	  }
	}
	
	while(session_count < 8){
		session_html= session_html + "<td><center>------------</center></td>";	 
		++session_count;
	}
	
	if(session_present){
	
		resultsHtml=resultsHtml + "<tr><td><center><b>" + center.name + "</b> - "+ center.block_name + ","+ center.pincode + "</center></td>" + session_html + "</tr>";
	
	}
 
 }

	if(atleast_1_session_present){
		resultsHtml=resultsHtml + "</table>";
    }else{
	   resultsHtml ="<br/><center><h1>Nothing available now :( </center> <h2>"
	}

	document.getElementById("divResults").innerHTML=resultsHtml;
	display_results_window();

}

function display_results_window(){
	document.getElementById("div_api_download").style.visibility = "hidden";
	document.getElementById("divResults").style.visibility = "visible";

}

