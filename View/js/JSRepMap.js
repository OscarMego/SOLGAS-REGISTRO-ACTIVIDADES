//var globales
var colores = ["#FF0000", "#00FF00", "#0000FF", "#00FFFF", "#FF00FF", "#FFFF00", "#7F0000", "#007F00", "#00007F", "#007F7F", "#7F007F", "#7F7F00", "#7F00FF", "#007FFF", "#FF7F00", "#00FF7F", "#FF007F", "#7FFF00", "#FEFF90", "#7E0090", "#000000", "#FFFFFF", "#888888"];

var map;
var dataMapa;
var infowindows = new Array();
var infowindowsRepArr = new Array();
var routes;
var polyline;
var points;
var Timer;
var setZoomPoints = true;
var geocoder;
var mapD;
var radio;
var Circles = new Array();

//mapa

function CenterControl(controlDiv, map) {
    var contentString = 'Dependiendo de las condiciones de captura, puede ser que algunas posiciones presenten una imprecisión de hasta 1 KM.';

    // Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.marginBottom = '12px';
    controlUI.style.textAlign = 'center';
    controlUI.style.marginRight = '50px';
    controlUI.title = contentString;
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior.
    var controlText = document.createElement('div');
    controlText.style.color = 'rgb(25,25,25)';
    controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlText.style.fontSize = '16px';
    controlText.style.lineHeight = '14px';
    controlText.style.paddingLeft = '5px';
    controlText.style.paddingRight = '5px';
    controlText.innerHTML = '?';
    controlUI.appendChild(controlText);
}

function setAdvertencia() {
    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map);

    centerControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.RIGHT_TOP].push(centerControlDiv);
}

