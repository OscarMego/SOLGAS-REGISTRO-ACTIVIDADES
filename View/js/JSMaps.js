var r=0;
var offset = { 'dashed': 0, 'dotted': 0 };
var markers = new Array();
var routes;
var polyline;
var infowindows = new Array();
var infowindow = new Array();
var setZoomPoints = true;
var map;
var newShape;
var markerCliente;
var circulo;

function initialize(lat,lng)
 {
    var latlng = new google.maps.LatLng(lat,lng);
    var myOptions = {
        navigationControl: true,
        mapTypeControl: true,
        mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
        scaleControl: true,
        zoom: 12,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };


    map = new google.maps.Map(document.getElementById("map"), myOptions);

    routes = new google.maps.MVCArray();
    polyline = new google.maps.Polyline({

    map: map
    , strokeColor: '#ff0000'
    , strokeWeight: 3
    , strokeOpacity: 0.2
    , clickable: false
    , icons: [{ icon: { path: 'M 0,-2 0,2', strokeColor: 'ff0000', strokeOpacity: 0.6, }, repeat: '25px' }]
    ,path: routes
    });
    
    google.maps.event.addListener(map, 'click', function(){
        for (var i = 0; i < infowindow.length-1; i++) {
            infowindow[i].close();
        }
    });
}

function initializeClienteRadio(lat, lng, rad)
{
    initializeCliente(lat, lng);
        circulo = new google.maps.Circle({
            map: map,
            radius: parseFloat(rad),
            strokeColor: '#FF960D',
            strokeWeight: 2,
            fillColor: '#FFED85',
            fillOpacity: 0.2,
            editable: true
        });

        circulo.bindTo('center', markerCliente, 'position');
        
        google.maps.event.addListener(circulo, "radius_changed", function () {
            //cambio el radio
            if (circulo.getRadius() > 999999) circulo.setRadius(999999);

            $('#MtxtRadio').val(circulo.getRadius().toString());
        });
}
  
function initializeCliente(lat,lng)
{
 var latlng = new google.maps.LatLng(lat,lng);
 var myOptions = {
        navigationControl: true,
        mapTypeControl: true,
        mapTypeControlOptions: {
            position: google.maps.ControlPosition.TOP_LEFT,
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        },
        scaleControl: true,
        zoom: 12,
        center: latlng,
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.LARGE,
            position: google.maps.ControlPosition.RIGHT_BOTTOM
        },
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map"), myOptions);

    markerCliente= new google.maps.Marker({
			draggable: true,
			animation: google.maps.Animation.DROP,
			position: latlng,
			title: 'Punto',
            icon: '../../imagery/all/icons/punto.png'
			});

            markerCliente.setMap(map);

    //CLICK
    google.maps.event.addListener(map, "click", function(event) {

		oldMarker = markerCliente;
		markerCliente.setPosition(event.latLng);
		map.setCenter(event.latLng);
		$('#MtxtLatitud').val(markerCliente.getPosition().lat().toString());	
        $('#MtxtLongitud').val(markerCliente.getPosition().lng().toString());	
    });
    
    //DRAG
	google.maps.event.addListener(markerCliente, "dragend", function(marker){
		var latLng = marker.latLng;
        $('#MtxtLatitud').val(latLng.lat());	
        $('#MtxtLongitud').val(latLng.lng());
		map.setCenter(latLng);
	});

    //DIRECCION	
	var input = (document.getElementById('address'));
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	var autocomplete = new google.maps.places.Autocomplete(input);
	autocomplete.bindTo('bounds', map);

	google.maps.event.addListener(autocomplete, "place_changed", function () {
	    var place = autocomplete.getPlace();
	    if (!place.geometry) {
		    return;
	    }

	    // If the place has a geometry, then present it on a map.
	    if (place.geometry.viewport) {
		    map.fitBounds(place.geometry.viewport);

	    } else {
		    map.setCenter(place.geometry.location);
		    map.setZoom(17);  // Why 17? Because it looks good.
	    }
				
	    markerCliente.setPosition(place.geometry.location);
			
	    var address = '';
	    if (place.address_components) {
		    address = [
		    (place.address_components[0] && place.address_components[0].short_name || ''),
		    (place.address_components[1] && place.address_components[1].short_name || ''),
		    (place.address_components[2] && place.address_components[2].short_name || '')
		    ].join(' ');
	    }

		$('#MtxtLatitud').val(place.geometry.location.lat());	
        $('#MtxtLongitud').val(place.geometry.location.lng());	
	});

	$("#MtxtLatitud" ).keyup(function( event ) {
        if($('#MtxtLatitud').val()!='')
        {
        markerCliente.setVisible(true);
        markerCliente.setPosition(new google.maps.LatLng($('#MtxtLatitud').val(),$('#MtxtLongitud').val()));
        map.setCenter(new google.maps.LatLng($('#MtxtLatitud').val(),$('#MtxtLongitud').val()));
        }
        if($('#MtxtLatitud').val()=='' && $('#MtxtLongitud').val()==''){
        markerCliente.setVisible(false);
        }
        })
     
        $("#MtxtLongitud" ).keyup(function( event ) {
        if($('#MtxtLongitud').val()!='')
        {
        markerCliente.setVisible(true);
        markerCliente.setPosition(new google.maps.LatLng($('#MtxtLatitud').val(),$('#MtxtLongitud').val()));
        map.setCenter(new google.maps.LatLng($('#MtxtLatitud').val(),$('#MtxtLongitud').val()));
        }
        if($('#MtxtLatitud').val()=='' && $('#MtxtLongitud').val()==''){
        markerCliente.setVisible(false);
        }
    });

}

