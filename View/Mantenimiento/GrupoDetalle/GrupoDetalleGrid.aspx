<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GrupoDetalleGrid.aspx.cs" Inherits="Mantenimiento_GrupoDetalle_GrupoDetalleGrid" %>

<!DOCTYPE html>
<html lang="es">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divGridViewPagintatorTop" class="container" runat="server">
            <div class="row">
                <div class="col-sm-8 col-lg-8">
                    <div class="pg">
                        <div class="row">
                            <h5 class="txpag">Página</h5>
                            <div class="pagination">
                                <ul>
                                    <li><a id="linkPaginaAnteriorTop" title="Anterior" class="pagina-anterior" runat="server">«</a></li>
                                    <li class="active"><a id="linkPaginaTop" runat="server">1</a>
                                    <li><a id="linkPaginaSiguienteTop" class="pagina-siguiente" runat="server">»</a></li>
                                </ul>
                            </div>
                            <h5 class="txt">de 
                        <asp:Label ID="lbTpaginaTop" class="pagina-maxima" runat="server" Text="1"></asp:Label>
                            </h5>
                            <div class="mostrar">
                                <label for="ddlMostrarTop">Mostrar</label>
                                <asp:DropDownList ID="ddlMostrarTop" runat="server" CssClass="list-pag"></asp:DropDownList>
                            </div>

                            <div class="mostrar">
                                <h6>Se encontraron
                                    <asp:Label ID="lblTFilasTop" runat="server" Text="1"></asp:Label>
                                    registro(s)</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="divGridView" class="tb-pc" runat="server">
            <div class="head-gri"><input id="ChkAll" name="chkSelectAll" type="checkbox"></div>
            <asp:GridView ID="grdMant" GridLines="None" AlternatingRowStyle-CssClass="file"
                runat="server" AutoGenerateColumns="False"
                CssClass="grilla table" Style="width: 100%;">
                <Columns>
                    <asp:TemplateField ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                        <HeaderTemplate>
                            <input id="ChkAll" name="chkSelectAll" type="checkbox" class="tbmovil">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <input id='<%# Eval("IdGrupoDetalle") %>' value="<%# Eval("IdGrupoDetalle") %>" type="checkbox">
                            <div class="btnmovil">
                                <button type="button" class="btn nuevo movil editItemReg" title="Editar"
                                    cod="<%# Eval("IdGrupoDetalle") %>"">
                                    <i class="fas fa-pencil-alt"></i>
                                </button>
                                <a class="changeOption delItemReg" cod="<%# Eval("IdGrupoDetalle") %>""><i class="far fa-trash-alt"></i></a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="item" HeaderText="Item" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40px" />--%>
                    <asp:BoundField DataField="Grupo" HeaderText="Grupo" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Padre" HeaderText="Padre" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DetallePadre" HeaderText="Detalle Padre" ItemStyle-HorizontalAlign="Center" />

                    <asp:TemplateField ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="tbmovil">
                        <HeaderTemplate>
                            <i class="fas fa-pencil-alt"></i>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <button type="button" class="btn nuevo editItemReg" title="Editar"
                                cod="<%# Eval("IdGrupoDetalle") %>">
                                <i class="fas fa-pencil-alt"></i>
                            </button>
                            <%--<a class="editItemReg" style="cursor: pointer;" data-toggle="modal" 
                           cod="<%# Eval("id") %>">
                            <img src="../../imagery/all/icons/modificar.png" border="0" title="Editar" /></a>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="5%" ItemStyle-CssClass="tbmovil" ItemStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <i class="far fa-trash-alt"></i>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <button type="button" class="btn nuevo changeOption delItemReg" title="Borrar"
                                cod="<%# Eval("IdGrupoDetalle") %>">
                                <i class="fa fa-trash-alt"></i>
                            </button>
                            <%--<a  role="button" data-toggle="modal" style="cursor: pointer;" class="delItemReg changeOption form-icon"
                            cod="<%# Eval("id") %>">
                            <img src="../../imagery/all/icons/eliminar.png" border="0" title="Eliminar" /></a>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div id="divGridViewPagintatorBooton" class="container" runat="server">
            <div class="row">
                <div class="col-sm-8 col-lg-8">
                    <div class="pg">
                        <div class="row">
                            <h5 class="txpag">Página</h5>
                            <div class="pagination">
                                <ul>
                                    <li><a id="linkPaginaAnteriorBooton" title="Anterior" class="pagina-anterior" runat="server">«</a></li>
                                    <li class="active"><a id="linkPaginaBooton" runat="server">1</a>
                                    <li><a id="linkPaginaSiguienteBooton" class="pagina-siguiente" runat="server">»</a></li>
                                </ul>
                            </div>
                            <h5 class="txt">de 
                        <asp:Label ID="lbTpaginaBooton" class="pagina-maxima" runat="server" Text="1"></asp:Label>
                            </h5>
                            <div class="mostrar">
                                <label for="ddlMostrarBooton">Mostrar</label>
                                <asp:DropDownList ID="ddlMostrarBooton" runat="server" CssClass="list-pag"></asp:DropDownList>
                            </div>

                            <div class="mostrar">
                                <h6>Se encontraron
                                    <asp:Label ID="lblTFilasBooton" runat="server" Text="1"></asp:Label>
                                    registro(s)</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div id="divGridViewPagintator" class="paginator-table" runat="server">
        <div class="paginator-table-outer">
            <div class="paginator-table-inner">
                <div class="paginator-data">
                    <div class="cz-page-ant">
                        <p class="pagina-direccion">
                            <asp:Label ID="lbPaginaAnterior" CssClass="pagina-anterior" runat="server" Text="anterior"></asp:Label>
                        </p>
                    </div>
                    <div class="cz-page-now">
                        <a>Página</a>
                        <p class="pagina-actual">
                            <asp:TextBox ID="lbPagina" CssClass="pagina-editor" runat="server"></asp:TextBox>
                        </p>
                        <p class="pagina-direccion">
                            <span class="pagina-data">de </span>
                            <asp:Label ID="lbTpagina" class="pagina-maxima" runat="server" Text="1"></asp:Label>
                        </p>
                    </div>
                    <div class="cz-page-des">
                        <asp:Label ID="lbPaginaSiguiente" CssClass="pagina-siguiente" runat="server" Text="siguiente"></asp:Label></p>
                    </div>
                </div>
                <div class="paginator-data-search">
                    <img src="../../images/icons/loader/ico_loader-arrow-grey.gif" />
                    <p>
                        buscando resultados</p>
                </div>
            </div>
        </div>
        <div class="cz-table-expand"><div class="cz-table-expand-close-x">×</div></div>
    </div>--%>
        <script>
            $(document).on('click', '#run', function (e) {
                e.preventDefault();
                $('#simple-example-table').stacktable();
                $(this).replaceWith('<span>ran - resize your window to see the effect</span>');
            });
            $('#responsive-example-table').stacktable({ myClass: 'your-custom-class' });
            $('#card-table').cardtable();
            $('#grdMant').cardtable();

            $('#agenda-example').stackcolumns();
        </script>
        <script type="text/javascript">

            $(document).ready(function () {
                changeOptionDel();
            });

            function changeOptionDel() {
                var grid = document.getElementById('<%= grdMant.ClientID %>');
                var urlImg = "../../imagery/all/icons/eliminar.png";
                if ($("#chkhabilitado").is(":checked")) {
                    urlImg = "../../imagery/all/icons/eliminar.png";
                    $('.changeOption').removeClass('restItemReg').addClass('delItemReg').val('Borrar');
                    $('.changeOption').find('i').removeClass('fa-redo-alt').addClass('fa-trash-alt');
                    //$('#DivDelContenedor').show();
                    //$('#DivRestContenedor').hide();
                } else {
                    urlImg = "../../imagery/all/icons/restaurar.png";
                    $('.changeOption').removeClass('delItemReg').addClass('restItemReg').attr('title', 'Restaurar');
                    $('.changeOption').find('i').removeClass('fa-trash-alt').addClass('fa-redo-alt');
                    //$('#DivDelContenedor').hide();
                    //$('#DivRestContenedor').show();
                }
            }


        </script>
    </form>
</body>
</html>
