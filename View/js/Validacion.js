
// JScript File

/***************************************************************************************************************************************
VALIDACIONES ONBLUR
***************************************************************************************************************************************/
/*************************************************************************************
Descripción :    Permite validar los campos de un formulario.
Recibe como parametro el nombre de la caja de texto a validar, 
el mensaje que se desea mostrar, un flag que indica el tipo de 
validacion que se desea realizar y un valor booleano que indica si
el campo es obligatorio o no.
Autor 		:    Diego Alvarez Mere
Fecha		:    19/02/2007
Empresa		:    Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaCampos(pstrNombreControl, pstrMensaje, pstrTipoValidacion, pboolEsObligatorio) {
    var lobjControl = document.getElementById(pstrNombreControl);
    var pstrValor = lobjControl.value;

    if (fc_Trim(pstrValor).length > 0) {
        switch (pstrTipoValidacion) {
            case 'Texto':
                return fc_ValidaTextoGeneralFinal(pstrNombreControl, pstrMensaje);
                break;
            case 'Numero':
                return fc_ValidaNumeroFinal(lobjControl, pstrMensaje);
                break;
            case 'Decimal':
                return fc_ValidaDecimalFinal(pstrValor);
                break;
            case 'Fecha Mayor':
                return fc_ValidaFechaActualRet(pstrNombreControl, '1');
                break;
            case 'Fecha Menor':
                return fc_ValidaFechaActualRet(pstrNombreControl, '2');
                break;
            case 'Fecha Menor Igual':
                return fc_ValidaFechaActualRet(pstrNombreControl, '3');
                break;
            case 'Email':
                return fc_ValidaTextoGeneralEmail(lobjControl, pstrMensaje);
                break;
            default:
                return false;
                break;
        }
    }
    else {
        if (pboolEsObligatorio) {
            lobjControl.focus();
            alert("Debe ingresar el valor correspondiente en el campo " + pstrMensaje);
            return false;
        }
        else
        { return true; }
    }
}


/*************************************************************************************
Descripcion : Permite validar caracteres no validos en un Timer.
Muestra un mensaje de error en caso de que los 
caracteres sean no validos.
Autor		: DSB MOBILE SAC
Fecha/hora	: 25/08/2014
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
//function fc_ValidaHoraOnblur(strIdObj) {

//    var Obj = document.getElementById(strIdObj);

//    var error = false;
//    var strHoraActual;

//    var t = new Date();

//    strHoraActual = formatAMPM(t);

//    if (Obj.value != "") {

//        if (!validatetime(Obj.value))
//            error = true;

//        if (error) {
//            Obj.value = strHoraActual;
//            $('#myModal').html(alertHtml('alertValidacion', "Debe ingresar una <b>Hora</b> valida"));
//            $('#myModal').modal('show');
//            Obj.focus();
//        }
//    }
//    else {

//        Obj.value = strHoraActual;


//    }
//}

function formatAMPM(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? (hours < 10 ? '0' + hours : hours) : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0' + minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}

/*************************************************************************************
Descripcion : Permite validar un campo de fecha ha sido ingresado correctamente.
Muestra un mensaje de error en caso de que los 
caracteres sean no validos.
Autor		: DSB MOBILE SAC
Fecha/hora	: 25/08/2014
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function validatetime(strval) {
    var strval1;

    //minimum lenght is 6. example 1:2 AM
    if (strval.length < 6) {
        ////console.log('Invalid time. Time format should be HH:MM AM/PM.');
        return false;
    }

    //Maximum length is 8. example 10:45 AM
    if (strval.lenght > 8) {
        //alert("invalid time. Time format should be HH:MM AM/PM.");
        return false;
    }

    //Removing all space
    strval = trimAllSpace(strval);

    //Checking AM/PM
    if (strval.charAt(strval.length - 1) != "M" && strval.charAt(
      strval.length - 1) != "m") {
        //alert("Invalid time. Time shoule be end with AM or PM.");
        return false;

    }
    else if (strval.charAt(strval.length - 2) != 'A' && strval.charAt(
      strval.length - 2) != 'a' && strval.charAt(
      strval.length - 2) != 'p' && strval.charAt(strval.length - 2) != 'P') {
        //alert("Invalid time. Time shoule be end with AM or PM.");
        return false;

    }

    //Give one space before AM/PM

    strval1 = strval.substring(0, strval.length - 2);
    strval1 = strval1 + ' ' + strval.substring(strval.length - 2, strval.length)

    strval = strval1;

    var pos1 = strval.indexOf(':');
    //document.Form1.TextBox1.value = strval;
    ////console.log('document.Form1.TextBox1.value',strval);

    if (pos1 < 0) {
        //alert("invlalid time. A color(:) is missing between hour and minute.");
        return false;
    }
    else if (pos1 > 2 || pos1 < 1) {
        //alert("invalid time. Time format should be HH:MM AM/PM.");
        return false;
    }

    //Checking hours
    var horval = trimString(strval.substring(0, pos1));

    if (horval == -100) {
        //alert("Invalid time. Hour should contain only integer value (0-11).");
        return false;
    }

    if (horval > 12) {
        //alert("invalid time. Hour can not be greater that 12.");
        return false;
    }
    else if (horval < 0) {
        //alert("Invalid time. Hour can not be hours less than 0.");
        return false;
    }
    //Completes checking hours.

    //Checking minutes.
    var minval = trimString(strval.substring(pos1 + 1, pos1 + 3));

    if (minval == -100) {
        //alert("Invalid time. Minute should have only integer value (0-59).");
        return false;
    }

    if (minval > 59) {
        //alert("Invalid time. Minute can not be more than 59.");
        return false;
    }
    else if (minval < 0) {
        //alert("Invalid time. Minute can not be less than 0.");
        return false;
    }

    //Checking minutes completed.

    //Checking one space after the mintues 
    minpos = pos1 + minval.length + 1;
    if (strval.charAt(minpos) != ' ') {
        //alert("Invalid time. Space missing after minute. Time should have HH:MM AM/PM format.");
        return false;
    }

    return true;
}

function trimAllSpace(str) {
    var str1 = '';
    var i = 0;
    while (i != str.length) {
        if (str.charAt(i) != ' ')
            str1 = str1 + str.charAt(i); i++;
    }
    return str1;
}

function trimString(str) {
    var str1 = '';
    var i = 0;
    while (i != str.length) {
        if (str.charAt(i) != ' ') str1 = str1 + str.charAt(i); i++;
    }
    var retval = IsNumeric(str1);
    if (retval == false)
        return -100;
    else
        return str1;
}

function IsNumeric(strString) {
    var strValidChars = "0123456789";
    var strChar;
    var blnResult = true;
    //var strSequence = document.frmQuestionDetail.txtSequence.value; 
    //test strString consists of valid characters listed above 
    if (strString.length == 0)
        return false;
    for (i = 0; i < strString.length && blnResult == true; i++) {
        strChar = strString.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }
    return blnResult;
}


/*************************************************************************************
Descripcion : Permite validar caracteres no validos (cortar/pegar)
Muestra un mensaje de error en caso de que los 
caracteres sean no validos
Autor		: Diego Alvarez Mere
Fecha		: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaTextoGeneralFinal(strNameObj, strMensaje) {
    var Obj = document.getElementById(strNameObj);

    var strCadena = new String(strNameObj.value);


    if (fc_Trim(strCadena) == "")
        return true;

    /*var valido = "0123456789abcdefghijklmnopqrstuvwxyz_-ABCDEFGHIJKLMNOPQRSTUVWXYZ.,()@/:& ";*/
    var valido = "0123456789abcdefghijklmnopqrstuvwxyz_-ABCDEFGHIJKLMNOPQRSTUVWXYZ.,()@/:&#~!$%/()?'¡¿°|[]";


    strCadena = fc_Trim(strCadena);
    for (i = 0; i <= strCadena.length - 1; i++) {

        if (String.fromCharCode(241) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(209) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(225) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(233) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(237) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(243) == strCadena.substring(i, i + 1).toLowerCase()) continue;
        if (String.fromCharCode(250) == strCadena.substring(i, i + 1).toLowerCase()) continue;


        if (valido.indexOf(strCadena.substring(i, i + 1), 0) == -1) {
            valido = strCadena.substring(i, i + 1);
            alert('El Campo ' + strMensaje + ' contiene caracteres no permitidos.')
            Obj.focus();
            return false;
        }

    }
    return true;
}

