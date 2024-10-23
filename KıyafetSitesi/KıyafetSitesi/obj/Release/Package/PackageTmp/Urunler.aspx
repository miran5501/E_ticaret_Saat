<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSayfa.Master" AutoEventWireup="true" CodeBehind="Urunler.aspx.cs" Inherits="KıyafetSitesi.Urunler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
    </style>
    <title>Miran Eser | Ürünler</title>

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content">
        <section class="pb-4 page-title shadow">
            <div class="container container-xxl">
                <nav aria-label="breadcrumb">

                    <ol class="breadcrumb pt-6 pt-lg-2 lh-15 mt-lg-10">
                        <li class="breadcrumb-item"><a href="AnaSayfa.aspx">Ana Sayfa</a></li>
                        <li id="urunlerItem" runat="server" class="breadcrumb-item"><a href="Urunler.aspx">Ürünler</a></li>
                        <li id="kategoriItem" runat="server" class="breadcrumb-item" aria-current="page"></li>
                    </ol>


                    <div class="mt-6 form-search-01">
                        <div class="form-inline mx-n1" id="accordion-5">
                            <%-- HATA DROPDOWNLARDA SEÇİMİ ZORUNLU OLABİLİR--%>
                            <asp:Repeater ID="rptOzellikTanimlari" runat="server" OnItemDataBound="rptOzellikTanimlari_ItemDataBound">
                                <ItemTemplate>
                                    <div class="form-group p-1">
                                        <asp:Label ID="lblOzellikAdi" runat="server" Text='<%# Eval("OzellikAdi") %>' CssClass="sr-only"></asp:Label>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle form-control border-0 shadow-xxs-1 bg-transparent font-weight-600 selectpicker dropdownbuton"
                                                type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: gray;">
                                                <%# Eval("OzellikAdi") %>
                                            </button>
                                            <div class="dropdown-menu">
                                                <asp:CheckBoxList ID="chkOzellikDegerleri" runat="server" AutoPostBack="true"
                                                    OnSelectedIndexChanged="chk_SelectedIndexChanged">
                                                </asp:CheckBoxList>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>
                </nav>
            </div>
        </section>



        <%--YUKARISI FİLTRELEME YERİ--%>


        <section class="pt-6 pb-7">
            <div class="container container-xxl">
                <div class="row align-items-sm-center">
                    <div class="col-md-6">
                        <h2 class="fs-15 text-dark mb-0">Sizin için<span class="text-primary">
                            <asp:Label ID="lblPropertyCount" runat="server" Text="0"></asp:Label></span> Adet Ürün Bulabildik</h2>

                    </div>
                    <div class="col-md-6 mt-6 mt-md-0">
                        <div class="d-flex justify-content-md-end align-items-center">
                            <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control border-0 bg-transparent shadow-none p-0 selectpicker sortby siralama" AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                                <asp:ListItem Text="Top Selling" Value="top-selling"></asp:ListItem>
                                <asp:ListItem Text="Most Viewed" Value="most-viewed"></asp:ListItem>
                                <asp:ListItem Text="Price (low to high)" Value="price-low-high"></asp:ListItem>
                                <asp:ListItem Text="Price (high to low)" Value="price-high-low"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%--ÜRÜNLER BAŞLANGIÇ--%>

        <section class="pb-11">
            <div class="container container-xxl">
                <div class="row mx-n2">
                    <asp:Repeater ID="RepeaterTumUrunler" runat="server">
                        <ItemTemplate>
                            <div class="col-6 col-xxl-3 col-lg-3 col-md-4 mb-7 px-2">
                                <%--data-animate="fadeInUp"--%>
                                <div class="card border-0 hover-change-image ">
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

                                                            <label class="ui-like ml-auto" style='<%# Session["KullaniciID"] == null ? "display:none;": "" %>'>
                                                                <asp:HiddenField ID="HiddenFieldUrunID" runat="server" Value='<%# Eval("UrunID") %>' />
                                                                <asp:CheckBox ID="CheckBoxFavorilereEkle" runat="server"
                                                                    OnCheckedChanged="CheckBoxFavorilereEkle_CheckedChanged" AutoPostBack="true" EnableViewState="True" />
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
                                                            <label class="ui-like ml-auto" style='<%# Session["KullaniciID"] == null ? "": "display:none;" %>'>
                                                                <a data-toggle="modal" href="#login-register-modal">
                                                                    <div class="like">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="">
                                                                            <g stroke-width="0" id="SVGRepo_bgCarrier"></g>
                                                                            <g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g>
                                                                            <g id="SVGRepo_iconCarrier">
                                                                                <path d="M20.808,11.079C19.829,16.132,12,20.5,12,20.5s-7.829-4.368-8.808-9.421C2.227,6.1,5.066,3.5,8,3.5a4.444,4.444,0,0,1,4,2,4.444,4.444,0,0,1,4-2C18.934,3.5,21.773,6.1,20.808,11.079Z"></path>
                                                                            </g>
                                                                        </svg>
                                                                    </div>
                                                                </a>
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
                                        <h2 class="fs-16 mb-2"><a href="UrunBilgisi.aspx?id=<%# Eval("UrunID") %>" class="text-dark hover-primary text-truncate"><%# Eval("UrunAdi") %></a></h2>
                                        <p class="font-weight-500 text-gray-light mb-2"><%# Eval("Marka") %></p>
                                        <div runat="server" id="divNormalFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) != 1 %>'>
                                            <span class="fs-17 font-weight-bold text-heading mb-1">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></span>
                                        </div>

                                        <div runat="server" id="divIndirimliFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>
                                            <span class="font-weight-500 text-gray-light mb-1 old-price mr-2">₺<%# string.Format("{0:F2}", Eval("IndirimsizFiyat")) %></span>
                                            <span class="fs-17 font-weight-bold text-heading mb-1 new-price">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %>
                                            </span>
                                        </div>

                                        <%--<ul class="list-inline mb-0">
                                            <li class="list-inline-item text-gray font-weight-500 fs-13 mr-sm-4" data-toggle="tooltip" title="3 Bedroom">
                                                <svg class="icon icon-bedroom fs-18 text-primary mr-1">
                                                    <use xlink:href="#icon-bedroom"></use>
                                                </svg>
                                                3 Br
                                            </li>
                                            <li class="list-inline-item text-gray font-weight-500 fs-13 mr-sm-4" data-toggle="tooltip" title="3 Bathrooms">
                                                <svg class="icon icon-shower fs-18 text-primary mr-1">
                                                    <use xlink:href="#icon-shower"></use>
                                                </svg>
                                                3 Ba
                                            </li>
                                            <li class="list-inline-item text-gray font-weight-500 fs-13 mr-sm-4" data-toggle="tooltip" title="Size">
                                                <svg class="icon icon-square fs-18 text-primary mr-1">
                                                    <use xlink:href="#icon-square"></use>
                                                </svg>
                                                2300 Sq.Ft
                                            </li>
                                            <li class="list-inline-item text-gray font-weight-500 fs-13" data-toggle="tooltip" title="1 Garage">
                                                <svg class="icon icon-Garage fs-18 text-primary mr-1">
                                                    <use xlink:href="#icon-Garage"></use>
                                                </svg>
                                                1 Gr
                                            </li>
                                        </ul>--%>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="mt-5">
                                                    <asp:Button ID="BtnSepeteEkle" runat="server" Text="Sepete Ekle" OnClick="BtnSepeteEkle_Click" CssClass="btn badge-primary btn" Style='<%# Session["KullaniciID"] == null ? "display:none;": "" %>' />
                                                    <a data-toggle="modal" class="btn badge-primary btn" href="#login-register-modal" style='<%# Session["KullaniciID"] == null ? "": "display:none;" %>'>Sepete Ekle</a>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <%--<div class="col-12 text-center mt-1">
                                    <asp:Button ID="btnViewMore" runat="server" Text="Show More" OnClick="btnViewMore_Click" class="btn btn-lg btn-outline-accent text-heading shadow-none border-2x d-inline-flex align-items-center" />
                                </div>--%>
                </div>
            </div>
        </section>
        <asp:Panel ID="PanelSepet" runat="server" CssClass="w-100">

            <div id="compare" class="compare">

                <button class="btn shadow btn-open bg-white bg-hover-accent text-secondary rounded-right-0 d-flex justify-content-center align-items-center w-30px h-140 p-0">
                </button>
                <div class="list-group list-group-no-border bg-dark py-3">
                    <a href="#" class="list-group-item bg-transparent text-white fs-22 text-center py-0">
                        <i class="far fa-bars"></i>
                    </a>
                    <asp:UpdatePanel ID="UpdatePanelSepetimdekiler" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Repeater ID="RepeaterSepetIcerik" runat="server">
                                <ItemTemplate>
                                    <div class="list-group-item card card bg-transparent">
                                        <div class="position-relative hover-change-image bg-hover-overlay ">
                                            <img src="<%# Eval("UrunResmi") %>" class="card-img" alt="properties">
                                            <div class="card-img-overlay">

                                                <label class="ui-like2 hover-image pos-fixed-top-right position-absolute m-2">
                                                    <asp:Button ID="ButtonSepetimdenCikar" runat="server" CssClass="btn-like" OnClick="BtnSepetimdenCikar_Click" CommandArgument='<%# Eval("IcerikID") %>' />
                                                    <div class="like text-white hover">
                                                        <i class="fal fa-minus-circle"></i>
                                                    </div>
                                                </label>

                                                <%--<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Remove.png" CssClass="btn-transparent text-white hover-image fs-16 lh-1 pos-fixed-top-right position-absolute m-2 icon-button" />--%>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="list-group-item bg-transparent">
                        <a href="Sepetim.aspx" class="btn btn-lg btn-primary w-100 px-0 d-flex justify-content-center">Sepetim
            </a>
                    </div>
                </div>

            </div>
        </asp:Panel>
        <%--SAĞ TARAF BURAYI DAHA SONRA KULLAN--%>
    </main>


</asp:Content>