function cargaPoints(urlM,polilyne)
{ 
   deleteMarker(); 
   
   $.ajax({
            type: 'POST',
            url: urlM,
            data:JSON.stringify(getData()),
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            dataType: "json",
           
            success: function (data) {
              
              
              $.each(jQuery.parseJSON(data.d), function(index, objPoint) {
                crearPoint(objPoint,jQuery.parseJSON(data.d));
                
              });
              setTimeout(function(){
              map.setCenter(setZoom());},1000);


            },
            
            error: function (xhr, status, error) {
              
            }
        }); 
        
     
}

function cargaPointsUlt(urlM,polilyne)
{ 
   deleteMarker(); 
   
   $.ajax({
            type: 'POST',
            url: urlM,
            data:JSON.stringify(getData()),
            contentType: "application/json; charset=utf-8",
            async: true,
            cache: false,
            dataType: "json",
            beforeSend: function () {

                $(".form-gridview-search").show();
            },
            success: function (data) {
              
               $(".form-gridview-search").hide();
               if(jQuery.parseJSON(data.d).length>0)
               {
                  $.each(jQuery.parseJSON(data.d), function(index, objPoint) {
                  if(objPoint.latitud!="0.0")
                  {
                    crearPoint(objPoint,jQuery.parseJSON(data.d));
                  }
                
                  });
                  setTimeout(function(){
                  map.setCenter(setZoom());},1000);

              }
              else
               {
                   addnotify("notify", "No existen puntos", "divError");
              }

            },
            
            error: function (xhr, status, error) {
                $("#myModal").html(alertHtml('error', xhr.responseText));
                $('#myModal').modal('show');
            }
        }); 
        
     
}

  
  
function crearPoint(objPoint,Data)
{
    addMarker(objPoint.latitud,objPoint.longitud,objPoint.msg,objPoint.img,Data);
}

function deleteMarker() {

if (markersArray.length>0) {
    for (var i= 0;i < markersArray.length; i++) {

         markersArray[i].setMap(null);
    }
    
    routes = new google.maps.MVCArray();
    polyline.setPath(routes);
    markersArray.length = 0;
    infowindow= new Array();
    
    }
}


function addMarker(lat,lng,info,image,obj) {


    var repetidos = new Array(); 
    var newLocation = new google.maps.LatLng(lat, lng);
    var marker = new google.maps.Marker({
        icon:image,
        position: newLocation,
        animation: google.maps.Animation.DROP,
        map: map});

    markersArray.push(marker);

    markers[r++]=marker;
    map.setCenter(newLocation);
    var text = info ;
    var infowindow = new google.maps.InfoWindow({ content: text });
    repetidos = buscarRepetidos(lat,lng,obj)

    if(repetidos.length > 1 ){        
            var inf = infowindowsRep(repetidos, obj);        
            infowindow = new google.maps.InfoWindow({ content: inf });   
    }
    infowindows.push(infowindow);
    console.log(infowindows);
    google.maps.event.addListener(marker, 'click', function() {
        for (var i = 0; i < infowindows.length - 1; i++) {
            infowindows[i].close();
            console.log(infowindows[i]);
        }
        infowindow.open(map, marker);
        //if (boolInfoGrid) {
        //    infowindow.marker = marker;
        //    viewInfoWindows(infowindow, marker.position.lat(), marker.position.lng());
        //}
    });
    
}