/*************************************************************************************
Descripción : Permite Validar se hayan ingresado solo Numeros 
Autor 		: Diego Alvarez Mere
Fecha		: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaNumeroFinal(strNameObj, strMensaje) {
    var Obj = document.all[strNameObj];
    var strCadena = new String(strNameObj.value);
    if (fc_Trim(strCadena) == "")
        return true;

    var valido = "0123456789 ";

    strCadena = fc_Trim(strCadena);
    for (i = 0; i <= strCadena.length - 1; i++) {
        if (valido.indexOf(strCadena.substring(i, i + 1), 0) == -1) {
            valido = strCadena.substring(i, i + 1);
            alert('El Campo ' + strMensaje + ' contiene caracteres no permitidos.')
            strNameObj.focus();
            return false;
        }
    }
    return true;
}

/*************************************************************************************
Descripcion : Permite validar caracteres no validos (que no sean decimales)
Autor		: Diego Alvarez Mere
Fecha		: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaDecimalFinal(strCad) {
    var strCadena = new String(strCad);
    if (strCad == "")
        return true;

    var valido = "1234567890.";

    strCadena = strCadena;
    for (i = 0; i <= strCadena.length - 1; i++) {
        if (valido.indexOf(strCadena.substring(i, i + 1), 0) == -1) {
            valido = strCadena.substring(i, i + 1);
            return false;
        }
    }
    return true;
}

/*************************************************************************************
Descripción :    Valida que fecha ingresada sea menor/mayor o igual a la actual
Autor 		:    Diego Alvarez Mere
Fecha/hora	:    19/02/2007
Empresa		:    Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaFechaActualRet(strNameObj, num) {
    var Obj = document.all[strNameObj];
    var strDia, strMes, strAnho;
    var today = new Date();
    strAnho = today.getYear();
    strMes = (today.getMonth() + 1);
    strDia = today.getDate();
    if (parseInt(strMes) <= 9)
        strMes = '0' + strMes;
    if (parseInt(strDia) <= 9)
        strDia = '0' + strDia;
    var strFechaActual = strDia + "/" + strMes + "/" + strAnho;
    var dFec = Obj.value.substr(6, 4) + "/" + Obj.value.substr(3, 2) + "/" + Obj.value.substr(0, 2);
    var dActual = strFechaActual.substr(6, 4) + "/" + strFechaActual.substr(3, 2) + "/" + strFechaActual.substr(0, 2);

    if (Obj.value != "") {
        if ((num == '1') && (dFec < dActual)) {
            alert("Debe ingresar una fecha mayor o igual a la fecha actual");
            Obj.value = "";
            Obj.focus();
            return false;
        }
        else if ((num == '2') & (dFec >= dActual)) {
            alert("Debe ingresar una fecha menor a la actual");
            Obj.value = "";
            Obj.focus();
            return false
        }
        else if ((num == '3') & (dFec > dActual)) {
            alert("Debe ingresar una fecha menor o igual a la actual");
            Obj.value = "";
            Obj.focus();
            return false
        }
    }
    return true;
}

/*************************************************************************************
Descripcion : Permite validar caracteres no validos en un email.
Muestra un mensaje de error en caso de que los 
caracteres sean no validos.
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaTextoGeneralEmail(strNameObj, strMensaje) {
    var Obj = document.all[strNameObj];
    var strCadena = new String(strNameObj.value);

    var s = strCadena;
    var filter = /^[A-Za-z][A-Za-z0-9_.]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
    if (s.length == 0) return true;
    if (filter.test(s))
        return true;
    else
        alert("Ingrese una direccion de correo válida");
    //Obj.focus();
    return false;

}

/*************************************************************************************
Descripcion : Permite validar caracteres no validos en una fecha.
Muestra un mensaje de error en caso de que los 
caracteres sean no validos.
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_ValidaFechaOnblur(strIdObj) {
    //       alert('tamare');
    //strNameObj : Nombre de la caja de texto a validar.

    var Obj = document.getElementById(strIdObj);
    var error = false;
    var formatoIdioma = "dd/MM/yyyy";

    var today = new Date();
    var strDia, strMes, strAnho, dActual, dFec;
    var strFechaActual;

    if (navigator.appName == "Netscape") {
        strAnho = "" + ((today.getYear()) - 0 + 1900);
    } else if (navigator.appName == "Microsoft Internet Explorer") {
        strAnho = today.getYear();
    }
    strMes = (today.getMonth() + 1);
    if (parseInt(strMes) <= 9) { strMes = '0' + strMes; }
    strDia = today.getDate();
    if (parseInt(strDia) <= 9) { strDia = '0' + strDia; }
    strFechaActual = strDia + "/" + strMes + "/" + strAnho;
    /*
    var idioma = document.getElementById("txhIdioma").value;
    var formatoIdioma = "dd/MM/yyyy";
    if (idioma == "en-US"){
    formatoIdioma = "MM/dd/yyyy";
    }
    */
    if (Obj.value != "") {
        if (Obj.value.length == 8) {
            var _anio = Obj.value.substring(6, 8)
            Obj.value = Obj.value.substring(0, 6) + '20' + _anio
        }
        if (!isFecha(Obj.value, formatoIdioma)) error = true;
        else {
            strAnho = Obj.value.split("/")[2];

            if (strAnho < '1900') error = true;
        }
        if (error) {

            Obj.value = strFechaActual;
            //  alert('Debe ingresar una fecha valida.');
            $('#myModal').html(alertHtml('alertValidacion', "Debe ingresar una fecha valida"));
            $('#myModal').modal('show');
            Obj.focus();
        }
    }
    else {

        Obj.value = strFechaActual;


    }
}

