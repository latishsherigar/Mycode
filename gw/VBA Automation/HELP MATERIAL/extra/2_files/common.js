
// alert("Common_js Start");

function submitCheck() 
{ 
//	alert( document.frmArt );
//	alert( document.frmArt.elements.length );
//	alert( document.frmArt.elements[0] );
	var sArtNum = document.frmArt.elements[0].value;
	if (sArtNum == '')	return false;

	var M = sArtNum.match(/([A-Z]{0,2})[0-9]{5,6}/);
	var Action = "";
	
	if( null != M )
	{
	/******
	*** This code commented out to support all kbarticle searches with and without prefix.
		if( M[1] == "" )	Action = "Q" + M[0];
		else		Action = M[0];
		document.frmArt.action = "default.aspx?scid=kb;[LN];" + Action;
	******/
		document.frmArt.action = "default.aspx?scid=kb;[LN];" + sArtNum;
	}
	else 
	{ 
		alert("The [" + sArtNum + "] won't bring you any articles. Try something like Q123456"); 
		return false; 
	}
} 


function gsfx_switchUIMode(elementName){

	if(d.getElementsByName){
		adv = d.getElementsByName(elementName);
		if(adv.length > 0){
			var dm = adv[0].style.display;
			if(dm == "none") dm = "block";
			else dm = "none";
			for(i=0; i<adv.length; i++){
				adv[i].style.display = dm;
			}
		}
	}else if(d.all){
		var dm;
		for(i=0; i<d.all.length;i++){
			if(d.all[i].id == elementName){
				dm = d.all[i].style.display;
				break;
			}
		}

		if(dm == "none") dm = "block";
		else dm = "none";

		for(i=0; i<d.all.length;i++){
			if(d.all[i].id == elementName) d.all[i].style.display = dm;
		}
	}

	setcookieval(elementName+"_switchMode", dm);
}

function PartWrapperToggle(elementName) {
	var HeaderElement = null;
	var BodyElement = null; 
	if(document.getElementsByName) {
		HeaderElement = document.getElementsByName(elementName+"Header");
		BodyElement = document.getElementsByName(elementName+"Body");
		UpImage = document.getElementsByName(elementName+"Up");
		DownImage = document.getElementsByName(elementName+"Down");
		if(BodyElement) {	
			if(BodyElement[0].style.display == "none") {
				BodyElement[0].style.display = "block";
				HeaderElement[0].className = "ListNuggetHeader";
				DownImage[0].style.display = "none";
				UpImage[0].style.display = "block";
			} else {
				BodyElement[0].style.display = "none";
				HeaderElement[0].className = "ListNuggetHeaderClosed";
				UpImage[0].style.display = "none";
				DownImage[0].style.display = "block";
			}
		}	
	}
	window.event.cancelBubble = true;
	return false;

}

function NoSearchResultsTrigger(url) 
{
	GSFxNewWindow(url);
}
document.NoSearchResultsTrigger = NoSearchResultsTrigger;

function GSFxNewWindow(url){
	if(d.body.clientHeight){
		winheight = Math.round(window.document.body.clientHeight * 0.9);
		winwidth = Math.round(window.document.body.clientWidth * 0.9);
		leftmargin = Math.round(window.document.body.clientWidth * 0.05);
		topmargin = Math.round(window.document.body.clientWidth * 0.02);
	}else{
		winheight = Math.round(d.body.offsetHeight * 0.9);
		winwidth = Math.round(d.body.offsetWidth * 0.9);
		leftmargin = Math.round(d.body.offsetWidth * 0.05);
		topmargin = Math.round(d.body.offsetWidth * 0.02);
	}
	var win = window.open(url, "_blank", "resizable=yes,scrollbars=yes,menubar=yes,location=yes,toolbar=yes,status=yes,height="+winheight+",width="+winwidth+",left="+leftmargin+",top="+topmargin);
	win.focus();
}


function srch_setcookieval(key, val){
	if(typeof(CookieDomain) != "undefined"){
		if(document.domain.indexOf(".com") > -1 && CookieDomain.length > 0){
			document.domain = CookieDomain;
			document.cookie = key+'='+val+'; Domain='+CookieDomain+'; path=/';
		}else document.cookie = key+'='+val+'; path=/';
	}
}

function ShowSurveyWindow(SurveyURL)
{	
	var sSiteID = '', sSiteRegionID = '', sReferringURL = '', P0 = '', P1 = '', P2 = '', P3 = '', P4 = '', P5 = '', P6 = '', P7 = '', P8 = '', P9 = '';
	if(ShowSurveyWindow.arguments.length > 1){sSiteID = ShowSurveyWindow.arguments[1];}
	if(ShowSurveyWindow.arguments.length > 2){sSiteRegionID = ShowSurveyWindow.arguments[2];}
	if(ShowSurveyWindow.arguments.length > 3){sReferringURL = ShowSurveyWindow.arguments[3];}
	if(ShowSurveyWindow.arguments.length > 4){P0 = ShowSurveyWindow.arguments[4];}
	if(ShowSurveyWindow.arguments.length > 5){P1 = ShowSurveyWindow.arguments[5];}
	if(ShowSurveyWindow.arguments.length > 6){P2 = ShowSurveyWindow.arguments[6];}
	if(ShowSurveyWindow.arguments.length > 7){P3 = ShowSurveyWindow.arguments[7];}
	if(ShowSurveyWindow.arguments.length > 8){P4 = ShowSurveyWindow.arguments[8];}
	if(ShowSurveyWindow.arguments.length > 9){P5 = ShowSurveyWindow.arguments[9];}
	if(ShowSurveyWindow.arguments.length > 10){P6 = ShowSurveyWindow.arguments[10];}
	if(ShowSurveyWindow.arguments.length > 11){P7 = ShowSurveyWindow.arguments[11];}
	if(ShowSurveyWindow.arguments.length > 12){P8 = ShowSurveyWindow.arguments[12];}
	if(ShowSurveyWindow.arguments.length > 13){P9 = ShowSurveyWindow.arguments[13];}

	var fullURL = SurveyURL + '&site=' + sSiteID + '&siteregion=' + sSiteRegionID + '&url=' + sReferringURL + '&p0=' + P0 + '&p1=' + P1 + '&p2=' + P2 + '&p3=' + P3 + '&p4=' + P4 + '&p5=' + P5 + '&p6=' + P6 + '&p7=' + P7 + '&p8=' + P8 + '&p9=' + P9;
	window.open(fullURL, 'survey', 'resizable=yes,scrollbars=yes,menubar=no,location=no,toolbar=no,status=no,height=500,width=725');
	if(window.event != null) window.event.cancelBubble = true;
	//return false;
}

function PrintContents()
{
	window.print();
}

function LogHit(sUrl)
{
	if(typeof(sUrl) != "undefined")
	{
		var cv;
		var dg = "";
		var p1 = "guid=";
		var p2 = "&guid=";
		var gl = 32;	
		cv = fetchcookieval("MC1").toLowerCase();
		if(cv == "blank") cv = fetchcookieval("MC2").toLowerCase();
		if(cv != "blank")	{
			if(cv.substr(0,p1.length) == p1) { dg = cv.substr(p1.length, gl); }
			else if(cv.indexOf(p2) > -1){ dg = cv.substr(cv.indexOf(p2) + p2.length, gl); }
		}
		sUrl = sUrl + "&msid=" + dg;
		if(document.images) {
			document.images["metrixgif"].src = sUrl;
		}

	}
}