<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="Kullanicilar.aspx.cs" Inherits="KıyafetSitesi.Kullanicilar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 invoice-listing">
            <div class="mb-6">
                <div class="row">
                    <div class="col-sm-12 col-md-6 d-flex justify-content-md-start justify-content-center">
                        <div class="d-flex form-group mb-0 align-items-center">
                            <label for="ddlResults" class="d-block mr-2 mb-0">Results:</label>
                            <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control form-control-lg mr-2 selectpicker"
                                data-style="bg-white btn-lg h-52 py-2 border" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="align-self-center">
                            <button class="btn btn-primary btn-lg" tabindex="0" aria-controls="invoice-list"><span>Add New</span></button>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 d-flex justify-content-md-end justify-content-center mt-md-0 mt-3">
                        <div class="input-group input-group-lg bg-white mb-0 position-relative mr-2">
                            <input type="text" class="form-control bg-transparent border-1x" placeholder="Search..." aria-label="" aria-describedby="basic-addon1">
                            <div class="input-group-append position-absolute pos-fixed-right-center">
                                <button class="btn bg-transparent border-0 text-gray lh-1" type="button"><i class="fal fa-search"></i></button>
                            </div>
                        </div>
                        <div class="align-self-center">
                            <button class="btn btn-danger btn-lg" tabindex="0" aria-controls="invoice-list"><span>Delete</span></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table id="invoice-list" class="table table-hover bg-white border rounded-lg">
                    <thead>
                        <tr role="row">
                            <th class="py-6">Invoice Id</th>
                            <th class="py-6">Adı</th>
                            <th class="py-6">Email</th>
                            <th class="py-6">Telefon Numarası</th>
                            <th class="py-6">Status</th>
                            <th class="no-sort py-6">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepeaterKullanicilar" runat="server">
                            <ItemTemplate>
                                <tr role="row">
                                    <td class="align-middle"><a href='KullaniciDetay.aspx?KullaniciID=<%# Eval("KullaniciID") %>'><span class="inv-number">#<%# Eval("KullaniciID") %></span></a>
                                    </td>
                                    <td class="align-middle">
                                        <div class="d-flex align-items-center">
                                            <p class="align-self-center mb-0 user-name"><%# Eval("KullaniciIsim") %> <%# Eval("KullaniciSoyisim") %></p>
                                        </div>
                                    </td>
                                    <td class="align-middle"><span class="text-primary pr-1"><i class="fal fa-envelope"></i></span><%# Eval("KullaniciE_mail") %></td>
                                    <td class="align-middle"><span class="text-success pr-1"><i class="fal fa-phone"></i></span><%# Eval("KullaniciTelefon_no") %></td>
                                    <td class="align-middle"><span class="badge badge-green text-capitalize"><%# Eval("YetkiDurumu") %></span></td>
                                    <td class="align-middle">
                                        <a href="#" data-toggle="tooltip" title="Edit" class="d-inline-block fs-18 text-muted hover-primary mr-5"><i class="fal fa-pencil-alt"></i></a>
                                        <a href="#" data-toggle="tooltip" title="Delete" class="d-inline-block fs-18 text-muted hover-primary"><i class="fal fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </tbody>
                </table>
            </div>
            <div class="mt-6">
                <nav>
                    <ul class="pagination rounded-active justify-content-center">
                        <asp:Literal ID="paginationList" runat="server"></asp:Literal>
                    </ul>
                </nav>
                <div class="text-center mt-2">
                    <asp:Label ID="resultCountLabel" runat="server" Text="Sonuçlar burada gösterilecek"></asp:Label>
                </div>
            </div>

        </div>
    </main>
</asp:Content>