/*************************************************************************************
Descripcion : Permite validar si la cadena recibida en val es una fecha con el formato format.
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function isFecha(val, format) {
    var date = getDateFromFormat(val, format);
    if (date == 0) { return false; }
    return true;
}

/***************************************************************************************************************************************
VALIDACIONES ONKEYPRESS
***************************************************************************************************************************************/

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean numericos
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_PermiteNumeros(evt, c) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    //if ((window.event.keyCode < 48) || (window.event.keyCode > 57)) {
    if ((charCode < 48) || (charCode > 57)) {
        //window.event.returnValue = 0;
        return false;
    } else {
        return true;
    }
}

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean fechas.
Adicionalmente rellena las fechas con slash.
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
//function fc_Slash(ObjId, separador) {
//    var obj
//    fc_PermiteNumeros();
//    obj = document.getElementById(ObjId);
//    if ((obj.value.length == 2) || (obj.value.length == 5)) { obj.value = obj.value + separador; }
//    if (obj.value.length = obj.maxlength - 1) { return; }
//}

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean numericos negativos
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_PermiteNegativo() {
    var intEncontrado = "1234567890-".indexOf(String.fromCharCode(window.event.keyCode));
    if (intEncontrado == -1) {
        window.event.keyCode = 0;
    }
}

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean numericos decimales
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
/*function fc_PermiteDecimal() {
    var intEncontrado = "1234567890.".indexOf(String.fromCharCode(window.event.keyCode));
    if (intEncontrado == -1) {
        window.event.keyCode = 0;
    }
}*/

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean texto
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_PermiteTexto() {
    if ((window.event.keyCode != 13)) {
        if ((window.event.keyCode == 209) || (window.event.keyCode == 241)) {
            var intEncontrado = 0;
            //convierte la ñ en Ñ
            window.event.keyCode = 209;
        }
        else {
            var ch_Caracter = String.fromCharCode(window.event.keyCode).toUpperCase();
            var intEncontrado = " ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(ch_Caracter);
            if (intEncontrado == -1) {
                window.event.keyCode = 0;
            }
            else {
                window.event.keyCode = ch_Caracter.charCodeAt();
            }
        }
    }
}