function initialize(lat, lng) {
    var infowindows = new Array();
    var infowindowsRepArr = new Array();

    var latlng = new google.maps.LatLng(lat, lng);
    var myOptions = {
        navigationControl: true,
        mapTypeControl: true,
        mapTypeControlOptions: { style: google.maps.MapTypeControlStyle.DROPDOWN_MENU },
        scaleControl: true,
        zoom: 12,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map"), myOptions);

    setAdvertencia();
}



function initializeCliente(lat, lng) {

    var latlng = new google.maps.LatLng(lat, lng);
    var myOptions = {
        navigationControl: true,
        mapTypeControl: true,
        mapTypeControlOptions: { style: google.maps.MapTypeControlStyle.DROPDOWN_MENU },
        scaleControl: true,
        zoom: 12,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    geocoder = new google.maps.Geocoder();
    mapD = new google.maps.Map(document.getElementById("mapdiv"), myOptions);

    markerCliente = new google.maps.Marker({
        draggable: true,
        animation: google.maps.Animation.DROP,
        position: latlng,
        title: 'Punto',
        icon: '../../imagery/all/icons/punto.png'
    });

    markerCliente.setMap(mapD);
    google.maps.event.addListener(markerCliente, 'drag', function () {

        $('#hLatitud').val(markerCliente.getPosition().lat().toString());
        $('#hLongitud').val(markerCliente.getPosition().lng().toString());


    });

    google.maps.event.addListener(markerCliente, 'dragend', function () {
        //updateMarkerStatus('Arraste finalizado');
        //	geocodePosition(markerCli.getPosition(), markerArr[MapDiv].eolDireccion);
    });


    var input = (document.getElementById('dvAddress'));
    mapD.controls[google.maps.ControlPosition.TOP_CENTER].push(input);

    $('.btnDireccion').click(function (e) {
        var address = $('#address').val();

        var geocoder = new google.maps.Geocoder();

        geocoder.geocode({ 'address': address }, geocodeResult);
    });

}



function geocodeResult(results, status) {
    // Verificamos el estatus
    if (status == 'OK') {


        mapD.setCenter(results[0].geometry.location);
        mapD.fitBounds(results[0].geometry.viewport);

        markerCliente.setPosition(results[0].geometry.location);


    } else {
        addnotify("notify", "Geocoding no tuvo éxito debido a: " + status, "registeruser");

    }
}

function addPolilyne(latlng, color) {
    //  var mycolor = colores[color];
        points.push(latlng);
        var polyline2 = new google.maps.Polyline({
            path: points,
            strokeColor: color,
            strokeWeight: 2,
            strokeOpacity: 0.7,
            clickable: false,
            icons: [{ icon: { path: google.maps.SymbolPath.FORWARD_OPEN_ARROW, strokeWeight: 2, strokeColor: color, strokeOpacity: 0.7 }, offset: '100%' }]

        });
        polyline2.setMap(map);
    
    PolyArray.push(polyline2);
}


function addPolygon(Polygon, points, nombre) {
    polygonOptions = {
        paths: points,
        fillColor: '#AA2143',
        fillOpacity: 0.25,
        strokeColor: '#FF6600',
        strokeWeight: 2,
        clickable: true,
        zIndex: 1,
        editable: false,
        title: nombre
    };

    newShape = new google.maps.Polygon(polygonOptions);
    newShape.setMap(map);
    var geoinfowindow;
    var geoinfowindows = [];
    var timerHandle;

    google.maps.event.addListener(newShape, 'mouseover', function () {
        this.getMap().getDiv().setAttribute('title', this.get('title'));
    });
    google.maps.event.addListener(newShape, 'mouseout', function () {
        this.getMap().getDiv().removeAttribute('title');
    });
    /*
    google.maps.event.addListener(newShape, "mouseover", function (event) {
        geoinfowindow = new google.maps.InfoWindow();
        geoinfowindow.setContent("<p>" + nombre + "</p>");
        geoinfowindow.setPosition(event.latLng);
        timerHandle = setTimeout(function () {
            for (var i=0; i<geoinfowindows.length; i++){
                geoinfowindows[i].close();
                geoinfowindows[i].setMap(null);
            }
            geoinfowindow.open(map);
            geoinfowindows.push(geoinfowindow)
        }, 500);
    });
    google.maps.event.addListener(newShape, "mouseout", function (event) {
        if (timerHandle) {
            clearTimeout(timerHandle);
            timerHandle = 0;
        }
        for (var i = 0; i < geoinfowindows.length; i++) {
            geoinfowindows[i].close();
            geoinfowindows[i].setMap(null);
        }
    });
    */
    Polygon.push(newShape);
}

function addMarker(Marker, lat, lng, info, image, precision, titulo, sec) {
    var newLocation = new google.maps.LatLng(lat, lng);
    var marker = new google.maps.Marker({
        icon: image,
        position: newLocation,
        map: map,
        title: titulo,
        zIndex: parseInt(sec) * -1
    });

    Marker.push(marker);

    var infowindow = new google.maps.InfoWindow({ content: info });

    var repetidos = new Array();
    var boolrepetidos = false;
    repetidos = buscarRepetidos(lat, lng);

    //if (repetidos.length > 1) {
    //    var inf = infowindowsRep(repetidos);
    //    infowindow = new google.maps.InfoWindow({ content: inf });
    //    boolrepetidos = true;
    //}
    infowindows.push(infowindow);

    google.maps.event.addListener(marker, 'click', function () {
        for (var i = 0; i < infowindows.length; i++) {
            infowindows[i].close();
        }

        for (var i = 0; i < infowindowsRepArr.length; i++) {
            infowindowsRepArr[i].close();
        }

        infowindow.open(map, marker);
        //if (!boolrepetidos) {
            infowindow.marker = marker;
            viewInfoWindows(infowindow, marker.position.lat(), marker.position.lng(), precision);
        //}

    });
}

function addMarkerSimple(Marker, lat, lng, info, image, titulo, radio, color) {

    var newLocation = new google.maps.LatLng(lat, lng);
    var marker = new google.maps.Marker({
        icon: image,
        position: newLocation,
        map: map,
        title: titulo,
        zIndex : -9999999
    });

    colorBorde = aclararColor(color, 10);
    radio = parseFloat(radio);
    circulo = new google.maps.Circle({
        map: map,
        radius: radio,
        strokeColor: '#' + colorBorde,
        strokeWeight: 2,
        fillColor: '#' + color,
        fillOpacity: 0.2,
        title: titulo
    });
    circulo.bindTo('center', marker, 'position');
    
    google.maps.event.addListener(circulo, 'mouseover', function () {
        this.getMap().getDiv().setAttribute('title', this.get('title'));
    });
    google.maps.event.addListener(circulo, 'mouseout', function () {
        this.getMap().getDiv().removeAttribute('title');
    });

    Circles.push(circulo);
    Marker.push(marker);

    var infowindow = new google.maps.InfoWindow({ content: info });


    google.maps.event.addListener(marker, 'click', function () {
        infowindow.open(map, marker);

    });
}

function aclararColor(color, porcentaje) {
    var num = parseInt(color, 16),
    amt = Math.round(2.55 * porcentaje),
    R = (num >> 16) + amt,
    G = (num >> 8 & 0x00FF) + amt,
    B = (num & 0x0000FF) + amt;
    return (0x1000000 + (R < 255 ? R < 1 ? 0 : R : 255) * 0x10000 + (G < 255 ? G < 1 ? 0 : G : 255) * 0x100 + (B < 255 ? B < 1 ? 0 : B : 255)).toString(16).slice(1);
}

function mostrarRadio(precision, latitud, longitud) {
    borrarRadios();

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ARAD').attr('checked')){
        precision = parseInt(precision);
        radio = new google.maps.Circle({
            map: map,
            radius: precision,
            strokeColor: '#431EFA',
            strokeWeight: 2,
            fillColor: '#8EAFFA',
            fillOpacity: 0.2,
            center: new google.maps.LatLng(latitud, longitud)
        });

        google.maps.event.addListener(radio, 'click', function () {
            borrarRadios();
        });
    }
}

function borrarRadios() {
    if (radio != null) {
        radio.setMap(null);
    }
}

function viewInfoWindows(infowindow, lat, lng, precision) {
    Str = new Object();
    Str.lat = lat;
    Str.lon = lng;

    mostrarRadio(precision, lat, lng);

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

            if ($('.dirOnline').html() != null) {
                $.ajax({
                    type: 'POST',
                    url: UrlDireccion,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(Str),
                    success: function (data) {
                        $('.dirOnline').html(data.d);
                    },
                    error: function (xhr, status, error) {
                        // addnotify("notify", xhr.responseText, "registeruser");
                    }

                });
            }

            if ($('.envSMSModal').html() != null) {

                $('.envSMSModal').click(function (e) {

                    StrdataS = new Object();
                    StrdataS.codigo = $(this).attr('cod');
                    StrdataS.nextel = $(this).attr('nxt');
                    e.preventDefault();
                    $.ajax({
                        type: 'POST',
                        url: UrlSMS,
                        async: true,
                        cache: false,
                        data: JSON.stringify(StrdataS),
                        success: function (data) {
                            $("#myModal").html(data);
                            $('#myModal').modal('show');


                        },
                        error: function (xhr, status, error) {
                            // addnotify("notify", xhr.responseText, "registeruser");
                        }

                    });
                });
            }





        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseText, "registeruser");
        }

    });
}

