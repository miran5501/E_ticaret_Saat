<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="AdminUrunler.aspx.cs" Inherits="KıyafetSitesi.AdminUrunler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10">
            <div class="d-flex flex-wrap flex-md-nowrap mb-6">
                <div class="mr-0 mr-md-auto">
                    <h2 class="mb-0 text-heading fs-22 lh-15">Ürün Sayısı: <span class="badge badge-white badge-pill text-primary fs-18 font-weight-bold ml-2">
                        <asp:Label ID="lblurunsayisi" runat="server" Text="0"></asp:Label></span>
                    </h2>
                    <p>Lorem ipsum dolor sit amet, consec tetur cing elit. Suspe ndisse suscipit</p>
                </div>
                <div class="form-inline justify-content-md-end mx-n2">
                    <div class="d-flex form-group mb-0 align-items-center">
                        <label for="ddlResults" class="d-block mr-2 mb-0">Results:</label>
                        <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control form-control-lg mr-2 selectpicker"
                            data-style="bg-white btn-lg h-52 py-2 border" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="20">20</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="p-2">
                        <div class="input-group input-group-lg bg-white border">
                            <div class="input-group-prepend">
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn pr-0 shadow-none" OnClick="btnSearch_Click" />
                            </div>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control bg-transparent border-0 shadow-none text-body" Placeholder="Search listing" Name="search" />
                        </div>

                    </div>
                    <div class="p-2">
                        <div class="input-group input-group-lg bg-white border">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-transparent letter-spacing-093 border-0 pr-0"><i class="far fa-align-left mr-2"></i>Sort by:</span>
                            </div>
                            <select class="form-control bg-transparent pl-0 selectpicker d-flex align-items-center sortby" name="sort-by" data-style="bg-transparent px-1 py-0 lh-1 font-weight-600 text-body" id="status">
                                <option>Alphabet</option>
                                <option>Price - Low to High</option>
                                <option>Price - High to Low</option>
                                <option>Date - Old to New</option>
                                <option>Date - New to Old</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover bg-white border rounded-lg">
                    <thead class="thead-sm thead-black">
                        <tr>
                            <th scope="col" class="border-top-0 px-6 pt-5 pb-4">Listing title</th>
                            <th scope="col" class="border-top-0 pt-5 pb-4">Date Published</th>
                            <th scope="col" class="border-top-0 pt-5 pb-4">Status</th>
                            <th scope="col" class="border-top-0 pt-5 pb-4">View</th>
                            <th scope="col" class="border-top-0 pt-5 pb-4">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepeaterTumUrunler" runat="server">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenFieldUrunID" runat="server" Value='<%# Eval("UrunID") %>' />
                                <tr class="shadow-hover-xs-2 bg-hover-white">
                                    <td class="align-middle pt-6 pb-4 px-6">
                                        <div class="media">
                                            <div class="w-120px mr-4 position-relative">
                                                <a href="AdminUrunDetay.aspx?id=<%# Eval("UrunID") %>">
                                                    <img src="<%# Eval("UrunResmi") %>" alt="<%# Eval("UrunAdi") %>">
                                                </a>
                                                <span class="badge position-absolute pos-fixed-top <%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 ? "badge-danger" : "d-none" %>">
                                                    <%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 ? "indirimde" : "" %>
                                                </span>

                                            </div>
                                            <div class="media-body">
                                                <a href="AdminUrunDetay.aspx?id=<%# Eval("UrunID") %>" class="text-dark hover-primary">
                                                    <h5 class="fs-16 mb-0 lh-18"><%# Eval("UrunAdi") %></h5>
                                                </a>
                                                <p class="mb-1 font-weight-500">Marka: <%# Eval("Marka") %></p>
                                                <span class="text-heading lh-15 font-weight-bold fs-17">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></span>
                                                <span class="text-gray-light">/month</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="align-middle"><%# Eval("UrunOlusturmaTarihi") %></td>
                                    <td class="align-middle">
                                        <span class="badge text-capitalize font-weight-normal fs-12 badge-yellow">pending</span>
                                    </td>
                                    <td class="align-middle">2049</td>
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
            <nav class="mt-6">
                <ul class="pagination rounded-active justify-content-center" id="paginationList" runat="server"></ul>
            </nav>
            <div class="text-center mt-2">
                <asp:Label ID="resultCountLabel" runat="server" Text="Sonuçlar burada gösterilecek"></asp:Label>
            </div>
        </div>
    </main>
</asp:Content>
