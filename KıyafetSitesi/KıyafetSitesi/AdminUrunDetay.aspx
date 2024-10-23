<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="AdminUrunDetay.aspx.cs" Inherits="KıyafetSitesi.AdminUrunDetay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 add-new-invoice">
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                    <div class="row">
                        <div class="col-xl-9 mb-6 mb-xl-0">
                            <div class="card">
                                <div class="card-body p-6">
                                    <div class="row mb-6">
                                        <asp:Repeater ID="RepeaterTumUrunler" runat="server">
                                            <ItemTemplate>
                                                <div class="card border-0 hover-change-image col-md-6">
                                                    <div class="bg-hover-overlay rounded-lg card-img">
                                                        <img src="<%# Eval("UrunResmi") %>" alt="Home in Metric Way">
                                                        <div class="card-img-overlay p-2 d-flex flex-column">
                                                            <div class="card-img-overlay p-2 d-flex flex-column">
                                                                <asp:UpdatePanel ID="UpdatePanelFavori" runat="server" UpdateMode="Conditional">
                                                                    <ContentTemplate>
                                                                        <div class="d-flex justify-content-between">
                                                                            <span class="badge badge-danger" style="max-height: 25px;" runat="server" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>%<%# Eval("Indirimyüzdesi") %>
                                                                            </span>

                                                                            <span></span>

                                                                            <label class="ui-like ml-auto">
                                                                                <asp:CheckBox ID="CheckBoxFavorilereEkle" runat="server" AutoPostBack="true" EnableViewState="True" />
                                                                                <div class="like">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="">
                                                                                        <g stroke-width="0" id="SVGRepo_bgCarrier1"></g>
                                                                                        <g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier1"></g>
                                                                                        <g id="SVGRepo_iconCarrier1">
                                                                                            <path d="M20.808,11.079C19.829,16.132,12,20.5,12,20.5s-7.829-4.368-8.808-9.421C2.227,6.1,5.066,3.5,8,3.5a4.444,4.444,0,0,1,4,2,4.444,4.444,0,0,1,4-2C18.934,3.5,21.773,6.1,20.808,11.079Z"></path>
                                                                                        </g>
                                                                                    </svg>
                                                                                </div>
                                                                            </label>

                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                <ul class="list-inline mb-0 d-flex align-items-end mr-n3">
                                                                    <!-- Diğer içerik burada kalabilir -->
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-body pt-3 px-0 pb-1">
                                                        <h2 class="fs-16 mb-2">
                                                            <p class="text-dark text-truncate"><%# Eval("UrunAdi") %></p>
                                                        </h2>
                                                        <p class="font-weight-500 text-gray-light mb-2">1421 San Pedro St, Los Angeles</p>
                                                        <div runat="server" id="divNormalFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) != 1 %>'>
                                                            <span class="fs-17 font-weight-bold text-heading mb-1">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></span>
                                                        </div>

                                                        <div runat="server" id="divIndirimliFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>
                                                            <span class="font-weight-500 text-gray-light mb-1 old-price mr-2">₺<%# string.Format("{0:F2}", Eval("IndirimsizFiyat")) %></span>
                                                            <span class="fs-17 font-weight-bold text-heading mb-1 new-price">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %>
                                                            </span>
                                                        </div>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <div class="mt-5">
                                                                    <asp:Button ID="BtnSepeteEkle" runat="server" Text="Sepete Ekle" CssClass="btn badge-primary btn" />
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <div class="col-md-6">
                                            <div class="galleries position-relative">
                                                <div class="slick-slider slider-for-01 arrow-haft-inner mx-0" data-slick-options='{"slidesToShow": 1, "autoplay":false,"dots":false,"arrows":true}'>
                                                    <asp:Repeater ID="RepeaterUrunResimler1" runat="server">
                                                        <ItemTemplate>
                                                            <div class="box px-0">
                                                                <div class="item" style="height: 380px;">
                                                                    <div class="card p-0 hover-change-image">
                                                                        <a href="<%# Eval("UrunResmi") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunResmi") + ")" %>"></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="box px-0">
                                                                <div class="item" style="height: 380px;">
                                                                    <div class="card p-0 hover-change-image">
                                                                        <a href="<%# Eval("UrunYanResmi1") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunYanResmi1") + ")" %>"></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="box px-0">
                                                                <div class="item" style="height: 380px;">
                                                                    <div class="card p-0 hover-change-image">
                                                                        <a href="<%# Eval("UrunYanResmi2") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunYanResmi2") + ")" %>"></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                </div>
                                                <div class="slick-slider slider-nav-01 mt-4 mx-n1 arrow-haft-inner" data-slick-options='{"slidesToShow": 3, "autoplay":false,"dots":false,"arrows":false,"asNavFor": ".slider-for-01","focusOnSelect": true,"responsive":[{"breakpoint": 768,"settings": {"slidesToShow": 3}},{"breakpoint": 576,"settings": {"slidesToShow": 3}}]}'>
                                                    <asp:Repeater ID="RepeaterUrunResimler2" runat="server">
                                                        <ItemTemplate>
                                                            <div class="box pb-6 px-0">
                                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                                    <img src="<%# Eval("UrunResmi") %>" alt="Gallery 01" class="h-100 w-100 rounded-lg">
                                                                </div>
                                                            </div>
                                                            <div class="box pb-6 px-0">
                                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                                    <img src="<%# Eval("UrunYanResmi1") %>" alt="Gallery 01" class="h-100 w-100 rounded-lg">
                                                                </div>
                                                            </div>
                                                            <div class="box pb-6 px-0">
                                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                                    <img src="<%# Eval("UrunYanResmi2") %>" alt="Gallery 01" class="h-100 w-100 rounded-lg">
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

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


                                    <div class="mb-6">
                                        <asp:Button
                                            ID="btnUrunGuncelle"
                                            runat="server"
                                            CssClass="btn btn-secondary"
                                            Text="Ürünü Güncelle"
                                            OnClick="btnGuncelle_Click"
                                            CausesValidation="false" />

                                    </div>


                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <div class="card card-body mb-6 p-6">
                                <div class="invoice-action-currency mb-2">
                                    <div class="form-group mb-0">
                                        <p class="font-weight-500 text-gray-light mb-2"><i class="fal fa-eye mr-1"></i>10000 Kez Görüntülendi</p>
                                    </div>
                                </div>
                                <div class="invoice-action-tax mb-2">
                                    <div class="form-group mb-0">
                                        <p class="font-weight-500 text-gray-light mb-2">Ürün 10000 Kişi tarafından Favorilendi</p>
                                    </div>
                                </div>
                                <div class="invoice-action-discount mb-2">
                                    <div class="form-group mb-0">
                                        <p class="font-weight-500 text-gray-light mb-2">Ürün 10000 Kez Sipariş Edildi</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
