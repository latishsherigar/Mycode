//onlineopinion ver:1.4.2;
var O_NS4=(document.layers)?1:0;
var O_IE4=(document.all)?1:0;
var O_MAC = (navigator.appVersion.indexOf("Macintosh") > -1);
var O_Url="http://rate.o-pinion.com";
var O_Key=escape(window.location.href);
var O_impth="/onlineopinion/";
var O_final = 0;
var O_tmoff=3600000; // in milliseconds, 3600000=1 hour
var O_Prev=document.referrer;

if (O_NS4) {
 var origWidth = innerWidth;
 var origHeight = innerHeight;
 var width=screen.width;
 var height=screen.height;
 IEBR="";
}
if (O_IE4) {
 var origWidth=document.body.clientWidth;
 var origHeight=document.body.clientHeight;
 var width=screen.width;
 var height=screen.height;
 IEBR="<BR>";
}

O_Key=O_Rpl(O_Key,"/","%2F");
O_Key=O_Rpl(O_Key,".","%2E");
O_Key=O_Rpl(O_Key,"-","%2D");
O_Key=O_Rpl(O_Key,"_","%5F");

function O_Rpl( sr, sf, ss ) { a=sr.split(sf); return a.join(ss); }

function O_setTimer() {
  vistimerID = setTimeout("O_makeVisible()", 500);
}

function O_makeVisible() { 
  if (O_IE4) ovar1.style.display = "block"; 
  clearTimeout(vistimerID); 
  vistimerID = null;
}

function O_Pop1() {
 if (O_NS4) {
  ovar1_element = eval("document.ovar1");
  ovar1_element.visibility = "hide";
  ovar2_element = eval("document.ovar2");
  ovar2_element.visibility = "show";
 }
 if (O_IE4) {
  ovar1.style.display = "none";
  ovar2.style.display = "block";
 }
}

function O_Pop2() {
 if (O_NS4) {
  ovar3_element = eval("document.ovar3");
  ovar3_element.visibility = "show";
 }
 if (O_IE4) {
  ovar3.style.display = "block";
 }
}

function O_Move(O_x) {
 if (O_x==1) {
 if(O_NS4) {
  with(document.ovar1){
   left = window.innerWidth - clip.width-35;
   top = window.innerHeight - clip.height-21+self.pageYOffset;
   }
 }
 if(O_IE4) {
  ovar1d=document.all('ovar1');
  with(document.body){
   ovar1d.style.left = clientWidth - scrollLeft-42;
   ovar1d.style.top = clientHeight + scrollTop-40;
  }
 }
 otimerID = setTimeout ("O_Move(1)", 100);
 }
 if(O_x==3){
  if(O_NS4) {
   with(document.ovar2){
    left = window.innerWidth - clip.width-36;
    top = window.innerHeight - clip.height-22+self.pageYOffset;
    }
   with(document.ovar3){
    left = window.innerWidth - clip.width-55;
    top = window.innerHeight - clip.height-22+self.pageYOffset;
   }
  }
  if(O_IE4) {
   ovar2d=document.all('ovar2');
   ovar3d=document.all('ovar3');
   with(document.body){
    ovar2d.style.left = clientWidth - scrollLeft-41;
    ovar2d.style.top = clientHeight + scrollTop-132;
    ovar3d.style.left = clientWidth - scrollLeft-161;
    ovar3d.style.top = clientHeight + scrollTop-132;
   }
  }
  otimerID = setTimeout ("O_Move(3)", 100);
 }
}

function O_GetData(label) {
 var labelLen = label.length;
 var cLen = document.cookie.length;
 var i=0;
 var cEnd;
 while (i < cLen) {
  var j= i + labelLen; 
  if (document.cookie.substring(i,j) == label) {
   cEnd = document.cookie.indexOf(";",j);
   if (cEnd == -1) cEnd = document.cookie.length;
   return unescape(document.cookie.substring(j+1,cEnd));
  }
  i++;
 }
 return "";
}

function O_SetData(name, value) {
 O_newdate=new Date( (new Date()).getTime() +O_tmoff );
 document.cookie=name+"="+escape(value)+"; path=/; expires="+O_newdate.toGMTString();
}

