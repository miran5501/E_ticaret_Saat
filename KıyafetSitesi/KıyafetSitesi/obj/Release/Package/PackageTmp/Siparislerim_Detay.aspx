<%@ Page Title="" Language="C#" MasterPageFile="~/Profilim.master" AutoEventWireup="true" CodeBehind="Siparislerim_Detay.aspx.cs" Inherits="KıyafetSitesi.Siparislerim_Detay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
    <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 add-new-invoice">
        <div class="">
            <div class="mb-6 mb-xl-0">
                <div class="card card-body main-invoice-info p-6">
                    <div class="row mb-7">
                        <div class="col-sm-6 col-12 mr-auto mb-6">
                            <div class="d-flex align-items-center">
                                <img class="company-logo" src="images/logo.png" alt="company">
                            </div>
                        </div>
                        <div class="col-sm-6 text-sm-right mb-6">
                            <p class="fs-18 mb-0"><span class="inv-title">Invoice : </span><span class="text-primary">#0001</span></p>
                        </div>

                        <div class="col-sm-6 align-self-center mt-3">
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Müşteri Adı: </span>
                                <asp:Label ID="lblSiparisVerenAdi" runat="server"></asp:Label>
                            </p>
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Müşteri E-mail: </span>
                                <asp:Label ID="lblSiparisVerenEmail" runat="server"></asp:Label>
                            </p>
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Müşteri Telefon Numarası: </span>
                                <asp:Label ID="lblSiparisVerenTelefon" runat="server"></asp:Label>
                            </p>
                        </div>
                        <div class="col-sm-6 align-self-center mt-3 text-sm-right">
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Sipariş Durumu: </span>
                                <span class="inv-date">
                                    <asp:Label ID="lblSiparisDurumu" runat="server" CssClass="inv-date"></asp:Label>
                                </span>
                            </p>
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Sipariş Tarihi: </span>
                                <span class="inv-date">
                                    <asp:Label ID="lblSiparisTarihi" runat="server" CssClass="inv-date"></asp:Label>
                                </span>
                            </p>
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Kargoya verilme tarihi: </span>
                                <span class="inv-date">
                                    <asp:Label ID="lblKargoyaVerilmeTarihi" runat="server" CssClass="inv-date"></asp:Label>
                                </span>
                            </p>
                            <p class="mb-0">
                                <span class="text-heading font-weight-500">Teslim edilme tarihi: </span>
                                <span class="inv-date">
                                    <asp:Label ID="lblTeslimEdilmeTarihi" runat="server" CssClass="inv-date"></asp:Label>
                                </span>
                            </p>
                        </div>

                    </div>
                    <div class="border-top pt-7 mb-7">
                        <div class="row">
                            <div class="col-xl-8 col-md-6 col-sm-4 align-self-center">
                                <h6 class="card-title mb-5 text-heading fs-22 lh-15">Teslim Adresi</h6>
                            </div>
                            <div class="col-xl-4 col-md-6 col-sm-8 align-self-center order-sm-0 order-1 text-sm-right">
                                
                            </div>
                            <div class="col-xl-8 col-md-6 col-sm-4 align-self-center mb-6 mb-md-0">
                                <p class="mb-0">
                                    <span class="text-heading font-weight-500">Sipariş Teslim Adresi:</span>
                                    <span>
                                        <asp:Label ID="lblSiparisAdresi" runat="server" CssClass="inv-date"></asp:Label></span>
                                </p>
                                <p class="mb-0">
                                    <span class="text-heading font-weight-500">Fatura Teslim Adresi: </span>
                                    <span>
                                        <asp:Label ID="lblFaturaAdresi" runat="server" CssClass="inv-date"></asp:Label></span>
                                </p>
                            </div>
                            <div class="col-xl-4 col-md-6 col-sm-8 align-self-center order-sm-0 order-1 text-sm-right">

                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col"></th>
                                    <th scope="col">Ürün Adı</th>
                                    <th class="text-right" scope="col">Adet</th>
                                    <th class="text-right" scope="col">Birim Fiyat</th>
                                    <th class="text-right" scope="col">Toplam Fiyat</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="RepeaterSiparisUrunleri" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# (Container.ItemIndex + 1).ToString() %></td>
                                            <td>
                                                <img src="<%# Eval("UrunResmi") %>" alt="Danny Fox" class="mr-sm-2 mb-4 mb-sm-0" style="min-width: 100px; width: 100px; height: 100px;"></td>
                                            <td><%# Eval("UrunAdi") %></td>
                                            <td class="text-right"><%# Eval("SiparisUrunAdet") %></td>
                                            <td class="text-right">₺<%# string.Format("{0:F2}", Eval("SiparisUrunFiyatBirim")) %></td>
                                            <td class="text-right">₺<%# string.Format("{0:F2}", Eval("SiparisUrunFiyatToplam")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                    <div class="row mt-4">
                        <div class="col-sm-5 col-12 order-sm-0 order-1">
                        </div>
                        <div class="col-sm-7 col-12 order-sm-1 order-0">
                            <div class="text-sm-right">
                                <div class="row">
                                    <div class="col-7">
                                        <p class="mb-1">Ürünler Toplam: </p>
                                    </div>
                                    <div class="col-5">
                                        <p class="mb-1">$3155</p>
                                    </div>
                                    <div class="col-7">
                                        <p class="mb-1">Kargo Ücreti: </p>
                                    </div>
                                    <div class="col-5">
                                        <p class="mb-1">$700</p>
                                    </div>
                                    <div class="col-7">
                                        <p class="discount-rate">İndirim : <span class="discount-percentage">5%</span></p>
                                    </div>
                                    <div class="col-5">
                                        <p class="mb-1">$10</p>
                                    </div>
                                    <div class="col-7 grand-total-title mt-4">
                                        <h4 class="text-heading fs-22 lh-15">Toplam Tutar : </h4>
                                    </div>
                                    <div class="col-5 grand-total-amount mt-4">
                                        <h4 class="text-heading fs-22 lh-15"><asp:Label ID="lblToplamTutar" runat="server"></asp:Label></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="border-top pt-6 mt-7">
                        <div class="row">
                            <div class="col-sm-12 col-12 order-sm-0 order-1">
                                <p class="mb-0">Note: Thank you for doing Business with us.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</asp:Content>