/*************************************************************************************
Descripcion : Permite validar que los caracteres ingresados sean alfanumericos
Autor		: Diego Alvarez Mere
Fecha/hora	: 19/02/2007
Empresa		: Nextel del Perú S.A.
*************************************************************************************/
function fc_PermiteTextoNumerico() {
    debugger;
    if ((window.event.keyCode != 13)) {
        if ((window.event.keyCode == 209) || (window.event.keyCode == 241)) {
            var intEncontrado = 0;
            //convierte la ñ en Ñ
            window.event.keyCode = 209;
        }
        else {
            var ch_Caracter = String.fromCharCode(window.event.keyCode).toUpperCase();
            var intEncontrado = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.?¿".indexOf(ch_Caracter);
            if (intEncontrado == -1) {
                window.event.keyCode = 0;
            }
            else {
                window.event.keyCode = ch_Caracter.charCodeAt();
            }
        }
    }
}

/**************************************************************************************
FUNCIONES DE TERCEROS
**************************************************************************************/

// ------------------------------------------------------------------------
// formatDate (date_object, format)
// Returns a date in the output format specified.
// The format string uses the same abbreviations as in getDateFromFormat()
// -------------------------------------------------------------------------
function formatDate(date, format) {
    format = format + "";
    var result = "";
    var i_format = 0;
    var c = "";
    var token = "";
    var y = date.getYear() + "";
    var M = date.getMonth() + 1;
    var d = date.getDate();
    var H = date.getHours();
    var m = date.getMinutes();
    var s = date.getSeconds();
    var yyyy, yy, MMM, MM, dd, hh, h, mm, ss, ampm, HH, H, KK, K, kk, k;
    // Convert real date parts into formatted versions
    var value = new Object();
    if (y.length < 4) { y = "" + (y - 0 + 1900); }
    value["y"] = "" + y;
    value["yyyy"] = y;
    value["yy"] = y.substring(2, 4);
    value["M"] = M;
    value["MM"] = LZ(M);
    value["MMM"] = MONTH_NAMES[M - 1];
    value["d"] = d;
    value["dd"] = LZ(d);
    value["H"] = H;
    value["HH"] = LZ(H);
    if (H == 0) { value["h"] = 12; }
    else if (H > 12) { value["h"] = H - 12; }
    else { value["h"] = H; }
    value["hh"] = LZ(value["h"]);
    if (H > 11) { value["K"] = H - 12; } else { value["K"] = H; }
    value["k"] = H + 1;
    value["KK"] = LZ(value["K"]);
    value["kk"] = LZ(value["k"]);
    if (H > 11) { value["a"] = "PM"; }
    else { value["a"] = "AM"; }
    value["m"] = m;
    value["mm"] = LZ(m);
    value["s"] = s;
    value["ss"] = LZ(s);
    while (i_format < format.length) {
        c = format.charAt(i_format);
        token = "";
        while ((format.charAt(i_format) == c) && (i_format < format.length)) {
            token += format.charAt(i_format++);
        }
        if (value[token] != null) { result = result + value[token]; }
        else { result = result + token; }
    }
    return result;
}