function O_Rdr(O_id) {
 ocDate2 = new Date();
 oend_date = ocDate2.getTime();
 if(O_id>0 && O_id <6) {
  O_SetData(O_Key, 2);
  if(O_NS4 || O_MAC){
   url = O_Url+"/rate.asp?rating="+O_id+"&time1=" + O_CDate+"&time2=" + oend_date + "&prev=" + escape(document.referrer) + "&referer=" + O_Key + "&height=" + height + "&width=" + width;
   window.location.href = url;
  }
  if(O_IE4 && !O_MAC){
   if( document.O_IEF==null ) return;
   O_final = 1;
   with( document.O_IEF.O_Frm ) {
    action=O_Url + "/rate.asp";
    method="post";
    rating.value=O_id;
    time1.value=O_CDate;
    time2.value=oend_date;
    prev.value=O_Prev;
    referer.value=window.location.href;
    height.value=screen.height;
    width.value=screen.width;
    submit();
    O_hideAll();
   }
  }
 }

 if (O_id == 6) {
  rdr_url = O_Url + "/about.asp";
  msgWindow=window.open(rdr_url,'OnlineOpinion','width=330,height=248,screenX='+((origWidth-330)/2)+',screenY='+((origHeight-248)/2)+',top='+((origHeight-248)/2)+',left='+((origWidth-330)/2));
 }

 if (O_id == 7) {
  O_SetData(O_Key, 2);
  myurl = O_impth+"comments_form.html?time1=" + O_CDate + "&time2=" + oend_date + "&prev=" + escape(document.referrer) + "&referer=" + O_Key + "&height=" + height + "&width=" + width;
  window.open(myurl,'Comments','width=330,height=318,screenX='+((origWidth-330)/2)+',screenY='+((origHeight-318)/2)+',top='+((origHeight-330)/2)+',left='+((origWidth-318)/2)+',copyhistory=yes');
  location.reload();
 }
}

function O_Over(image_num) {
 over_graphic = 1;
 s="im" + image_num;
 document[s].src = O_img[image_num+6].src;

 if (O_NS4) {
  ovar3_element = eval("document.ovar3");
  ovar3_element.visibility = "hide";
 }
 if (O_IE4) ovar3.style.display = "none";
 if (image_num != 6) O_Out(6);
 over_graphic = 1;
}

function O_Out(image_num) {
 O_layerOut();
 s="im" + image_num;
 document[s].src = O_img[image_num].src;
}

function O_layerOut() {
 over_graphic = 0; 
 setTimeout("O_layerTimeout();",50);
}

function O_layerTimeout() {
  if (over_graphic == 0) O_hideAll();
}

function O_hideAll() {
 over_graphic = 1;
 if (O_NS4) {
  ovar1_element = eval("document.ovar1");
  ovar1_element.visibility = "show";
  ovar2_element = eval("document.ovar2");
  ovar2_element.visibility = "hide";
  ovar3_element = eval("document.ovar3");
  ovar3_element.visibility = "hide";
 }
 if (O_IE4) {
  if (O_final) ovar1.style.display = "none";
  else ovar1.style.display = "block";
  ovar2.style.display = "none";
  ovar3.style.display = "none";
 }
}

function O_Resize(){
 if (O_NS4) {
  if (innerWidth == origWidth && innerHeight == origHeight) return;
  origWidth = innerWidth;
  origHeight = innerHeight;
   location.reload();
 }
 if (O_IE4) {
  if (document.body.clientWidth == origWidth && document.body.clientHeight
== origHeight) return;
  origWidth=document.body.clientWidth;
  origHeight=document.body.clientHeight;
  O_Move(1);
  O_Move(3);
 } 

}

