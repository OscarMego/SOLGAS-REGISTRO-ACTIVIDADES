var geocoder;
var map;
var drawingManager;
var selectedShape;
var infowindowsNew;
var msgInfo = "";
var newShape;

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

    geocoder = new google.maps.Geocoder();
    map = new google.maps.Map(document.getElementById("map"), myOptions);

        drawingManager = new google.maps.drawing.DrawingManager({
        drawingControl: false,
        polygonOptions: {
            fillColor: '#AA2143',
            fillOpacity: 0.25,
            strokeColor: '#FF6600',
            strokeWeight: 2,
            clickable: true,
            zIndex: 1,
            editable: true
        }
        });

    drawingManager.setMap(map);

    var input = (document.getElementById('address'));
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);
    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);


    google.maps.event.addListener(autocomplete, 'place_changed', function () {


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

        var address = '';
        if (place.address_components) {
            address = [
			(place.address_components[0] && place.address_components[0].short_name || ''),
			(place.address_components[1] && place.address_components[1].short_name || ''),
			(place.address_components[2] && place.address_components[2].short_name || '')
		  ].join(' ');
        }

        
    });



    google.maps.event.addListener(drawingManager, 'overlaycomplete', function (e) {
        if (e.type != google.maps.drawing.OverlayType.MARKER) {
            // Switch back to non-drawing mode after drawing a shape.
            drawingManager.setDrawingMode(null);
            
            // Add an event listener that selects the newly-drawn shape when the user
            // mouses down on it.
            newShape = e.overlay;
            newShape.type = e.type;

            if ($('#hPrivEditar').val() == "T") {
                google.maps.event.addListener(newShape, 'click', function () {
                    setSelection(newShape);
                    infowindowsNew = new google.maps.InfoWindow({
                        content: msgInfo
                    });
                    infowindowsNew.setPosition(getCenterGeo(newShape));
                    infowindowsNew.open(map);

                });
            }
            setSelection(newShape);

            infowindowsNew = new google.maps.InfoWindow({
                content: msgInfo
            });
            infowindowsNew.setPosition(getCenterGeo(newShape));
            infowindowsNew.open(map);

            if (cancelado) {
                deleteSelectedShape();
            }

        }
    });


    // Clear the current selection when the drawing mode is changed, or when the
    // map is clicked.
    google.maps.event.addListener(drawingManager, 'drawingmode_changed', clearSelection);
    google.maps.event.addListener(map, 'click', clearSelection);

    
   
}



function getCenterGeo(newShape) {
    var bounds = new google.maps.LatLngBounds();

    var path = newShape.getPath();
    for (var i = 0; i < path.length; i++) {
        coord = path.getAt(i);

        point = new google.maps.LatLng(coord.lat(), coord.lng());

        bounds.extend(point);

    }
    map.fitBounds(bounds);
    return bounds.getCenter();
}

function clearSelection() {
    
    if (selectedShape) {
        selectedShape.setEditable(false);
        selectedShape = null;
    }
}

function setSelection(shape) {
    clearSelection();
    selectedShape = shape;
    shape.setEditable(true);
    
    //selectColor(shape.get('fillColor') || shape.get('strokeColor'));
}

function deleteSelectedShape() {
    if (selectedShape) {
        selectedShape.setMap(null);
    }
}

/**/

//Geolocalizacion de direcciones

function drawPolygon(poly) {
    
     polygonOptions = {
            paths: poly,
            fillColor: '#AA2143',
            fillOpacity:0.7,
            strokeColor: '#FF6600',
            strokeWeight:2,
            clickable:true,
            zIndex: 1,
            editable: true};

        newShape = new google.maps.Polygon(polygonOptions);
        newShape.setMap(map);
        if ($('#hPrivEditar').val() == "T") {
            google.maps.event.addListener(newShape, 'click', function () {
                setSelection(newShape);
                infowindowsNew = new google.maps.InfoWindow({
                    content: msgInfo
                });
                infowindowsNew.setPosition(getCenterGeo(newShape));
                infowindowsNew.open(map);

            });
        }
        setSelection(newShape);
        map.setCenter(getCenterGeo(newShape));
        
 
}

