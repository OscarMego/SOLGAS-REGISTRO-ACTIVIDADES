<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GrupoGrid.aspx.cs" Inherits="View.Mantenimiento.Grupo.GrupoGrid" %>

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
                            <input id='<%# (Eval("tipoStyle")==""?Eval("IDGrupo"):"") %>' style="<%# Eval("tipoStyle") %>" 
                                value="<%# (Eval("tipoStyle")==""?Eval("IDGrupo"):"") %>" type="checkbox">
                            <div class="btnmovil">
                                <button type="button" class="btn nuevo movil <%# Eval("tipoStyle") %> editItemReg" title="Editar"
                                    cod="<%# Eval("IDGrupo") %>" style="<%# Eval("tipoStyle") %>">
                                    <i class="fas fa-pencil-alt"></i>
                                </button>
                                <a class="changeOption <%# Eval("tipoStyle") %> delItemReg" cod="<%# Eval("IDGrupo") %>" style="<%# Eval("tipoStyle") %>">
                                    <i class="far fa-trash-alt"></i></a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ItemStyle-HorizontalAlign="Center" />
                    <%--<asp:BoundField DataField="Nivel" HeaderText="Nivel" ItemStyle-HorizontalAlign="Center" />--%>
                    <asp:BoundField DataField="PadreDescrip" HeaderText="Padre" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="grupoDescrip" HeaderText="Grupo" ItemStyle-HorizontalAlign="Center" />

                    <asp:TemplateField ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="tbmovil">
                        <HeaderTemplate>
                            <i class="fas fa-pencil-alt"></i>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <button type="button" class="btn nuevo editItemReg" style="<%# Eval("tipoStyle") %>" title="Editar"
                                cod="<%# Eval("IDGrupo") %>">
                                <i class="fas fa-pencil-alt"></i>
                            </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="5%" ItemStyle-CssClass="tbmovil" ItemStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <i class="far fa-trash-alt"></i>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <button type="button" class="btn nuevo changeOption delItemReg" style="<%# Eval("tipoStyle") %>" title="Borrar"
                                cod="<%# Eval("IDGrupo") %>">
                                <i class="fa fa-trash-alt"></i>
                            </button>
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
        <script>
            $('#grdMant').cardtable();

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
                } else {
                    urlImg = "../../imagery/all/icons/restaurar.png";
                    $('.changeOption').removeClass('delItemReg').addClass('restItemReg').attr('title', 'Restaurar');
                    $('.changeOption').find('i').removeClass('fa-trash-alt').addClass('fa-redo-alt');
                }
            }

        </script>
    </form>
</body>
</html>