function O_Go() {
 if (parseFloat(navigator.appVersion)<4 || (navigator.appName!="Microsoft Internet Explorer" && navigator.appName!="Netscape")) return;
if (O_MAC && O_IE4) return; 
 if (O_NS4) window.onresize=O_Resize;
 if (O_IE4) onresize=O_Resize;

 O_CTime=new Date();
 O_CDate=O_CTime.getTime();
 O_CData=O_GetData(O_Key);

 st="<STYLE TYPE='text/css'>";
 a1="show"; a2="none"; 
 if( O_CData==2 ) { a1="hide"; a2="none"; }
 if(O_NS4) st+=".oparent {position:absolute; visibility:"+a1+"; z-index:1000} .ochild {position:absolute; visibility:hide; z-index:1000}";
 if(O_IE4) st+=".oparent {display:"+a2+"; z-index:1000} .ochild {display:none; z-index:1000}";
 st+="</STYLE>";
 document.write(st); st="";

 if(O_CData==2) {
  st ="<DIV ID='ovar3' CLASS='ochild'></DIV><DIV ID='ovar2' CLASS='ochild'></DIV><DIV ID='ovar1' CLASS='oparent'></DIV>";
  document.write(st);
 }

 if(O_CData<1){
  O_img = new Array();
  for(i=1;i<17;i++) O_img[i]=new Image();
  for(i=1;i<6;i++) {O_img[i].src=O_impth+i+"up.gif";O_img[i+6].src=O_impth+i+"down.gif";}
  for(i=1;i<5;i++) O_img[i+12]=O_impth+"pop_"+i+".gif";
  O_img[6].src=O_impth+"quesup.gif";
  O_img[12].src=O_impth+"quesdown.gif";

    s1="<IMG SRC='"+O_impth+"pop.gif' WIDTH='121' HEIGHT='110' NAME='im' BORDER='0' USEMAP='#Map'><MAP NAME='Map'><AREA SHAPE='RECT' COORDS='0,0,121,72' HREF='#' onMouseOver='over_graphic=1;' onMouseOut='O_layerOut();'><AREA SHAPE='RECT' COORDS='0,72,121,90' HREF='#' onMouseOver='over_graphic=1;' onMouseOut='O_layerOut();' onClick='O_Rdr(7); return false;'><AREA SHAPE='RECT' COORDS='0,90,121,110' HREF='#'  onMouseOver='over_graphic=1;' onMouseOut='O_layerOut();' onClick='O_Rdr(6); return false;'></MAP>";
  st ="<DIV ID='ovar3' CLASS='ochild' STYLE='position:absolute;top:15%;left:95%;'>";
  st+="<TABLE CELLPADDING='0' CELLSPACING='0' BORDER='0'><TR><TD>";
  st+=s1+IEBR;
  st+="</TD></TR></TABLE></DIV>";
  document.write (st);

  s1="<A HREF='' onClick='O_Rdr(";
  s2="); return false;' onMouseOver='O_Over(";
  s3="); return true;' onMouseOut='O_Out(";
  s4="); return true;'><IMG BORDER='0' src='"+O_impth;
  s5="up.gif' NAME='im";
  st ="<DIV ID='ovar2' CLASS='ochild' STYLE='position:absolute;top:15%;left:95%;'><TABLE CELLPADDING='0' CELLSPACING='0' BORDER='0' WIDTH='19'><TR><TD>";
  st+=s1+"5"+s2+"5"+s3+"5"+s4+"5"+s5+"5' HEIGHT=18 WIDTH=19 ALT='Very Positive'></A>"+IEBR;
  st+=s1+"4"+s2+"4"+s3+"4"+s4+"4"+s5+"4' HEIGHT=18 WIDTH=19 ALT='Positive'></A>"+IEBR;
  st+=s1+"3"+s2+"3"+s3+"3"+s4+"3"+s5+"3' HEIGHT=18 WIDTH=19 ALT='Neutral'></A>"+IEBR;
  st+=s1+"2"+s2+"2"+s3+"2"+s4+"2"+s5+"2' HEIGHT=18 WIDTH=19 ALT='Negative'></A>"+IEBR;
  st+=s1+"1"+s2+"1"+s3+"1"+s4+"1"+s5+"1' HEIGHT=21 WIDTH=19 ALT='Very Negative'></A>"+IEBR;
  st+="<A HREF='#' onMouseOver='O_Over(6); O_Pop2(); return true;'  onMouseOut='O_layerOut();' onClick='O_Rdr(6); return false;'>";
  st+="<IMG src='"+O_impth+"quesup.gif' NAME='im6' HEIGHT=17 WIDTH=19 ALT='Questions About OnlineOpinion?' BORDER='0'></A></TD></TR></TABLE></DIV>";
  document.write (st); st="";

  st ="<DIV ID='ovar1' CLASS='oparent' STYLE='position:absolute;top:15%;left:95%;'>";
  st+="<A HREF='#' onMouseOver='O_Pop1();'><IMG src='"+O_impth+"o.gif' ALT='O' BORDER='0' onLoad=O_setTimer();></A></DIV>";
  document.write (st);

  O_Move(1);
  O_Move(3);

  if(O_IE4 && !O_MAC) document.write("<div id='ifrm' style='position:absolute:15%;left:95%'><iframe name='O_IEF' src='"+O_impth+"o_ief.html' width=0 height=0 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=no></iframe></div>");
 }
}