function deleteCircle(Circles){
    if (Circles.length > 0) {
        for (var i = 0; i < Circles.length; i++) {
            Circles[i].setMap(null);
        }
        while (Circles.length > 0) {
            Circles.pop();
        }
    }
}

function deleteMarker(Marker) {

    if (Marker.length > 0) {
        for (var i = 0; i < Marker.length; i++) {

            Marker[i].setMap(null);
        }

        while (Marker.length > 0) {
            Marker.pop();
        }
        while (infowindows.length > 0) {
            infowindows.pop();
        }
        while (infowindowsRepArr.length > 0) {
            infowindowsRepArr.pop();
        }

    }
}


function deletePolyline(PolyArray) {
    if (PolyArray.length > 0) {
        for (var i = 0; i < PolyArray.length; i++) {

            PolyArray[i].setMap(null);

        }
        while (PolyArray.length > 0) {
            PolyArray.pop();
        }
    }
}

function deletePolygon(PolygonArray) {
    if (PolygonArray.length > 0) {
        for (var i = 0; i < PolygonArray.length; i++) {

            PolygonArray[i].setMap(null);

        }
        while (PolygonArray.length > 0) {
            PolygonArray.pop();
        }
    }
}

/*repetidos*/
function buscarRepetidos(lat, lon) {
    var arregloPuntosRepetidos = new Array();
    var j = 0;
    $.each(dataMapa, function (index, objPoint) {
        if (lat == objPoint.latitud && lon == objPoint.longitud) {
            arregloPuntosRepetidos[j++] = index;
        }
    });


    return arregloPuntosRepetidos;
}




function infowindowsRep(arrRep) {

    var infow = "";

    infow += "<table  cellpadding='0'height='100%' align='center'><thead><tr><th>Puntos</th></tr></thead><tbody>";
    for (i = 0; i < arrRep.length; i++) {
        var sec = arrRep[i];
        infow += "<tr><td>";
        infow += "<a href='javascript:markerRept(" + dataMapa[sec].idCorrelativo + "," + dataMapa[sec].precision + ");'>" + dataMapa[sec].titulo + "</a></td></tr>"
    }

    infow += "</tbody></table>";
    return infow;
}


function markerRept(sec, precision) {

    var punto = $.grep(dataMapa, function (e) { return e.idCorrelativo == sec })[0];
    var mnsg = punto.msg;
    /*dataMapa[sec].msg;*/
    var infowindow;
    infowindow = new google.maps.InfoWindow({ content: mnsg });
    infowindowsRepArr.push(infowindow);
    for (var i = 0; i < infowindowsRepArr.length; i++) {
        infowindowsRepArr[i].close();
    }
    for (var i = 0; i < infowindows.length; i++) {
        infowindows[i].close();
    }
    //infowindow.marker = MarkerPosition[sec];
    //infowindow.open(map, MarkerPosition[sec]);
    //map.setCenter(MarkerPosition[sec - 1].position);

    var marker = $.grep(MarkerPosition, function (e) { return (e.zIndex * -1) == sec })[0];
    infowindow.marker = marker;
    infowindow.open(map, marker);
    map.setCenter(marker.position);
    //infowindow.setPosition(punto.latitud, punto.longitud);
    //infowindow.open(map);
    //map.setCenter((new google.maps.LatLng(punto.latitud, punto.longitud)));
    viewInfoWindows(infowindow, punto.latitud, punto.longitud, precision);
}


function setZoom(markersArray) {

    var boundbox = new google.maps.LatLngBounds();

    for (var i = 0; i < markersArray.length; i++) {
        boundbox.extend(new google.maps.LatLng(markersArray[i].position.lat(), markersArray[i].position.lng()));
    }
    map.fitBounds(boundbox);
    return boundbox.getCenter();
}




/*RULER MAPS V3*/
function addruler(image) {

    var ruler1 = new google.maps.Marker({
        position: map.getCenter(),
        map: map,
        draggable: true,
        icon: image,
        animation: google.maps.Animation.DROP,
        title: 'Arrastre para ver la distancia, haga doble click para eliminar.'
    });

    var ruler2 = new google.maps.Marker({
        position: map.getCenter(),
        map: map,
        draggable: true,
        icon: image,
        animation: google.maps.Animation.DROP,
        title: 'Arrastre para ver la distancia, haga doble click para eliminar.'
    });

    var ruler1label = new Label({ map: map });
    var ruler2label = new Label({ map: map });
    ruler1label.bindTo('position', ruler1, 'position');
    ruler2label.bindTo('position', ruler2, 'position');

    var rulerpoly = new google.maps.Polyline({
        path: [ruler1.position, ruler2.position],
        strokeColor: "#FFFF00",
        strokeOpacity: .7,
        strokeWeight: 7
    });
    rulerpoly.setMap(map);

    ruler1label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));
    ruler2label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));


    google.maps.event.addListener(ruler1, 'drag', function () {
        rulerpoly.setPath([ruler1.getPosition(), ruler2.getPosition()]);
        ruler1label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));
        ruler2label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));
    });

    google.maps.event.addListener(ruler2, 'drag', function () {
        rulerpoly.setPath([ruler1.getPosition(), ruler2.getPosition()]);
        ruler1label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));
        ruler2label.set('text', distance(ruler1.getPosition().lat(), ruler1.getPosition().lng(), ruler2.getPosition().lat(), ruler2.getPosition().lng()));
    });

    google.maps.event.addListener(ruler1, 'dblclick', function () {
        ruler1.setMap(null);
        ruler2.setMap(null);
        ruler1label.setMap(null);
        ruler2label.setMap(null);
        rulerpoly.setMap(null);
    });

    google.maps.event.addListener(ruler2, 'dblclick', function () {
        ruler1.setMap(null);
        ruler2.setMap(null);
        ruler1label.setMap(null);
        ruler2label.setMap(null);
        rulerpoly.setMap(null);
    });

}