// ------------------------------------------------------------------
// Utility functions for parsing in getDateFromFormat()
// ------------------------------------------------------------------
function _isInteger(val) {
    var digits = "1234567890";
    for (var i = 0; i < val.length; i++) {
        if (digits.indexOf(val.charAt(i)) == -1) { return false; }
    }
    return true;
}
function _getInt(str, i, minlength, maxlength) {
    for (var x = maxlength; x >= minlength; x--) {
        var token = str.substring(i, i + x);
        if (token.length < minlength) { return null; }
        if (_isInteger(token)) { return token; }
    }
    return null;
}

// ------------------------------------------------------------------
// getDateFromFormat( date_string , format_string )
//
// This function takes a date string and a format string. It matches
// If the date string matches the format string, it returns the 
// getTime() of the date. If it does not match, it returns 0.
// ------------------------------------------------------------------
function getDateFromFormat(val, format) {
    val = val + "";
    format = format + "";
    var i_val = 0;
    var i_format = 0;
    var c = "";
    var token = "";
    var token2 = "";
    var x, y;
    var now = new Date();
    var year = now.getYear();
    var month = now.getMonth() + 1;
    var date = now.getDate();
    var hh = now.getHours();
    var mm = now.getMinutes();
    var ss = now.getSeconds();
    var ampm = "";

    while (i_format < format.length) {

        // Get next token from format string
        c = format.charAt(i_format);
        token = "";
        while ((format.charAt(i_format) == c) && (i_format < format.length)) {
            token += format.charAt(i_format++);
        }

        // Extract contents of value based on format token
        if (token == "yyyy" || token == "yy" || token == "y") {
            if (token == "yyyy") { x = 4; y = 4; }
            if (token == "yy") { x = 2; y = 2; }
            if (token == "y") { x = 2; y = 4; }
            year = _getInt(val, i_val, x, y);
            if (year == null) { return 0; }
            i_val += year.length;
            if (year.length == 2) {
                if (year > 70) { year = 1900 + (year - 0); }
                else { year = 2000 + (year - 0); }
            }
        }
        else if (token == "MMM") {
            month = 0;
            for (var i = 0; i < MONTH_NAMES.length; i++) {
                var month_name = MONTH_NAMES[i];
                if (val.substring(i_val, i_val + month_name.length).toLowerCase() == month_name.toLowerCase()) {
                    month = i + 1;
                    if (month > 12) { month -= 12; }
                    i_val += month_name.length;
                    break;
                }
            }
            if ((month < 1) || (month > 12)) { return 0; }
        }
        else if (token == "MM" || token == "M") {

            month = _getInt(val, i_val, token.length, 2);

            if (month == null || (month < 1) || (month > 12)) { return 0; }
            i_val += month.length;
        }
        else if (token == "dd" || token == "d") {
            date = _getInt(val, i_val, token.length, 2);
            if (date == null || (date < 1) || (date > 31)) { return 0; }
            i_val += date.length;
        }
        else if (token == "hh" || token == "h") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 1) || (hh > 12)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "HH" || token == "H") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 0) || (hh > 23)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "KK" || token == "K") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 0) || (hh > 11)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "kk" || token == "k") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 1) || (hh > 24)) { return 0; }
            i_val += hh.length; hh--;
        }
        else if (token == "mm" || token == "m") {
            mm = _getInt(val, i_val, token.length, 2);
            if (mm == null || (mm < 0) || (mm > 59)) { return 0; }
            i_val += mm.length;
        }
        else if (token == "ss" || token == "s") {
            ss = _getInt(val, i_val, token.length, 2);
            if (ss == null || (ss < 0) || (ss > 59)) { return 0; }
            i_val += ss.length;
        }
        else if (token == "a") {
            if (val.substring(i_val, i_val + 2).toLowerCase() == "am") { ampm = "AM"; }
            else if (val.substring(i_val, i_val + 2).toLowerCase() == "pm") { ampm = "PM"; }
            else { return 0; }
            i_val += 2;
        }
        else {
            if (val.substring(i_val, i_val + token.length) != token) { return 0; }
            else { i_val += token.length; }
        }
    }
    // If there are any trailing characters left in the value, it doesn't match
    if (i_val != val.length) { return 0; }
    // Is date valid for month?
    if (month == 2) {
        // Check for leap year
        if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { // leap year
            if (date > 29) { return false; }
        }
        else { if (date > 28) { return false; } }
    }
    if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
        if (date > 30) { return false; }
    }
    // Correct hours value
    if (hh < 12 && ampm == "PM") { hh += 12; }
    else if (hh > 11 && ampm == "AM") { hh -= 12; }
    var newdate = new Date(year, month - 1, date, hh, mm, ss);
    return newdate.getTime();
}




