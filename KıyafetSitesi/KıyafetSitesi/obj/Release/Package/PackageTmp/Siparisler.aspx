<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="Siparisler.aspx.cs" Inherits="KıyafetSitesi.Siparisler" %>

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
                            <th class="py-6">Sipariş Id</th>
                            <th class="py-6">Adı</th>
                            <th class="py-6">Sipariş Tarihi</th>
                            <th class="py-6">Tutar</th>
                            <th class="py-6">Sipariş Durumu</th>
                            <th class="no-sort py-6">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepeaterSiparisler" runat="server">
                            <ItemTemplate>
                                <tr role="row">

                                    <td class="align-middle">
                                        <a href='Siparis_Detay.aspx?SiparisID=<%# Eval("SiparisID") %>'>
                                            <span class="inv-number">#<%# Eval("SiparisID") %></span>
                                        </a>
                                    </td>
                                    </td>
                                    <td class="align-middle">
                                        <div class="d-flex align-items-center">
                                            <p class="align-self-center mb-0 user-name"><%# Eval("KullaniciIsim") %> <%# Eval("KullaniciSoyisim") %></p>
                                        </div>
                                    </td>
                                    <td class="align-middle"><span class="text-success pr-1"><i class="fal fa-calendar"></i></span><%# Eval("SiparisOlusturmaTarihi") %></td>
                                    <td class="align-middle"><span class="inv-amount">₺<%# string.Format("{0:F2}", Eval("SiparisTutari")) %></span></td>
                                    <td class="align-middle"><span class="badge badge-green text-capitalize"><%# Eval("SiparisDurumu") %></span></td>
                                    <td class="align-middle">
                                        <a href="#" data-toggle="tooltip" title="Edit" class="d-inline-block fs-18 text-muted hover-primary mr-5"><i class="fal fa-pencil-alt"></i></a>
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
                        <asp:Literal ID="litPagination" runat="server"></asp:Literal>
                    </ul>

                </nav>
                <div class="text-center mt-2">
                    <asp:Label ID="resultCountLabel" runat="server" Text="Sonuçlar burada gösterilecek"></asp:Label>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