function distance(lat1, lon1, lat2, lon2) {
    var R = 6371; // km (change this constant to get miles)
    var dLat = (lat2 - lat1) * Math.PI / 180;
    var dLon = (lon2 - lon1) * Math.PI / 180;
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
		Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    if (d > 1) return Math.round(d) + "km";
    else if (d <= 1) return Math.round(d * 1000) + "m";
    return d;
}



//design
function MaxMin() {
    $("#expCon").click(function () {

        if ($(this).hasClass('cz-expand')) {
            $("#resizableBottom").animate({ top: ((0 - $('#centerFrame', window.parent.document).height())) + "px", height: ($('#centerFrame', window.parent.document).height()) + "px" });
            $(this).addClass('cz-contract').removeClass('cz-expand');
            $('.gridview').animate({ height: ($('#centerFrame', window.parent.document).height() - 15) + "px" });
        }

        else {
            $("#resizableBottom").animate({ top: '-18px', height: '18px' })
            $(this).addClass('cz-expand').removeClass('cz-contract');
            $('.gridview').animate({ height: "18px" });
        }

    });
}

function loadFiltros() {

    var StrData = new Object();
    StrData.idSupervisor = $('#hSupervisor').val();
    StrData.perfil = $('#hPerfil').val();
    StrData.flgEditar = $('#hFlgEditar').val();
    StrData.flgEliminar = $('#hFlgEliminar').val();
    StrData.flgCrear = $('#hFlgCrear').val();

    $.ajax({
        type: 'POST',
        url: urlFiltros,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(StrData),


        success: function (data) {
            
            $('#centerFrame', window.parent.document).parent().parent().parent().find('#cz-menu-lateral-left').css({ 'overflow-y': 'auto' });

            $('#centerFrame', window.parent.document).parent().parent().parent().find('#cz-menu-lateral-right').css({ 'overflow-y': 'auto' });

            $('#centerFrame', window.parent.document).parent().parent().parent().find('#cz-menu-lateral-options').html(data.d)

            $('#centerFrame', window.parent.document).parent().parent().parent().find("#editReport").click(function (e) {
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#editReport").parent().hide();
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#saveReport").parent().show();
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#delReport").parent().show();
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#newReport").parent().show();
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").attr('disabled', 'disabled');
                var StrDataE = new Object();
                
                StrDataE.idReporte = $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val();


                $.ajax({
                    type: 'POST',
                    url: UrlEdit,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(StrDataE),
                    beforeSend: function () {
                        $('#centerFrame', window.parent.document).parent().parent().parent().find('#filContent').html("<div class='form-gridview-search'><img src='images/icons/loader/ico_loader-arrow-orange.gif' /><p>Buscando resultados...</p></div>");
                        $('#centerFrame', window.parent.document).parent().parent().parent().find('.form-gridview-search').show();
                    },
                    success: function (data) {

                        $('#centerFrame', window.parent.document).parent().parent().parent().find('#filContent').html(data.d);

                    },
                    error: function (xhr, status, error) {

                        addnotify("notify", xhr.responseText, "registeruser");

                    }
                });

            });


            $('#centerFrame', window.parent.document).parent().parent().parent().find("#cancelReport").click(function (e) {

                loadFiltros();


            });

            $('#centerFrame', window.parent.document).parent().parent().parent().find("#saveReport").click(function (e) {
                var StrDataS = new Object();
                StrDataS.idReporte = $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val();

                var codigos = '';
                $('#centerFrame', window.parent.document).parent().parent().parent().find(".editCheck").each(function () {
                    if ($(this).attr('checked')) {

                        codigos = codigos + $(this).attr('cod') + ',';
                    }
                });
                StrDataS.nombre = '';
                StrDataS.codigos = codigos;

                deletePolyline(PolyArray);
                deletePolygon(PolygonArray);

                $.ajax({
                    type: 'POST',
                    url: urlsave,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(StrDataS),
                    success: function (data) {
                        loadFiltros();

                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', xhr.responseText));
                        $('#myModal').modal('show');
                    }
                });
            });

            $('#centerFrame', window.parent.document).parent().parent().parent().find("#delReport").click(function (e) {

                if ($('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte option").length > 1) {
                    var strReg = $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val();
                    var sms = $('#hidSimpleEliminar').val();

                    $('#myModal').html(alertHtml('delConfirm', "", sms));
                    $('#myModal').modal('show');

                    $('.btnDelSi').click(function (e) {

                        var strDataD = new Object();
                        strDataD.idReporte = strReg;



                        $.ajax({
                            type: 'POST',
                            url: urldel,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: JSON.stringify(strDataD),
                            success: function (data) {
                                loadFiltros();
                            },
                            error: function (xhr, status, error) {
                                $("#myModal").html(alertHtml('error', xhr.responseText));
                                $('#myModal').modal('show');
                            }
                        });
                    });


                }
                else {
                    addnotify("notify", "Debe tener al menos un mapa guardado.", "registeruser");
                }


            });

            $('#centerFrame', window.parent.document).parent().parent().parent().find("#newReport").click(function (e) {

                $.ajax({
                    type: 'POST',
                    url: urlnew,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (data) {
                        $('#myModal').html(data.d);
                        $('#myModal').modal('show');

                        $('.btnDelSi').click(function (e) {

                            var StrDataU = new Object();
                            StrDataU.idReporte = "";

                            var codigos = '';
                            $('#centerFrame', window.parent.document).parent().parent().parent().find(".editCheck").each(function () {
                                if ($(this).attr('checked')) {

                                    codigos = codigos + $(this).attr('cod') + ',';
                                }
                            });
                            StrDataU.nombre = $("#txtNombre").val();
                            StrDataU.codigos = codigos;


                            $.ajax({
                                type: 'POST',
                                url: urlsave,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                data: JSON.stringify(StrDataU),
                                success: function (data) {
                                    loadFiltros();
                                },
                                error: function (xhr, status, error) {
                                    $("#myModal").html(alertHtml('error', xhr.responseText));
                                    $('#myModal').modal('show');
                                }
                            });
                        });



                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', xhr.responseText));
                        $('#myModal').modal('show');
                    }
                });

            });

            loadFillEvents(UrlData);
            //$('#centerFrame', window.parent.document).parent().parent().parent().find('#AdicionalRep').find('input:checkbox').trigger('click');

            $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").change(function (e) {

                clearInterval(Timer);
                borrarRadios();
                deleteMarker(MarkerPosition);
                deleteMarker(MarkerPlaces);
                deletePolyline(PolyArray);
                deletePolygon(PolygonArray);
                $('.gridview').html('');
                var StrData2 = new Object();
                StrData2.Codigo = $(this).val();
                StrData2.idSupervisor = $('#hSupervisor').val();
                StrData2.flgEditar = $('#hFlgEditar').val();
                StrData2.flgEliminar = $('#hFlgEliminar').val();
                StrData2.flgCrear = $('#hFlgCrear').val();

                $.ajax({
                    type: 'POST',
                    url: urlFiltros2,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(StrData2),
                    beforeSend: function () {
                        $('#centerFrame', window.parent.document).parent().parent().parent().find('#filContent').html("<div class='form-gridview-search'><img src='images/icons/loader/ico_loader-arrow-orange.gif' /><p>Buscando resultados...</p></div>");
                        $('#centerFrame', window.parent.document).parent().parent().parent().find('.form-gridview-search').show();
                    },
                    success: function (data) {

                        $('#centerFrame', window.parent.document).parent().parent().parent().find('#filContent').html(data.d);
                        loadFillEvents(UrlData);
                        //$('#centerFrame', window.parent.document).parent().parent().parent().find('#AdicionalRep').find('input:checkbox').trigger('click');
                    },
                    error: function (xhr, status, error) {

                        addnotify("notify", xhr.responseText, "registeruser");

                    }
                });
            });
        },
        error: function (xhr, status, error) {

            addnotify("notify", xhr.responseText, "registeruser");

        }
    });
}