// -------------------------------------------------------------------
//  Resta dos fechas y retorna true si supera valor parametro
// -------------------------------------------------------------------
function Fc_RestaFechas(date1, dateformat1, date2, dateformat2, dias) {
    var d1 = getDateFromFormat(date1, dateformat1);
    var d2 = getDateFromFormat(date2, dateformat2);

    if ((d2 - d1) / (1000 * 24 * 60 * 60) > dias)
        return true
    else
        return false;
}
// -------------------------------------------------------------------
//  Resta dos fechas y retorna el nro de Dias
// -------------------------------------------------------------------
function Fc_RestaFechas(date1, dateformat1, date2, dateformat2) {
    var d1 = getDateFromFormat(date1, dateformat1);
    var d2 = getDateFromFormat(date2, dateformat2);

    return (d2 - d1) / (1000 * 24 * 60 * 60)

}




function fc_ValidaNextel() {
    if ((window.event.keyCode < 48) || (window.event.keyCode > 57)) {
        window.event.returnValue = 0;
    }
    if (window.event.keyCode == 42) {
        window.event.returnValue = 1;
    }
}


function fc_PermiteDecimal(e) {
    var character = String.fromCharCode(window.event.keyCode)
    var newValue = e.value + character;

    if (newValue.length == 1 && character == '-') {
        return true;
    }

    if (isNaN(newValue)) {
        window.event.preventDefault();
        return false;
    }
}