function loadGeocercas(habilitado) {
    var strData = new Object();
    strData.habilitado = habilitado;

    $.ajax({
        type: 'POST',
        url: urlLoad,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(strData),
        async: true,
        cache: false,
        dataType: "json",
        beforeSend: function () {
            $(".paginator-data-search").show();
        },
        success: function (data) {
            $(".paginator-data-search").hide();
            $('.contentGeo ul').html(data.d);
        },
        error: function (xhr, status, error) {
            $(".paginator-data-search").hide();
            $("#myModal").html(alertHtml('error', xhr.responseText));
            $('#myModal').modal('show');
        }
    });
}
function loadGeoLayers() {
    $('#newGeo').click(function (e) {

        $('#hAccion').val('I');
        $('#hNombre').val('');
        $('#hCodigo').val('');
        deleteSelectedShape();
        newShape = null;
        cancelado = false;
        if (infowindowsNew != null && infowindowsNew.getMap()) {
            infowindowsNew.close();
        }
        drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
        msgInfo = '<div>Ingrese un nombre</div><div><input name="txtGeocerca" type="text" id="txtGeocerca" class="form-textbox textbox-codigo-width"></div><div><input type="button" id="btnCreaGeo" class="form-button cz-form-content-input-button cz-modal-geo-back" value="Guardar"></div>';
        $('#newCancel').show();
        $('.contentGeo li').attr('disabled', true);
        $('#newGeo').attr('disabled', true);
    });


    $('#newCancel').click(function (e) {

        $('#hAccion').val('');
        $('#hNombre').val('');
        $('#hCodigo').val('');
        cancelado = true;
        deleteSelectedShape();
        newShape = null;
        drawingManager.setDrawingMode(null);
        if (infowindowsNew != null && infowindowsNew.getMap()) {
            infowindowsNew.close();
        }
        $('#newCancel').hide();
        $('.contentGeo li').removeAttr('disabled');
        $('#newGeo').removeAttr('disabled');

    });

    $('#btnCreaGeo').live('click', function (e) {
        var puntos = new Array();
        var path = newShape.getPath();
        for (var i = 0; i < path.length; i++) {
            coord = path.getAt(i);
            puntos.push({ latitud: coord.lat(), longitud: coord.lng() });
        }

        var flgHabilitado = $('#chkEliminados').attr('checked') ? "F" : "T";
        var strData = new Object();
        strData.Nombre = $('#txtGeocerca').val();
        strData.listaPuntos = puntos;
        strData.flgHabilitado = flgHabilitado;

        $.ajax({
            type: 'POST',
            url: urlCreate,
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(strData),
            async: true,
            cache: false,
            dataType: "json",
            success: function (data) {
                addnotify("notify", "Geocerca registrada exitosamente", "crear-geocerca");
                $('#hNombre').val($('#txtGeocerca').val());
                $('#hCodigo').val(data.d);
                $('#hAccion').val('U');
                $('#newGeo').removeAttr('Disabled');
                $('#newCancel').hide();
                msgInfo = '<div>Editar</div><div><input name="txtGeocerca" type="text" id="txtGeocerca" class="form-textbox textbox-codigo-width" value=' + $('#hNombre').val() + '></div><div><input type="button" id="btnUpdGeo" class="form-button cz-form-content-input-button" value="Guardar"></div>';
                infowindowsNew.close();
                loadGeocercas(flgHabilitado);
            },
            error: function (xhr, status, error) {
                addnotify("notify", JSON.parse(xhr.responseText).Message, "crear-geocerca");
                $("#cz-modal-geo-option1").hide();
                $("#cz-modal-geo-option2").hide();
                $("#cz-modal-geo-option3").show();
            }
        });
    });

    $('#btnUpdGeo').live('click', function (e) {


        var puntos = new Array();
        var path = newShape.getPath();
        for (var i = 0; i < path.length; i++) {
            coord = path.getAt(i);
            puntos.push({ latitud: coord.lat(), longitud: coord.lng() });
        }

        var flgHabilitado = $('#chkEliminados').attr('checked') ? "F" : "T";

        var strData = new Object();
        strData.Codigo = $('#hCodigo').val();
        strData.Nombre = $('#txtGeocerca').val();
        strData.listaPuntos = puntos;
        strData.flgHabilitado = $('#chkEliminados').attr('checked')?"F":"T";

        $.ajax({
            type: 'POST',
            url: urlUpd,
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(strData),
            async: true,
            cache: false,
            dataType: "json",
            success: function (data) {

                addnotify("notify", "Geocerca actualizada.", "crear-geocerca");
                $('#hNombre').val($('#txtGeocerca').val());
                $('#hCodigo').val(data.d);
                $('#hAccion').val('U');
                $('#newGeo').removeAttr('Disabled');
                $('#newCancel').hide();
                msgInfo = '<div>Editar</div><div><input name="txtGeocerca" type="text" id="txtGeocerca" class="form-textbox textbox-codigo-width" value=' + $('#hNombre').val() + '></div><div><input type="button" id="btnUpdGeo" class="form-button cz-form-content-input-button" value="Guardar"></div>';
               

           
               
                infowindowsNew.close();
                loadGeocercas(strData.flgHabilitado);
                setTimeout(function () {
                    $('#divError').attr('class', "alert fade");
                }, 1000);
            },
            error: function (xhr, status, error) {
                addnotify("notify", jQuery.parseJSON(xhr.responseText).Message, "actualizar-geocerca");
                $('#divError').attr('class', "alert alert-error");
                $("#mensajeError").text(jQuery.parseJSON(xhr.responseText).Message);
                $("#tituloMensajeError").text('ERROR');
            }
        });
    });



    $('.contentGeo li').live('click', function (e) {
        
            if (!$(this).attr('disabled')) {

                $(this).attr('cod')

                var strData = new Object();
                strData.Codigo = $(this).attr('cod');
                $('#newCancel').hide();

                $.ajax({
                    type: 'POST',
                    url: urlGet,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(strData),
                    async: true,
                    cache: false,
                    dataType: "json",
                    success: function (data) {
                        var strd = jQuery.parseJSON(data.d);

                        deleteSelectedShape();
                        $('#hAccion').val('U');
                        $('#hCodigo').val(strd.id);
                        $('#hNombre').val(strd.nombre);

                        msgInfo = '<div>Editar</div><div><input name="txtGeocerca" type="text" id="txtGeocerca" class="form-textbox textbox-codigo-width" value="' + strd.nombre + '"></div><div><input type="button" id="btnUpdGeo" class="form-button cz-form-content-input-button" value="Guardar"></div>';
                        poly = new Array();

                        $.each(strd.LstGeocercaPuntosBean, function (index, objPoint) {

                            poly.push(new google.maps.LatLng(objPoint.latitud, objPoint.longitud));
                        });

                        drawPolygon(poly);
                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', xhr.responseText));
                        $('#myModal').modal('show');
                    }
                });


            }
        
    });



    $('.icodelGeo').live('click', function (e) {

        if (!$(this).parent().attr('disabled')) {
            var eliminar = "";
            if ($('#chkEliminados').attr('checked')) {
                eliminar = "restaurar";
            } else {
                eliminar = "eliminar"
            }
            var strReg = $(this).attr('cod')
            $('#myModal').html(alertHtml('delConfirm', "", "¿Esta seguro que desea <b>" +eliminar + "</b> este registro?"));
            $('#myModal').modal('show');

            $('.btnDelSi').click(function (e) {
                var flgHabilitado = $('#chkEliminados').attr('checked') ? "F" : "T";
                var strData = jQuery.parseJSON('{ "codigos": "' + strReg + '" }');
                strData.flgHabilitado = $('#chkEliminados').attr('checked') ? "T" : "F";
                $.ajax({
                    type: 'POST',
                    url: urlDel,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    data: JSON.stringify(strData),
                    success: function (data) {
                        loadGeocercas(flgHabilitado);
                        deleteSelectedShape();
                    },
                    error: function (xhr, status, error) {
                        $("#myModal").html(alertHtml('error', xhr.responseText));
                    }
                });
            });
        }
    });


 
    


    
}