function loadFillEvents() {
    primeraVezCargaComboUsuario = true;
    $('#centerFrame', window.parent.document).parent().parent().parent().find(".cz-form-content-input-select").change(function () {

        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".cz-form-content-input-select").each(function () {
        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".CHG ").not("#FNXT").not("#ACAP").not("#AVGE").not("#FGRP").dropdownchecklist({ firstItemChecksAll: true, maxDropHeight: 200 });
    //$('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP").dropdownchecklist("destroy");
    $('#centerFrame', window.parent.document).parent().parent().parent().find("#FNXTDV").checkList({

        dropdownlist: $('#centerFrame', window.parent.document).parent().parent().parent().find("#FNXT")
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP").dropdownchecklist({
        firstItemChecksAll: true, maxDropHeight: 80,
        onItemClick: function () {
            getPuntosInteres();
        }
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find("#AVGE").dropdownchecklist({
        firstItemChecksAll: true, maxDropHeight: 80,
        onItemClick: function () {
            getGeocercas();
        }
    });

    //20161205 svidal: asociacion de combos de grupo y usuarios
    $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRP").dropdownchecklist({
        firstItemChecksAll: true, 
        onItemClick: function () {
            console.log('flagComboUsuarioAsociado =' + flagComboUsuarioAsociado + ' primeraVezCargaComboUsuario=' + primeraVezCargaComboUsuario);
            if (flagComboUsuarioAsociado && !primeraVezCargaComboUsuario) {
                actualizarUsuarios();
            } else {
                primeraVezCargaComboUsuario = false;
            }
        }
    });
    //$('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU").dropdownchecklist({ firstItemChecksAll: true, maxDropHeight: 200 });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".ui-dropdownchecklist-result").popover({ trigger: "hover" });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".toolbar").popover({
        trigger: "hover", content: function () {

            var text = "";
            var i = 0;
            $.each($(this).parent().parent().checkList('getSelection'), function () {


                if (i == 0) {
                    text = this.text;
                }
                else {
                    text = text + " | " + this.text;
                }
                i++;
            });

            return text; /*$(this).find('.autocompletechecklist-result').val()*/
        }
    });


    //$('#centerFrame', window.parent.document).parent().parent().parent().find('#FNXT0').parent().trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('.CHG').each(function () {


        $('#centerFrame', window.parent.document).parent().parent().parent().find("#" + $(this).attr("id") + "0").parent().trigger('click');

    });
    // $('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP0").parent().trigger('click');


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').click(function (e) {

        loadData();
        loadPointMapa();

    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREG').click(function (e) {
        e.preventDefault();
        addruler('../../images/gps/ruler.png');
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AIMP').click(function (e) {
        e.preventDefault();
        print();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').click(function (e) {
        if (e.isTrigger) {
            e.preventDefault();
            Timer = setInterval(function () { setZoomPoints = false; $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click') }, $('#hTimer').val());
            return;
        }
        if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').attr('checked')) {

            Timer = setInterval(function () { setZoomPoints = false; $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click') }, $('#hTimer').val());
        }
        else {
            clearInterval(Timer);
        }
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AGEO').click(function (e) {

        if (e.isTrigger) {
            e.preventDefault();
            loadGeocercas();
            return;
        }
        if ($(this).attr('checked')) {

            loadGeocercas();

        }
        else {
            deletePolygon(PolygonArray);
        }
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AMOV').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#ADIA').click(function (e) {
        loadData();
        loadPointMapa();
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#ACER').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AKMS').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AEST').click(function (e) {
        loadData();
        loadPointMapa();
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AEXC').click(function (e) {
        e.preventDefault();
        var filas = getNumRows('#gridPos');
        if (filas > 0) {
            var rel = '../../';
            if ($.browser.webkit) {
                rel = ''
            }
            

            var strdata = getDatos();
            strdata.tipoR = "";
            strdata.distancia = "F";
            strdata.kms = "F";
            strdata.colorEstado = "F";
            strdata.movGeo = "F";

            if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ADIA').attr('checked')) {
                strdata.tipoR = "ADIA";
            }
            if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AMOV').attr('checked')) {
                strdata.movGeo = "AMOV";
            }
            if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ACER').attr('checked')) {
                strdata.distancia = "T";
            }
            if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AKMS').attr('checked')) {
                strdata.kms = "T";
            }
            if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AEST').attr('checked')) {
                strdata.colorEstado = "T";
            }
            //console.log('JSON.stringify(strdata)=' + JSON.stringify(strdata));
            var redirect = rel + 'Reporte/mapa/exportar.aspx?json=' + JSON.stringify(strdata);
            var fra = $("#centerFrame");
            fra.context.location.href = redirect;
        }
        else {  
            addnotify("notify", "No existe data para exportar", "alertChart");
        }
    });

    //20151203 svidal : para que no cargue nada al inicio
    //$('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AGEO').trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').trigger('click');
    debugger;
    if ($("#externo").val()=="1") {
        
        $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val(2);
        console.log($('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val());
        setTimeout(function () {
            $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").change();
            setTimeout(function () {
               $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger("click");
            }, 1000);
        }, 500);
        $("#externo").val("0");
    }    
}

/*
function loadFillEvents() {




    $('#centerFrame', window.parent.document).parent().parent().parent().find(".cz-form-content-input-select").change(function () {

        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".cz-form-content-input-select").each(function () {

        $(this).parent().find(".cz-form-content-input-select-visible-text").html($(this).find("option:selected").text());
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find(".CHG ").not("#ACAP").not("#AVGE").dropdownchecklist({ firstItemChecksAll: true, maxDropHeight: 200 });
    //$('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP").dropdownchecklist("destroy");


    $('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP").dropdownchecklist({ firstItemChecksAll: true, maxDropHeight: 80,
        onItemClick: function () {
            getPuntosInteres();
        }
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find("#AVGE").dropdownchecklist({ firstItemChecksAll: true, maxDropHeight: 80,
        onItemClick: function () {
            getGeocercas();
        }
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find(".ui-dropdownchecklist-result").popover({ trigger: "hover" });


    //$('#centerFrame', window.parent.document).parent().parent().parent().find('#FNXT0').parent().trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('.CHG').each(function () {


        $('#centerFrame', window.parent.document).parent().parent().parent().find("#" + $(this).attr("id") + "0").parent().trigger('click');

    });
    // $('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP0").parent().trigger('click');


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').click(function (e) {

        loadData();
        loadPointMapa();

    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREG').click(function (e) {
        e.preventDefault();
        addruler('../../images/gps/ruler.png');
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AIMP').click(function (e) {
        e.preventDefault();
        print();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').click(function (e) {
        if (e.isTrigger) {
            e.preventDefault();
            Timer = setInterval(function () { setZoomPoints = false; $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click') }, $('#hTimer').val());
            return;
        }
        if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').attr('checked')) {

            Timer = setInterval(function () { setZoomPoints = false; $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click') }, $('#hTimer').val());
        }
        else {
            clearInterval(Timer);
        }
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AGEO').click(function (e) {

        if (e.isTrigger) {
            e.preventDefault();
            loadGeocercas();
            return;
        }
        if ($(this).attr('checked')) {

            loadGeocercas();

        }
        else {
            deletePolygon(PolygonArray);
        }

    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AMOV').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#ADIA').click(function (e) {
        loadData();
        loadPointMapa();
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#ACER').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AKMS').click(function (e) {
        loadData();
        loadPointMapa();
    });

    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AEST').click(function (e) {
        loadData();
        loadPointMapa();
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AEXC').click(function (e) {
        e.preventDefault();
        var filas = getNumRows('#gridPos');
        if (filas > 0) {
            var rel = '../../';
            if ($.browser.webkit) {
                rel = ''
            }
            var redirect = rel + 'Reporte/mapa/exportar.aspx?json=' + JSON.stringify(getDatos());
            var fra = $("#centerFrame");
            fra.context.location.href = redirect;
        }
        else {
            addnotify("notify", "No existe data para exportar", "alertChart");
        }
    });


    $('#centerFrame', window.parent.document).parent().parent().parent().find('#LoadPoint').trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AGEO').trigger('click');
    $('#centerFrame', window.parent.document).parent().parent().parent().find('#AREF').trigger('click');
}
*/

function loadGeocercas() {
    $.ajax({
        type: 'POST',
        url: UrlGeocerca,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        success: function (data) {
            dataGeo = jQuery.parseJSON(data.d);

            $.each(dataGeo, function (index, objGeo) {
                poly = new Array();
                $.each(objGeo.puntos, function (ind, objPoint) {
                    poly.push(new google.maps.LatLng(objPoint.latitud, objPoint.longitud));

                });

                addPolygon(PolygonArray, poly, objGeo.nombre);
            });

        },
        error: function (xhr, status, error) {

            addnotify("notify", xhr.responseText, "registeruser");

        }
    });
}

function getNumRows(grilla) {
    var numRows = "";
    numRows = $(grilla).find('tr').length;
    return numRows;
}


function getDatos() {

    var strData = new Object();
    var controles = new Array();
    $('#centerFrame', window.parent.document).parent().parent().parent().find("#FiltrosRep").find(".CONTROLES").each(function () {


        if ($(this).attr("tipo") == "RAN" || $(this).attr("tipo") == "CMB") {
            controles.push({ codigo: $(this).attr("id"), valor: $(this).val(), campo: $(this).attr("campo"), tipo: $(this).attr("tipo") });
        }

        if ($(this).attr("tipo") == "RDB") {
            if ($(this).attr("checked")) {

                controles.push({ codigo: $(this).attr("id"), valor: $(this).val(), campo: $(this).attr("campo"), tipo: $(this).attr("tipo") });
            }
        }

        if ($(this).attr("tipo") == "CHK") {


            controles.push({ codigo: $(this).attr("id"), valor: $(this).attr("checked") ? 'T' : 'F', campo: $(this).attr("campo"), tipo: $(this).attr("tipo") });

        }

        if ($(this).attr("tipo") == "CHG") {
            var nArray = new Array();
            nArray = $(this).val()
            var val = "";
            for (var x in nArray) {
                val = val + "'" + nArray[x] + "'" + ",";
            }

            controles.push({ codigo: $(this).attr("id"), valor: val, campo: $(this).attr("campo"), tipo: $(this).attr("tipo") });
        }
    });





    strData.controles = controles;

    strData.idReporte = $('#centerFrame', window.parent.document).parent().parent().parent().find("#cboReporte").val();
    strData.idSupervisor = $('#hSupervisor').val();

    return strData;
}

function loadData() {

    var strdata = getDatos();
    strdata.tipoR = "";
    strdata.distancia = "F";
    strdata.kms = "F";
    strdata.colorEstado = "F";
    strdata.movGeo = "F";

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ADIA').attr('checked')) {
        strdata.tipoR = "ADIA";
    }
    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AMOV').attr('checked')) {
        strdata.movGeo = "AMOV";
    }
    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ACER').attr('checked')) {
        strdata.distancia = "T";
    }
    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AKMS').attr('checked')) {
        strdata.kms = "T";
    }
    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AEST').attr('checked')) {
        strdata.colorEstado = "T";
    }


    $.ajax({
        type: 'POST',
        url: UrlData,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(strdata),
        beforeSend: function () {
            $('.gridview').html("<div class='form-gridview-search'><img src='../../images/icons/loader/ico_loader-arrow-orange.gif' /><p>Buscando resultados...</p></div>");
            $('.form-gridview-search').show();
        },
        success: function (data) {
            $('.gridview').html(data.d);
            $('#centerFrame', window.parent.document).parent().parent().parent().find('#cz-menu-right-options').html(data.d);
            $('#centerFrame', window.parent.document).parent().parent().parent().find('.gridOtro').popover({
                trigger: "hover", html: true, placement: function (context, source) {
                    var position = $(source).position();
                    if (position.top < 150) {
                        return "bottom";
                    }
                    else if (position.top > 420) {
                        return "top";
                    }
                    else {
                        return "left";
                    }
                }
            });
            $(".gridOtro").popover({ trigger: "hover", html: true, placement: function (context, source) {
                var position = $(source).position();
                if (position.top < 150) {
                    return "bottom";
                }
                else if (position.top > 250) {
                    return "top";
                }
                else {
                    return "left";
                }
            }
            });

        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseText, "registeruser");
        }
    });

}

