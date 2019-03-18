<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Carga.aspx.cs" Inherits="View.Acciones.Carga.Carga" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <!-- #### META tags ####-->
    <!-- Meta tags browser-->
    <meta charset="utf-8">
    <meta http.equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Meta tags Description-->
    <meta name="description" content="Sistema Entel">
    <meta name="author" content="GMD">
    <meta property="og:url" content="">
    <!-- -TITULO DE LA APLICACION-->
    <meta property="og:site_name" content="Sistema Entel">
    <!-- -TITULO DE LA PAGINA-->
    <meta property="og:title" content="Sistema Entel">
    <!-- -DESCRIPCION-->
    <meta property="og:description" content="Sistema Entel">
    <!-- -UBICACIÓN-->
    <meta property="og:locale" content="es_PE">
    <!-- -IMAGEN REPRESENTATIVA-->
    <meta property="og:image" content="">
    <!-- #### TITLE ####-->
    <title>Entel</title>
    <!-- Open Sans - Body-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600,600i,700,700i" rel="stylesheet">
    <!-- Heebo - Body-->
    <link href="https://fonts.googleapis.com/css?family=Heebo:100,400,500,700" rel="stylesheet">
    <!-- #### ICON ####-->
    <!-- -IMAGEN REPRESENTATIVA-->
    <meta property="og:image" content="">

    <link href="../../css/cz_main.ashx" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" href="../../css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="../../css/fontawesome-all.min.css">
    <!-- Main css - css personalizacion-->
    <link rel="stylesheet" href="../../css/main.css">

    <link href="../../css/FileTemplate.css" type="text/css" rel="stylesheet" />
    <link href="../../css/FileUploader.css" type="text/css" rel="stylesheet" />
    <script src="../../js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../js/upload/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../js/alertHtml.ashx" type="text/javascript"></script>
    <script src="../../js/JSModule.js" type="text/javascript"></script>
    <script src="../../js/upload/fileuploader.js" type="text/javascript"></script>

    <script src="../../js/cz_main.js" type="text/javascript"></script>

    <link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%=Session["GOOGLE_ANALYTICS"] %>
    <style>
        .modal-body ul {
            list-style: none;
        }
    </style>
    <script>
        $(document).ready(function () {
            if ($('#hidUtilitarios').val() == "0") {
                $('#divUtilitarios').hide();
            } else {
                $('#divUtilitarios').show();
            }
            accionesCarga();
            detReg(".btnData", "cargaErrores.aspx");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hidUtilitarios" runat="server" />
        <div id="wrapper">
            <div class="main">
                <div class="container">
                    <div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                       
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-md-12 titulo">
                            <h2><i class="fa fa-upload"></i>Carga</h2>
                        </div>
                    </div>
                    <div class="row filtergrid">
                        <form>
                            <div class="col-sx-12 col-sm-9 col-md-9 form-group">
                                <label for="ddlTipo">Tipo Archivo Aceptado XLSX</label>
                                <%--<asp:RadioButtonList ID="rblTipoCarga" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="E" style="padding: 10px;" class="carga_label">Excel(.xls / .xlsx)</asp:ListItem>
                                   <asp:ListItem Text="" style="padding: 10px;" Value="T" class="carga_label">Texto (.txt)</asp:ListItem>
                                     <%--<asp:ListItem Value="K" CssClass="carga_label">KML(.kml)</asp:ListItem>--%>
                                <%--</asp:RadioButtonList>--%>
                            </div>
                            <div class="col-sx-12 col-sm-3 col-md-3 form-group">
                                <button type="button" class="btn btn-danger cz-form-step-image-progress-examinar-content-row-option-add cz-form-step-examinar" style="/* float: right */width: 100%; margin: unset;"><i class="fas iconButton fa-plus"></i>Añadir</button>
                            </div>
                        </form>
                    </div>

                    <div class="row">
                        <%--cz-form-box-content">--%>
                        <div class="col-xs-12 col-md-12">
                            <div id="file-uploader">
                            </div>
                            <div id="cz-form-step">
                                <div id="cz-form-step-image">
                                    <div id="cz-form-step-image-text">
                                        <div id="cz-form-step-image-text-left" class=" col-xs-12 col-md-12 cz-form-step-image-complete">
                                            <a>Paso 1: Examinar Archivos</a>
                                        </div>
                                        <div id="cz-form-step-image-text-center" class="col-xs-12 col-md-12">
                                            <a>Paso 2: Confirmar Archivos</a>
                                        </div>
                                        <div id="cz-form-step-image-text-right" class="col-xs-12 col-md-12">
                                            <a>Paso 3: Resultado</a>
                                        </div>
                                    </div>
                                </div>
                                <div id="cz-form-step-image-progress-examinar">
                                    <div class="cz-form-step-image-progress-title">
                                        Examinar archivos a la lista.
                                    </div>
                                    <div id="cz-form-step-image-progress-examinar-content">
                                        <div class="cz-form-step-image-progress-examinar-content-row-head">
                                            <div class="cz-form-step-image-progress-examinar-content-row-name">
                                                Nombre
                                            </div>
                                            <div class="cz-form-step-image-progress-examinar-content-row-size">
                                                Tamaño
                                            </div>
                                            <div class="cz-form-step-image-progress-examinar-content-row-option">
                                                <div class="cz-form-step-image-progress-examinar-content-row-option-remove">
                                                </div>
                                            </div>
                                        </div>
                                        <div id="cz-form-step-files">
                                        </div>
                                        <div class="cz-form-step-image-progress-examinar-content-row-file">
                                            <div class="cz-form-step-image-progress-examinar-content-row-name">
                                            </div>
                                            <div class="cz-form-step-image-progress-examinar-content-row-size">
                                            </div>
                                            <%--<div class="cz-form-step-image-progress-examinar-content-row-option">
                                    <div class="cz-form-step-examinar cz-form-step-image-progress-examinar-content-row-option-add cz-form-content-input-button">
                                        +</div>
                                </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="cz-form-content-wall">
                                <input type="button" onclick="nextconfirm();" id="cz-carga-siguiente" class="siguiente-confirm cz-form-content-input-button-image cz-form-content-input-button"
                                    value="Siguiente" />
                            </div>
                            <div class="cz-form-content-wall" id="siguiente-box-update">
                                <input type="button" onclick="nextupload()" class="cz-form-content-input-button boton-eject"
                                    value="Ejecutar" />
                            </div>
                            <div id="cz-form-table">
                                <div class="form-grid-table-outer" style="overflow: auto;">
                                    <div class="form-grid-table-inner">
                                        <div class="form-gridview-data" id="divGridViewData">
                                        </div>
                                        <div class="form-gridview-search" id="divGridViewSearch" runat="server">
                                            <img src="../../images/icons/loader/ico_loader-arrow-orange.gif" />
                                            <p>
                                                obteniendo resultados
                                            </p>
                                        </div>
                                        <div class="divUploadNew" style="display: none;">
                                            <%--<input type="button" onclick="newupload()" class="form-button cz-form-content-input-button"
                                    value="Nueva Carga" />--%>
                                            <div class="col-sm-9 col-md-9 form-group hidden-sx">
                                            </div>
                                            <div class="col-sx-12 col-sm-3 col-md-3 form-group">
                                                <button type="button" onclick="newupload()"
                                                    class="btn btn-danger"
                                                    style="/* float: right */width: 100%; margin: unset;">
                                                    <i class="fas fa-arrow-left iconButton"></i>
                                                    Nueva Carga
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div id="file-upload-template" style="display: none">
                                <div id="file-boton-box" class="qq-uploader">
                                    <div class="qq-upload-button">
                                    </div>
                                    <div class='boton-ejecutar' style="display: none; position: relative; top: -22px; left: 240px;">
                                        <img src='../../images/icons/carga/ico_carga_exc.png' />
                                    </div>
                                </div>
                                <div id="file-upload-panel">
                                    <ul class="qq-upload-list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divUtilitarios" class="cz-form-box-content cz-util-nopad">
                        <p>
                            <%=Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.ETI_ACC_CAR).Substring(0,1).ToUpper() + Model.bean.IdiomaCultura.getMensajeEncodeHTML(Model.bean.IdiomaCultura.ETI_ACC_CAR).Substring(1) %>
                        </p>
                        <div id="cz-form-nota">
                            <div class="cz-form-box-content-subtitle cz-util-pad-min">
                                <p>Ayuda</p>
                            </div>
                            <asp:Literal ID="MenuUtilitario" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true" >
    </div>--%>
    </form>
    <script type="text/javascript">
        function inicializarUploader() {
            var uploader = new qq.FileUploader({
                element: document.getElementById('file-uploader'),
                action: 'Upload.ashx',
                debug: false,
                allowedExtensions: ['xlsx'],
                template: $("#file-upload-template").html(),
                fileTemplate: '<li> ' +
                          '		<div class="file-info-space"> ' +
                          '    		<div class="file-info-box"> ' +
                          '				<div class="file-info-border"> ' +
                          '           		<div class="file-info-name"><span class="qq-upload-file"></span></div> ' +
                          '               	<div class="file-info-percentage"><span class="qq-upload-spinner"></span></div> ' +
                          '               	<div class="file-info-size"><span class="qq-upload-size"></span></div> ' +
                          '               	<div class="file-info-name"><a class="qq-upload-cancel" href="#">Cancel</a></div> ' +
                          '               	<div class="file-info-name"><span class="qq-upload-failed-text">Failed</span></div> ' +
                          '          	</div> ' +
                          '			</div> ' +
                          '		</div> ' +
                          '</li> ',
                onComplete: function (id, file, responseJSON) {
                    var fileName = file.replace('undefined', '');
                    $(this.element).find('.qq-upload-list li').each(function () {
                        if ($(this).attr('qqFileId') == id) {
                            $(this).find('.file-info-space').attr('id', "fsp-" + str_validate(fileName));
                            $(this).find('.file-info-box').attr('id', "fbx-" + str_validate(fileName));
                            $(this).find('.file-info-border').attr('id', "fbd-" + str_validate(fileName));
                            //    $(this).find('.file-info-box').append("<div class='boton-ejecutar' id='exc-" + str_validate(file) + "' idclass='" + str_validate(file) + "' filename='" + file + "'><img src='../images/icons/carga/ico_carga_exc.png' /></div>");
                            $(this).find(".file-info-box").append("<div class='boton-borrar' id='del-" + str_validate(fileName) + "' idclass='" + str_validate(fileName) + "' filename='" + fileName + "' error='no'><img src='../../images/icons/carga/ico_carga_del.png' /></div>");
                            $('.boton-ejecutar').show();
                            accionesCarga();
                        }
                    });

                }
            });
        }

        // in your app create uploader as soon as the DOM is ready
        // don't wait for the window to load  
        window.onload = inicializarUploader;

        function str_validate(text) {

            text = text.replace(/[^-a-zA-Z0-9,&\s]+/ig, '');
            text = text.replace(/-/gi, "_");
            text = text.replace(/\s/gi, "-");

            return text;

        }

        // acciones


    </script>
</body>
</html>
