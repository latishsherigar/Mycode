
// alert("uplevel_js Start");

function gsfxUpLevel()
{
	window.onresize = gsfxUplevelResize;
	gsfxUplevelResize();
}

function flyout_onwindowresize_hookup(){} //see common/script/gsfx/flyout-rtl.htc

function gsfxUplevelResize()
{
	var FlyoutMenu = document.getElementById("idFlyoutMenu");
	var Toolbar = document.getElementById("idToolbar");
	var TopPanel = document.getElementById("TopPanel");
	var Toolbar = document.getElementById("idToolbar");
	var MSMenu = document.getElementById("idMSMenuPane");
	var ToolbarSpacer = document.getElementById("idSpace1");
	var BannerPanel = document.getElementById("BannerPanel");
	var Center = document.getElementById("CenterPanel");
	var Bottom = document.getElementById("BottomPanel");
	
	if(FlyoutMenu){ flyout_onwindowresize_hookup(); }
	
	if(navigator.userAgent.indexOf("Gecko") < 0) {
		if(TopPanel) {
				var available = document.body.clientHeight;
				var used=0;
				if (Toolbar) used = used + Toolbar.clientHeight;
				if (Bottom)  used = used + Bottom.clientHeight;
				if (BannerPanel) used = used + BannerPanel.clientHeight;
				Center.style.height = Math.max(available, used) - used;
				if(MSMenu) resizeToolbar();
		}
		// adjust banner and footer width
		if(BannerPanel) {
			BannerPanel.style.width = Center.clientWidth;
		}
		if(Bottom) {
			Bottom.style.width = Center.clientWidth;
		}
	} else {
		if(TopPanel) {
				var available = window.innerHeight;
				var used=0;
				if (TopPanel) used = used + TopPanel.offsetHeight;
				if (Bottom)  used = used + Bottom.offsetHeight;
				if (BannerPanel) used = used + BannerPanel.offsetHeight;
				Center.style.height = Math.max(available, used) - used;
			//	resizeToolbar();
		}
		
		// adjust banner and footer width
/*		if(BannerPanel) {
			BannerPanel.style.width = Center.offsetWidth;
		}
		if(Bottom) {
			Bottom.style.width = Center.offsetWidth;
		}
*/	
	}
	// if search is there, call it's resize  event as well.
	if(document.calcsearchdivsizes) {
		document.calcsearchdivsizes();
	}

}