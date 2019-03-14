var myLayout;

$(document).ready(function () {
    myLayout = $('body').layout(innerLayout_settings);
    $('.submenu').hide();
    var settings = { header: '.mainmenuheader', content: '.submenu' }
    ddacord(settings);
    activeMenu();
});
		
$(document).bind('open-all-panels', function(){
	myLayout.open('north');
	myLayout.open('west');
	myLayout.open('south');
});
		
$(document).bind('close-all-panels', function(){
	myLayout.close('north');
	myLayout.close('west');
	myLayout.close('south');
	
	myLayout.sizePane('north','0');
	myLayout.sizePane('west','0');
	myLayout.sizePane('south','0');
	
});
        
outerLayout_settings = { 
	north__resizable:		false
	,north__size:			48
	,north__spacing_closed:	0			    // HIDE resizer & toggler when 'closed'
	,north__spacing_open:	0			    // HIDE resizer & toggler when 'open'
	,initClosed:			false
	,fxSpeed_close:         'normal'
	,fxSpeed_open:          'normal'
	,fxName:				"drop"          // con fxname y fxSettings se le dice que haga el efecto de desaparecer
	,fxSettings:			{ easing: "" }  // nullify default easing
}; 
	    
innerLayout_settings = {	 
	resizeWithWindow:		true 
    ,north__resizable:		false
	,south__resizable:		false  
	,west__resizable:		false 
	,west__spacing_closed:	13			    // wider space when closed
	,west__spacing_open:	13			    // wider space when open    
	,north__spacing_closed:	10			    // wider space when closed
	,north__spacing_open:	10			    // wider space when open 
	,south__spacing_closed:	13			    // wider space when closed
	,south__spacing_open:	13			    // wider space when open 
	,north__size:			43
	,south__size:			22			
	,west__size:			140		
	,maskIframesOnResize:   true	
	,slideTrigger_open:     'mouseover'
	,resizerClass:			"contentseparacion"
	,togglerClass:			"contenttoggler"
	,fxSpeed_close:         'normal'
	,fxSpeed_open:          'normal'
	,fxName:				"drop"          //con fxname y fxSettings se le dice que haga el efecto de desaparecer*/
	,fxSettings:			{ easing: "" }  // nullify default easing
};

function ddacord(s)
{
$(s.header).click(function (e) {e.preventDefault();

$(s.content).hide();
$(this).find(s.content).show();

});

}

function activeMenu() {
    $(".menu-item").click(function (e) {
        $(".menu-item").parent().removeClass("active");
        $(this).parent().addClass("active");
    }
    );
}





/*ddaccordion.init({
	headerclass: "submenuheader", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 100, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	animatespeed: "normal", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})*/