function loadPointMapa() {

    var UrlData2 = UrlData + "_maps";

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ADIA').attr('checked')) {

        UrlData2 = UrlData + "_mapsADIA";
    }


    var strdata = getDatos();
    strdata.distancia = "F";
    strdata.kms = "F";
    strdata.estados = "F";
    strdata.movGeo = "F";

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AMOV').attr('checked')) {
        strdata.movgeo = "T";
    }

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#ACER').attr('checked')) {
        strdata.distancia = "T";
    }
    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AKMS').attr('checked')) {
        strdata.kms = "T";
    }

    if ($('#centerFrame', window.parent.document).parent().parent().parent().find('#AEST').attr('checked')) {
        strdata.estados = "T";
    }



    $.ajax({
        type: 'POST',
        url: UrlData2,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(strdata),
        beforeSend: function () {
            deleteMarker(MarkerPosition);
            deletePolyline(PolyArray);
        },
        success: function (data) {

            var isExist = false;
            dataMapa = jQuery.parseJSON(data.d).puntos;
            $.each(dataMapa, function (index, objPoint) {
                var pinIcon = {
                    url: objPoint.img,
                    size: null,
                    origin: null,
                    anchor: null,
                    scaledSize: null
                }
                addMarker(MarkerPosition, objPoint.latitud, objPoint.longitud, objPoint.msg, pinIcon, objPoint.precision, objPoint.titulo, objPoint.idCorrelativo);
                isExist = true;
            });

            $.each(jQuery.parseJSON(data.d).grouppolylines, function (index, objGP) {
                //var puntos = new google.maps.MVCArray();
                points = new google.maps.MVCArray();
                var newLocationOld;

                $.each(objGP.polylines, function (index, objPoint) {
                    var newLocation = new google.maps.LatLng(objPoint.latitud, objPoint.longitud);
                      if (strdata.estados == "T") {
                            addPolilyne(newLocation, objPoint.color);
                        } else {

                            addPolilyne(newLocation, colores[objGP.color]);
                        }

                    if (points.length > 1) {
                        newLocationOld = newLocation;
                        points = new google.maps.MVCArray();
                        points.push(newLocationOld);
                    }

                });


            });

            if (isExist) {
                if (setZoomPoints) {
                    map.setCenter(setZoom(MarkerPosition));

                }
            }
            setZoomPoints = true;


        },
        error: function (xhr, status, error) {

            addnotify("notify", xhr.responseText, "registeruser");

        }
    });
}


