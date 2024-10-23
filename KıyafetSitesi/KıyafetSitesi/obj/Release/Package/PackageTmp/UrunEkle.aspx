<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="UrunEkle.aspx.cs" Inherits="KıyafetSitesi.UrunEkle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 add-new-invoice">
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                    <div class="row">
                        <div class="col-xl-12 mb-6 mb-xl-0">
                            <div class="card">
                                <div class="card-body p-6">


                                    <div class="row">
                                        <div class="col-md-6 invoice-address-company">
                                            <h4 class="card-title mb-5 text-heading fs-22 lh-15">From</h4>
                                            <div class="invoice-address-company-fields">
                                                <div class="form-group">
                                                    <asp:Label ID="lblCompanyName" runat="server" AssociatedControlID="txtUrunAdi" CssClass="text-heading">Ürün Adı</asp:Label>
                                                    <asp:TextBox ID="txtUrunAdi" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Ürün Adı" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Label ID="lblCompanyEmail" runat="server" AssociatedControlID="txtUrunFiyati" CssClass="text-heading">Ürün Fiyatı</asp:Label>
                                                    <asp:TextBox ID="txtUrunFiyati" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Ürün Fiyatı (ondalık için ',' kullanınız)" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Label ID="lblUrunstok" runat="server" AssociatedControlID="txtUrunResmi" CssClass="text-heading">Ürün Stok Adet: </asp:Label>
                                                    <asp:TextBox ID="txtUrunstok" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Güncel Stok" />
                                                </div>

                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="form-group">

                                                            <div class="mt-5">
                                                                <asp:Label ID="Label3" runat="server" AssociatedControlID="rblIndirim" CssClass="text-heading">İndirim Seçenekleri</asp:Label>
                                                                <asp:RadioButtonList ID="rblIndirim" runat="server" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="rblIndirim_SelectedIndexChanged">
                                                                    <asp:ListItem Value="Evet">Evet</asp:ListItem>
                                                                    <asp:ListItem Value="Hayır">Hayır</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>



                                                            <asp:Panel ID="pnlIndirimYuzdesi" runat="server" Visible="false">
                                                                <asp:Label ID="lblIndirimYuzdesi" runat="server" AssociatedControlID="txtIndirimYuzdesi" CssClass="text-heading">İndirim Yüzdesi (%):</asp:Label>
                                                                <asp:TextBox ID="txtIndirimYuzdesi" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Yüzde" runat="server"></asp:TextBox>
                                                            </asp:Panel>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <div class="col-md-6 invoice-address-client">
                                            <h4 class="card-title mb-5 text-heading fs-22 lh-15">Bill To</h4>
                                            <div class="invoice-address-client-fields">
                                                <div class="form-group">
                                                    <asp:Label ID="lblCompanyAddress" runat="server" AssociatedControlID="txtUrunResmi" CssClass="text-heading">Ürün Resmi</asp:Label>
                                                    <asp:TextBox ID="txtUrunResmi" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Ürün Resim Linki" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="txtYanResim1" CssClass="text-heading">Yan Resim 1</asp:Label>
                                                    <asp:TextBox ID="txtYanResim1" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Ürün Yan Resim Linki" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="txtYanResim2" CssClass="text-heading">Yan Resim 2</asp:Label>
                                                    <asp:TextBox ID="txtYanResim2" runat="server" CssClass="form-control border-0 shadow-none form-control-lg" Placeholder="Ürün Yan Resim Linki" />
                                                </div>
                                                <div class="form-group">
                                                    <asp:Label ID="lblCompanyPhone" runat="server" AssociatedControlID="ddlUrunTuru" CssClass="text-heading">Ürün Kategori</asp:Label>
                                                    <asp:DropDownList ID="ddlUrunTuru" runat="server" CssClass="form-control border-0 shadow-xxs-1 bg-transparent font-weight-600 selectpicker" Placeholder="Şimdilik Boş" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <%--<div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group mb-4">
                                                <label for="number">Invoice Number</label>
                                                <input type="text" class="form-control border-0 shadow-none form-control-lg" id="number" placeholder="#0001" name="invoice-number">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group mb-4">
                                                <label for="date">Invoice Date</label>
                                                <input type="date" class="form-control form-control-lg border-0" id="date" placeholder="Add date picker" name="available-from">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group mb-4">
                                                <label for="due">Due Date</label>
                                                <input type="date" class="form-control form-control-lg border-0" id="due" placeholder="None" name="available-to">
                                            </div>
                                        </div>
                                    </div>--%>
                                    <div class="mb-6">
                                        <%--<div class="table-responsive">
                                            <table class="table table-bordered item-table">
                                                <thead>
                                                    <tr>
                                                        <th class=""></th>
                                                        <th>Items</th>
                                                        <th class="">Rate</th>
                                                        <th class="">Qty</th>
                                                        <th class="text-right">Price</th>
                                                        <th class="text-center">Tax</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="delete-item-row d-block d-md-table-cell w-100 w-md-auto">
                                                            <ul class="table-controls list-unstyled">
                                                                <li>
                                                                    <a href="javascript:void(0);" class="delete-item" data-toggle="tooltip" data-placement="top" title="" data-original-title="Delete">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x-circle">
                                                                            <circle cx="12" cy="12" r="10"></circle>
                                                                            <line x1="15" y1="9" x2="9" y2="15"></line>
                                                                            <line x1="9" y1="9" x2="15" y2="15"></line>
                                                                        </svg>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td class="description d-block d-md-table-cell w-100 w-md-auto">
                                                            <input type="text" class="form-control border-0 shadow-none form-control-lg mb-3" placeholder="Item Name" name="description[]">
                                                            <select class="form-control border-0 shadow-none form-control-lg" title="Select" id="country" name="unit[]">
                                                                <option>Select your unit</option>
                                                                <option>Hours</option>
                                                                <option>Months</option>
                                                            </select>
                                                        </td>
                                                        <td class="rate d-inline-block d-md-table-cell">
                                                            <input type="text" class="form-control border-0 shadow-none form-control-lg" placeholder="Price" name="price[]">
                                                        </td>
                                                        <td class="text-md-right qty d-inline-block d-md-table-cell">
                                                            <input type="text" class="form-control border-0 shadow-none form-control-lg" placeholder="Quantity" name="quality[]"></td>
                                                        <td class="text-md-right amount d-inline-block d-md-table-cell"><span class="editable-amount"><span class="currency">$</span> <span class="amount">100.00</span></span>
                                                        </td>
                                                        <td class="text-md-center tax d-inline-block d-md-table-cell">
                                                            <div class="n-chk">
                                                                <label class="new-control new-checkbox new-checkbox-text checkbox-primary h-18 mx-auto my-0">
                                                                    <input type="checkbox" class="new-control-input" name="tax[]">
                                                                    <span class="d-inline-block d-md-none">Tax</span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>--%>
                                        <asp:Button
                                            ID="btnAddItem"
                                            runat="server"
                                            CssClass="btn btn-secondary"
                                            Text="Ürünü Ekle"
                                            OnClick="btnAddItem_Click"
                                            CausesValidation="false" />
                                    </div>
                                    <%--<div class="row">
                                        <div class="col-md-6 mb-6">
                                            <div class="shadow-xxs-2 pt-1 pb-2 px-6 border-bottom border-primary border-5x rounded-lg">
                                                <div class="list-group list-group-flush">
                                                    <div class="list-group-item d-flex py-2 px-0">
                                                        <div class="invoice-summary-label">Subtotal</div>
                                                        <div class="font-weight-500 text-heading ml-auto">
                                                            <span class="currency">$</span><span class="amount">100</span>
                                                        </div>
                                                    </div>
                                                    <div class="list-group-item d-flex py-2 px-0">
                                                        <div class="invoice-summary-label">Discount</div>
                                                        <div class="font-weight-500 text-heading ml-auto">
                                                            <span class="currency">$</span><span>10</span>
                                                        </div>
                                                    </div>
                                                    <div class="list-group-item d-flex py-2 px-0">
                                                        <div class="invoice-summary-label">Tax</div>
                                                        <div class="font-weight-500 text-heading ml-auto">
                                                            <span>0%</span>
                                                        </div>
                                                    </div>
                                                    <div class="list-group-item d-flex py-2 px-0">
                                                        <div class="invoice-summary-label">Total</div>
                                                        <div class="font-weight-500 text-heading ml-auto">
                                                            <span class="currency">$</span><span>90</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="invoice-detail-notes" class="text-heading">Notes</label>
                                        <textarea class="form-control border-0 shadow-none form-control-lg" name="note" id="invoice-detail-notes" placeholder="Notes - For example, &quot;Thank you for doing business with us&quot;" style="height: 88px;"></textarea>
                                    </div>--%>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