function addPolilyne(lat,lng) {
    var newLocation = new google.maps.LatLng(lat, lng);
    map.setCenter(newLocation);
    routes.push(newLocation);
    polyline.setPath(routes);
    polylineTimer = setInterval(function () { animateDashed(); }, 200);

}

function buscarRepetidos(lat,lon, data){
    var arregloPuntosRepetidos = new Array(); 
    var j = 0;  
    $.each(data, function(index, objPoint) {
        if(lat==objPoint.latitud && lon== objPoint.longitud)
        {
         arregloPuntosRepetidos[j++] = index;
        }
    });
    
    
    return arregloPuntosRepetidos; 
}

function infowindowsRep(arrRep, data)
{

    var infow = ""; 
    setdataIw(data);
    infow += "<table  cellpadding='0'height='100%' align='center'><thead><tr><th>Puntos</th></tr></thead><tbody>";
    for(i=0; i < arrRep.length; i++)
    {
        var sec = arrRep[i];
         infow += "<tr><td>";
         infow += "<a href='javascript:markerRept("+  sec  +");'>"+ data[sec].titulo +"</a></td></tr>"
    }

    infow += "</tbody></table>";     
    return infow;
}



function markerRept(sec){
    var dato = new Array();
    dato = getDataIw();
    var mnsg = dato[sec].msg;   
    var lalo = new google.maps.LatLng(dato[sec].latitud, dato[sec].longitud);    
    var infowindow;  
    infowindow = new google.maps.InfoWindow({ content: mnsg  });
    infowindow.open(map,markers[sec]);
       
}

	

function setZoom() {
    
   //var boundbox = new google.maps.LatLngBounds();
    
   for ( var i = 0; i < markersArray.length; i++ ){
        map.setCenter(new google.maps.LatLng(markersArray[i].position.lat(), markersArray[i].position.lng()));
        //boundbox.extend(new google.maps.LatLng(markersArray[i].position.lat(),markersArray[i].position.lng()));
        }
   // map.fitBounds(boundbox);
   //return boundbox.getCenter();
 }




 
var datosIW;
function setdataIw(obj){
    datosIW =  obj;
    
}
function getDataIw(){
return datosIW;
} 



function animateDashed() {
    if (offset['dashed'] > 23) {
      offset['dashed'] = 0;
    } else {
      offset['dashed'] += 2;
    }
    var icons = polyline.get('icons');
    icons[0].offset = offset['dashed'] + 'px';
    polyline.set('icons', icons); 
    
    
}


function resizeMapModal() { 
	var center = map.getCenter(); 
	google.maps.event.trigger(map, "resize"); 
	map.setCenter(center); 
}



function drawPolygon(poly) {
    
   
     polygonOptions = {
            paths: poly,
            fillColor: '#AA2143',
            fillOpacity:0.7,
            strokeColor: '#FF6600',
            strokeWeight:2,
            clickable:true,
            zIndex: 1,
            editable: false};

        newShape = new google.maps.Polygon(polygonOptions);
        newShape.setMap(map);

       
        
 
}
function viewInfoWindows(infowindow, lat, lng) {//, precision
    Str = new Object();
    Str.lat = lat;
    Str.lon = lng;

    //mostrarRadio(precision, lat, lng);

    $.ajax({
        type: 'POST',
        url: urlLoadInfo,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(getInfo()),
        success: function (data) {
            infowindow.setContent(data.d);

            //if ($('.dirOnline').html() != null) {
            //    $.ajax({
            //        type: 'POST',
            //        url: UrlDireccion,
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        async: true,
            //        cache: false,
            //        data: JSON.stringify(Str),
            //        success: function (data) {
            //            $('.dirOnline').html(data.d);
            //        },
            //        error: function (xhr, status, error) {
            //            // addnotify("notify", xhr.responseText, "registeruser");
            //        }

            //    });
            //}

            //if ($('.envSMSModal').html() != null) {

            //    $('.envSMSModal').click(function (e) {

            //        StrdataS = new Object();
            //        StrdataS.codigo = $(this).attr('cod');
            //        StrdataS.nextel = $(this).attr('nxt');
            //        e.preventDefault();
            //        $.ajax({
            //            type: 'POST',
            //            url: UrlSMS,
            //            async: true,
            //            cache: false,
            //            data: JSON.stringify(StrdataS),
            //            success: function (data) {
            //                $("#myModal").html(data);
            //                $('#myModal').modal('show');


            //            },
            //            error: function (xhr, status, error) {
            //                // addnotify("notify", xhr.responseText, "registeruser");
            //            }

            //        });
            //    });
            //}
        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseText, "registeruser");
        }

    });
}