function fc_ValidaHoraOnblur(strIdObj) {
    var Obj = document.getElementById(strIdObj);
    var error = false;
    var mm, ss;

    if (Obj.value != "") {
        if (Obj.value.length == 5) {
            mm = Obj.value.substring(0, 2);
            var intMM = parseInt(mm);
            ss = Obj.value.substring(3, 5);
            var intSS = parseInt(ss);
            if (intMM < 0 || intMM > 24 || intSS < 0 || intSS > 59) {
                error = true;
            }
            if (intMM == 24) {
                if (intSS != 00) error = true;
            }
        } else error = true;
    } else { error = true; }

    if (error) {
        Obj.value = "00:00";
        Obj.focus();
    }
}

//Se utiliza para que el campo de texto solo acepte letras
function SoloAlfanumerico(e) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toString();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789";//Se define todo el abecedario que se quiere que se muestre.
    especiales = [8, 6]; //, 37, 39, 46 Es la validación del KeyCodes, que teclas recibe el campo de texto.

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial) {
        return false;
    }
}

function isDecimalNumber(evt, c) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var dot1 = c.value.indexOf('.');
    var dot2 = c.value.lastIndexOf('.');

    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
        return false;

    return true;
}
var getKeyCode = function (str) {
    return str.charCodeAt(str.length - 1);
}
function isDecimalNumberOnInput(evt, c) {
    var charCode = getKeyCode(evt.data);
    var valText = c.value.substring(0, c.value.length - 1)
    var dot1 = valText.indexOf('.');
    var dot2 = valText.lastIndexOf('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        $(c).val($(c).val().substring(0, $(c).val().length - 1));
    else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
        $(c).val($(c).val().substring(0, $(c).val().length - 1));
}
function fc_PermiteNumerosOnInput(evt, c) {
    var charCode = getKeyCode(evt.data);
    if ((charCode < 48) || (charCode > 57)) {
        $(c).val($(c).val().substring(0, $(c).val().length - 1));
    }
}

function SoloAlfanumericoOnInput(e, c) {
    var charCode = getKeyCode(e.data);
    tecla = String.fromCharCode(charCode).toString();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789";//Se define todo el abecedario que se quiere que se muestre.
    especiales = [8, 6]; //, 37, 39, 46 Es la validación del KeyCodes, que teclas recibe el campo de texto.

    tecla_especial = false
    for (var i in especiales) {
        if (charCode == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }

    if (letras.indexOf(tecla) == -1 && !tecla_especial) {
        $(c).val($(c).val().substring(0, $(c).val().length - 1));
    }
}