function getGeocercas() {
    var nArray = new Array();
    nArray = $('#centerFrame', window.parent.document).parent().parent().parent().find("#AVGE").val();
    var val = "";
    for (var x in nArray) {
        val = val + nArray[x] + ",";
    }


    var StrData = new Object();
    StrData.codigo = val;

    $.ajax({
        type: 'POST',
        url: UrlUnaGeocerca,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(StrData),
        beforeSend: function () {
            deletePolygon(PolygonArray);
        },
        success: function (data) {
            dataGeo = jQuery.parseJSON(data.d);
            $.each(dataGeo, function (ind, bgeo) {
                poly = new Array();
                $.each(bgeo.puntos, function (ind, objPoint) {
                    poly.push(new google.maps.LatLng(objPoint.latitud, objPoint.longitud));

                });
                addPolygon(PolygonArray, poly, bgeo.nombre);
            });
        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseText, "registeruser");
        }
    });

}

function getPuntosInteres() {


    var nArray = new Array();
    nArray = $('#centerFrame', window.parent.document).parent().parent().parent().find("#ACAP").val();
    var val = "";
    for (var x in nArray) {
        val = val + nArray[x] + ",";
    }


    var StrData = new Object();
    StrData.codigo = val;

    $.ajax({
        type: 'POST',
        url: UrlPInteres,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(StrData),
        beforeSend: function () {
            deleteMarker(MarkerPlaces);
            deleteCircle(Circles);
        },
        success: function (data) {


            dataMapa2 = jQuery.parseJSON(data.d).puntos;
            $.each(dataMapa2, function (index, objPoint) {
                addMarkerSimple(MarkerPlaces, objPoint.latitud, objPoint.longitud, objPoint.msg, objPoint.img, objPoint.titulo, objPoint.precision, objPoint.colorIcono)
            });



        },
        error: function (xhr, status, error) {

            addnotify("notify", xhr.responseText, "registeruser");

        }
    });
}
function actualizarUsuarios() {
    console.log('123');
    var nArray = new Array();
    nArray = $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRP").val();
    var val = "";
    for (var x in nArray) {
        val = val + nArray[x] + ",";
    }
    //console.log('val=' + val);
    var StrData = new Object();
    StrData.codigo = val;
    
    var incluyeTodos=false;
    if (val.indexOf("-1") >= 0) incluyeTodos = true;

    $.ajax({
        type: 'POST',
        url: UrlUsuarioPorGrupo,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        cache: false,
        data: JSON.stringify(StrData),
        beforeSend: function () {
        },
        success: function (data) {
            var nextels =  jQuery.parseJSON(data.d);
            var $cmbUsuario = $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU");//$("#selectId");//FNXT
            //console.log('data.d=' + data.d);
            $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU").empty();
            if (incluyeTodos) {
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU").append($('<option>', {
                    value: "-1",
                    text: "--TODOS--"
                }));
            }
            $.each(nextels, function (index, item) {
                $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU").append($('<option>', {
                    value: item.IdOpcion,
                    text: item.Descripcion
                }));
            });
            $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU").dropdownchecklist({ firstItemChecksAll: incluyeTodos, maxDropHeight: 200, recreate: true });
        },
        error: function (xhr, status, error) {
            addnotify("notify", xhr.responseText, "registeruser");
        }
    });

    /*var newOptions = {
        "Option 1": "value1",
        "Option 2": "value2",
        "Option 3": "value3"
    };

    var $cmbUsuario = $('#centerFrame', window.parent.document).parent().parent().parent().find("#FGRU");//$("#selectId");//FNXT
    console.log('$cmbUsuario=' + $cmbUsuario);
    $cmbUsuario.empty(); // remove old options
    $cmbUsuario.append("<option value=''>---Select City---</option>");

    $cmbUsuario.dropdownchecklist()._destroy();
    $cmbUsuario.dropdownchecklist()._init();*/
}


function addnotify(type, message, rel) {
    $(document).ready(function () {
        /*  
        Tipos de notificaciones:
        - notify
        - alert
        
        Ejemplo de uso:
        addnotify("notify", "El mensaje", "id");
        
        Explicacion de uso:
        - El primer parametro es el nombre del tipo de notificacion.
        - El segundo parametro es el mensaje a mostrar.
        - El ultimo es un parametro que lo identificara como unico.
        Si agregan muchas notificaciones con el mismo id, el anterior se destruira mostrando 
        este nuevo mensaje, asi evitando que se duplique los mensajes, como por ejemplo: "Complete todos los campos."
        */

        if (top.location != this.location) {
            window.parent.addnotify(type, message, rel);
        } else {
            if (rel != "") {
                $('#content-notify>.notify[rel="' + rel + '"]').remove();
            }

            $('<div class="' + type + '" rel="' + rel + '">' + message + '</div>').appendTo("#content-notify").animate({ "left": "0px" }, 300).delay(5000).animate({
                "left": "340px"
            }, {
                duration: 300,
                complete: function () { $(this).remove(); }
            });
        }
    });
}






