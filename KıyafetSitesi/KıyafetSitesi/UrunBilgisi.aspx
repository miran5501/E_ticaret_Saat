<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSayfa.Master" AutoEventWireup="true" CodeBehind="UrunBilgisi.aspx.cs" Inherits="KıyafetSitesi.UrunBilgisi" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <main id="content">
        <div class="primary-content pt-4">
            <div class="container">
                <div class="row mt-lg-8">
                    <article class="col-lg-12 pr-xl-4">

                        <div class="row">


                            <section class="pb-5 col-lg-6">
                                <div class="galleries position-relative p-4">
                                    <div class="position-absolute pos-fixed-top-right z-index-3">
                                        <ul class="list-inline pt-4 pr-5">
                                            <li class="list-inline-item mr-2">
                                                <asp:UpdatePanel ID="UpdatePanelFavori1" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <label class="ui-like ml-auto" style='<%# Session["KullaniciID"] == null ? "display:none;": "" %>'>
                                                            <asp:CheckBox ID="CheckBoxFavorilereEkle1" runat="server"
                                                                OnCheckedChanged="CheckBoxFavorilereEkle_CheckedChanged1" AutoPostBack="true" EnableViewState="True" />
                                                            <div class="like">
                                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="">
                                                                    <g stroke-width="0" id="SVGRepo_bgCarrier"></g>
                                                                    <g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g>
                                                                    <g id="SVGRepo_iconCarrier">
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

                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </li>
                                            <%--<li class="list-inline-item mr-2">
                                                                    <button type="button" class="btn btn-white p-0 d-flex align-items-center justify-content-center w-40px h-40 text-heading bg-hover-primary hover-white rounded-circle border-0 shadow-none" data-container="body" data-toggle="popover" data-placement="top" data-html="true" data-content="<ul class='list-inline mb-0'>
                                                                    <li class='list-inline-item'>
                                                                        <a href='#' class='text-muted fs-15 hover-dark lh-1 px-2'><i class='fab fa-twitter'></i></a>
                                                                    </li>
                                                                    <li class='list-inline-item '>
                                                                        <a href='#' class='text-muted fs-15 hover-dark lh-1 px-2'><i class='fab fa-facebook-f'></i></a>
                                                                    </li>
                                                                    <li class='list-inline-item'>
                                                                        <a href='#' class='text-muted fs-15 hover-dark lh-1 px-2'><i class='fab fa-instagram'></i></a>
                                                                    </li>
                                                                    <li class='list-inline-item'>
                                                                        <a href='#' class='text-muted fs-15 hover-dark lh-1 px-2'><i class='fab fa-youtube'></i></a>
                                                                    </li>
                                                            </ul>
                                                            ">
                   
                                                            <i class="far fa-share-alt"></i>
                                                            </button>
                                                    </li>--%>
                                        </ul>
                                    </div>

                                    <div class="slick-slider slider-for-01 arrow-haft-inner mx-0" data-slick-options='{"slidesToShow": 1, "autoplay":false,"dots":false,"arrows":true}'>
                                        <asp:Repeater ID="RepeaterUrunResimler1" runat="server">
                                            <ItemTemplate>
                                                <div class="box px-0">
                                                    <div class="item" style="height: 550px;">
                                                        <div class="card p-0 hover-change-image">
                                                            <a href="<%# Eval("UrunResmi") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunResmi") + ")" %>"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="box px-0">
                                                    <div class="item" style="height: 550px;">
                                                        <div class="card p-0 hover-change-image">
                                                            <a href="<%# Eval("UrunYanResmi1") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunYanResmi1") + ")" %>"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="box px-0">
                                                    <div class="item" style="height: 550px;">
                                                        <div class="card p-0 hover-change-image">
                                                            <a href="<%# Eval("UrunYanResmi2") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunYanResmi2") + ")" %>"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <%--<div class="box px-0">
                                                <div class="item item-size-3-2">
                                                    <div class="card p-0 hover-change-image">
                                                        <a href="<%# Eval("UrunResmi") %>" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="<%# "background-image: url(" + Eval("UrunResmi") + ")" %>"></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="box px-0">
                                                <div class="item item-size-3-2">
                                                    <div class="card p-0 hover-change-image">
                                                        <a href="images/single-property-lg-3.jpg" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="background-image: url('images/single-property-lg-3.jpg')"></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="box px-0">
                                                <div class="item item-size-3-2">
                                                    <div class="card p-0 hover-change-image">
                                                        <a href="images/single-property-lg-2.jpg" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="background-image: url('images/single-property-lg-2.jpg')"></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="box px-0">
                                                <div class="item item-size-3-2">
                                                    <div class="card p-0 hover-change-image">
                                                        <a href="images/single-property-lg-9.jpg" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="background-image: url('images/single-property-lg-9.jpg')"></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="box px-0">
                                                <div class="item item-size-3-2">
                                                    <div class="card p-0 hover-change-image">
                                                        <a href="images/single-property-lg-10.jpg" class="card-img" data-gtf-mfp="true" data-gallery-id="04" style="background-image: url('images/single-property-lg-10.jpg')"></a>
                                                    </div>
                                                </div>
                                            </div>--%>
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
                                        <%--<div class="box pb-6 px-0">
                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                    <img src="images/single-property-sm-2.jpg" alt="Gallery 02" class="h-100 w-100 rounded-lg">
                                                </div>
                                            </div>
                                            <div class="box pb-6 px-0">
                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                    <img src="images/single-property-sm-4.jpg" alt="Gallery 03" class="h-100 w-100 rounded-lg">
                                                </div>
                                            </div>
                                            <div class="box pb-6 px-0">
                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                    <img src="images/single-property-sm-1.jpg" alt="Gallery 04" class="h-100 w-100 rounded-lg">
                                                </div>
                                            </div>
                                            <div class="box pb-6 px-0">
                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                    <img src="images/single-property-9.jpg" alt="Gallery 05" class="h-100 w-100 rounded-lg">
                                                </div>
                                            </div>
                                            <div class="box pb-6 px-0">
                                                <div class="bg-hover-white p-1 shadow-hover-xs-3 h-100 rounded-lg">
                                                    <img src="<%# Eval("UrunResmi") %>" alt="Gallery 06" class="h-100 w-100 rounded-lg">
                                                </div>
                                            </div>--%>
                                    </div>
                                </div>
                            </section>

                            <asp:Repeater ID="RepeaterUrunBilgisi" runat="server">
                                <ItemTemplate>
                                    <section class="col-lg-6">
                                        <div class="primary-sidebar-inner p-4">
                                            <div class="card-body px-sm-6 shadow-xxs-2 pb-5 pt-0">
                                                <div class="tab-content pt-1 pb-0 px-0 shadow-none">
                                                    <div class="d-sm-flex justify-content-sm-between mb-6">

                                                        <ul class="list-inline mb-0 mr-n2 my-4 my-xl-0">
                                                            <li class="list-inline-item mr-2 mt-2 mt-sm-0"><i class="fal fa-clock mr-1"></i>2 months ago</li>
                                                            <li class="list-inline-item mt-2 mt-sm-0">
                                                                <i class="fal fa-eye mr-1"></i>
                                                                <%# Eval("ZiyaretSayisi") %> views
                                                            </li>





                                                        </ul>
                                                    </div>
                                                    <div class="d-xl-flex justify-content-xl-between mt-5 mb-2">
                                                        <div>
                                                            <h2 class="fs-35 font-weight-600 lh-15 text-heading"><%# Eval("UrunAdi") %></h2>
                                                        </div>

                                                    </div>
                                                    <div>
                                                        <li class="list-inline-item mr-2 mt-2 mt-sm-0">Ürün Kodu: ASDF</li>
                                                    </div>
                                                    <div class="mt-2">
                                                        <li class="list-inline-item mr-2 mt-2 mt-sm-0">Ürün Açıklaması: Sitemizde bulunan tüm saatler orijinal olup, 24 ay garanti belgesi, faturası ve orijinal kutusu ile anlaşmalı kargo firması tarafından size teslim edilmektedir. Kredi kartlarına 12 Taksit ve ücretsiz kargo imkanı.
                                                        Bulova Saatleri, Türkiye Dağıtıcısı ve Kosovalı SAAT güvencesi altındadır.</li>
                                                    </div>
                                                    <div class="mt-2">
                                                        <li class="list-inline-item mr-2 mt-2 mt-sm-0">Marka: <%# Eval("Marka") %></li>
                                                    </div>
                                                    <div class="mt-2">
                                                        <li class="badge badge-danger mr-3 mb-2" runat="server" id="liIndirimYuzdesi" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>%<%# Eval("Indirimyüzdesi") %></li>


                                                        <div runat="server" id="divNormalFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) != 1 %>'>
                                                            <span class="fs-25 text-heading font-weight-bold mb-0">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></span>
                                                        </div>

                                                        <div runat="server" id="divIndirimliFiyat" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>
                                                            <span class="font-weight-500 text-gray-light mb-1 old-price mr-2 mt-2">₺<%# string.Format("{0:F2}", Eval("IndirimsizFiyat")) %></span>
                                                            <span>
                                                                <p class="fs-25 text-heading font-weight-bold mb-0 new-price">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></p>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <%--<div class="row mt-5 mb-5">
                                                        <div class="col-6 mb-6 mb-sm-0">
                                                            <div class="rounded-lg pt-2">
                                                                <h5 class="fs-16 lh-2 text-heading mb-6">Avarage User Rating
                                                                </h5>
                                                                <p class="fs-40 text-heading font-weight-bold mb-6 lh-1">4.6 <span class="fs-18 text-gray-light font-weight-normal">/5</span></p>
                                                                <ul class="list-inline">
                                                                    <li class="list-inline-item bg-warning text-white rounded-lg d-inline-flex align-items-center justify-content-center fs-12 mb-1" style="width: 30px; height: 30px">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item bg-warning text-white rounded-lg d-inline-flex align-items-center justify-content-center fs-12 mb-1" style="width: 30px; height: 30px">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item bg-warning text-white rounded-lg d-inline-flex align-items-center justify-content-center fs-12 mb-1" style="width: 30px; height: 30px">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item bg-warning text-white rounded-lg d-inline-flex align-items-center justify-content-center fs-12 mb-1" style="width: 30px; height: 30px">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item bg-gray-04 text-white rounded-lg d-inline-flex align-items-center justify-content-center fs-12 mb-1" style="width: 30px; height: 30px">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col-6 pt-3">
                                                            <h5 class="fs-16 lh-2 text-heading mb-5">Rating Breakdown
                                                            </h5>
                                                            <div class="d-flex align-items-center mx-n1">
                                                                <ul class="list-inline d-flex px-1 mb-0">
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                                <div class="d-block w-100 px-1">
                                                                    <div class="progress rating-progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="text-muted px-1">60%</div>
                                                            </div>
                                                            <div class="d-flex align-items-center mx-n1">
                                                                <ul class="list-inline d-flex px-1 mb-0">
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                                <div class="d-block w-100 px-1">
                                                                    <div class="progress rating-progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="text-muted px-1">40%</div>
                                                            </div>
                                                            <div class="d-flex align-items-center mx-n1">
                                                                <ul class="list-inline d-flex px-1 mb-0">
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                                <div class="d-block w-100 px-1">
                                                                    <div class="progress rating-progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="text-muted px-1">0%</div>
                                                            </div>
                                                            <div class="d-flex align-items-center mx-n1">
                                                                <ul class="list-inline d-flex px-1 mb-0">
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                                <div class="d-block w-100 px-1">
                                                                    <div class="progress rating-progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="text-muted px-1">0%</div>
                                                            </div>
                                                            <div class="d-flex align-items-center mx-n1">
                                                                <ul class="list-inline d-flex px-1 mb-0">
                                                                    <li class="list-inline-item text-warning mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                    <li class="list-inline-item text-border mr-1">
                                                                        <i class="fas fa-star"></i>
                                                                    </li>
                                                                </ul>
                                                                <div class="d-block w-100 px-1">
                                                                    <div class="progress rating-progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="text-muted px-1">0%</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                    <div class="mt-5">
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <asp:Button ID="Button1" runat="server" Text="Sepete Ekle" OnClick="BtnSepeteEkle_Click" CssClass="btn badge-primary btn-lg" Style='<%# Session["KullaniciID"] == null ? "display:none;": "" %>' />
                                                                <a data-toggle="modal" class="btn badge-primary btn-lg" href="#login-register-modal" style='<%# Session["KullaniciID"] == null ? "": "display:none;" %>'>Sepete Ekle</a>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </div>
                                                </div>
                                            </div>
                                    </section>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <section class="pt-6 border-bottom border-top pb-4">
                            <h4 class="fs-22 text-heading mb-4">Ürün Özellikleri</h4>
                            <asp:Repeater ID="rptPropertyFeatures" runat="server">
                                <ItemTemplate>
                                    <dl class="col-sm-6 mb-0 d-flex">
                                        <dt class="w-110px fs-14 font-weight-500 text-heading pr-2">
                                            <%# Eval("OzellikAdi") %>
                                        </dt>
                                        <dd>
                                            <%# Eval("Deger") %>
                                        </dd>
                                    </dl>
                                </ItemTemplate>
                            </asp:Repeater>

                        </section>
                        <%--<section class="pt-6 border-bottom pb-4">
                            <h4 class="fs-22 text-heading mb-4">Offices Amenities</h4>
                            <ul class="list-unstyled mb-0 row no-gutters">
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Balcony</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Fireplace</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Balcony</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Fireplace</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Basement</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Cooling</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Basement</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Cooling</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Dining room</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Dishwasher</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Dining room</li>
                                <li class="col-sm-3 col-6 mb-2"><i class="far fa-check mr-2 text-primary"></i>Dishwasher</li>
                            </ul>
                        </section>--%>
                        <%-- <section class="py-6">
                                <h4 class="fs-22 text-heading mb-6">Floor Plans</h4>
                                <div class="accordion accordion-03 mb-3" id="accordion-01">
                                    <div class="card border-0 shadow-xxs-2">
                                        <div class="card-header bg-gray-01 border-gray border-0 p-0" id="floor-plans-01">
                                            <div class="heading d-flex justify-content-between align-items-center px-6 " data-toggle="collapse" data-target="#collapse-01" aria-expanded="true" aria-controls="collapse-01" role="button">
                                                <h2 class="mb-0 fs-16 text-heading font-weight-500 py-4 lh-13">First Floor</h2>
                                                <ul class="list-inline mb-0 d-none d-sm-block pr-2">
                                                    <li class=" list-inline-item text-muted mr-4">Beds : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Bath : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Sqft : <span class="font-weight-500 text-heading">900</span></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div id="collapse-01" class="collapse show" aria-labelledby="floor-plans-01" data-parent="#accordion-01">
                                            <div class="card-body card-body col-sm-6 offset-sm-3 mb-3">
                                                <img src="images/single-detail-property-01.jpg" class="card-img" alt="Floor Plans">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion accordion-03 mb-3" id="accordion-02">
                                    <div class="card border-0 shadow-xxs-2">
                                        <div class="card-header bg-gray-01 border-gray border-0 p-0" id="floor-plans-02">
                                            <div class="heading d-flex justify-content-between align-items-center px-6  collapsed " data-toggle="collapse" data-target="#collapse-02" aria-expanded="true" aria-controls="collapse-02" role="button">
                                                <h2 class="mb-0 fs-16 text-heading font-weight-500 py-4 lh-13">Second Floor</h2>
                                                <ul class="list-inline mb-0 d-none d-sm-block pr-2">
                                                    <li class=" list-inline-item text-muted mr-4">Beds : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Bath : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Sqft : <span class="font-weight-500 text-heading">900</span></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div id="collapse-02" class="collapse " aria-labelledby="floor-plans-02" data-parent="#accordion-02">
                                            <div class="card-body card-body col-sm-6 offset-sm-3 mb-3">
                                                <img src="images/single-detail-property-01.jpg" class="card-img" alt="Floor Plans">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion accordion-03 mb-3" id="accordion-03">
                                    <div class="card border-0 shadow-xxs-2">
                                        <div class="card-header bg-gray-01 border-gray border-0 p-0" id="floor-plans-03">
                                            <div class="heading d-flex justify-content-between align-items-center px-6  collapsed " data-toggle="collapse" data-target="#collapse-03" aria-expanded="true" aria-controls="collapse-03" role="button">
                                                <h2 class="mb-0 fs-16 text-heading font-weight-500 py-4 lh-13">Third Floor</h2>
                                                <ul class="list-inline mb-0 d-none d-sm-block pr-2">
                                                    <li class=" list-inline-item text-muted mr-4">Beds : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Bath : <span class="font-weight-500 text-heading">2</span></li>
                                                    <li class=" list-inline-item text-muted mr-4">Sqft : <span class="font-weight-500 text-heading">900</span></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div id="collapse-03" class="collapse " aria-labelledby="floor-plans-03" data-parent="#accordion-03">
                                            <div class="card-body card-body col-sm-6 offset-sm-3 mb-3">
                                                <img src="images/single-detail-property-01.jpg" class="card-img" alt="Floor Plans">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>--%>
                        <section class="pt-5">
                            <div class="card border-0 mb-4">
                                <div class="card-body p-0">
                                    <h3 class="fs-16 lh-2 text-heading mb-0 d-inline-block pr-4 border-bottom border-primary">5 Reviews</h3>
                                    <div class="media border-top pt-7 pb-6 d-sm-flex d-block text-sm-left text-center">
                                        <img src="images/review-07.jpg" alt="Danny Fox" class="mr-sm-8 mb-4 mb-sm-0">
                                        <div class="media-body">
                                            <div class="row mb-1 align-items-center">
                                                <div class="col-sm-6 mb-2 mb-sm-0">
                                                    <h4 class="mb-0 text-heading fs-14">Danny Fox</h4>
                                                </div>
                                                <div class="col-sm-6">
                                                    <ul class="list-inline d-flex justify-content-sm-end justify-content-center mb-0">
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="mb-3 pr-xl-17">Very good and fast support during the week. Thanks for always keeping your WordPress themes up to date. Your level of support and dedication is second to none.</p>
                                            <div class="d-flex justify-content-sm-start justify-content-center">
                                                <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                                                <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="media border-top py-6 d-sm-flex d-block text-sm-left text-center">
                                        <img src="images/review-08.jpg" alt="Viola Austin" class="mr-sm-8 mb-4 mb-sm-0">
                                        <div class="media-body">
                                            <div class="row mb-1 align-items-center">
                                                <div class="col-sm-6 mb-2 mb-sm-0">
                                                    <h4 class="mb-0 text-heading fs-14">Viola Austin</h4>
                                                </div>
                                                <div class="col-sm-6 ">
                                                    <ul class="list-inline d-flex justify-content-sm-end justify-content-center mb-0">
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="mb-3 pr-xl-17">Very good and fast support during the week. Thanks for always keeping your WordPress themes up to date. Your level of support and dedication is second to none.</p>
                                            <div class="d-flex justify-content-sm-start justify-content-center">
                                                <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                                                <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="media border-top py-6 d-sm-flex d-block text-sm-left text-center">
                                        <img src="images/review-09.jpg" alt="Nettie Singleton" class="mr-sm-8 mb-4 mb-sm-0">
                                        <div class="media-body">
                                            <div class="row mb-1 align-items-center">
                                                <div class="col-sm-6 mb-2 mb-sm-0">
                                                    <h4 class="mb-0 text-heading fs-14">Nettie Singleton</h4>
                                                </div>
                                                <div class="col-sm-6 ">
                                                    <ul class="list-inline d-flex justify-content-sm-end justify-content-center mb-0">
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="mb-3 pr-xl-17">Very good and fast support during the week. Thanks for always keeping your WordPress themes up to date. Your level of support and dedication is second to none.</p>
                                            <div class="d-flex justify-content-sm-start justify-content-center">
                                                <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                                                <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="media border-top py-6 d-sm-flex d-block text-sm-left text-center">
                                        <img src="images/review-07.jpg" alt="Vernon Fisher" class="mr-sm-8 mb-4 mb-sm-0">
                                        <div class="media-body">
                                            <div class="row mb-1 align-items-center">
                                                <div class="col-sm-6 mb-2 mb-sm-0">
                                                    <h4 class="mb-0 text-heading fs-14">Vernon Fisher</h4>
                                                </div>
                                                <div class="col-sm-6">
                                                    <ul class="list-inline d-flex justify-content-sm-end justify-content-center mb-0">
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-border fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="mb-3 pr-xl-17">Very good and fast support during the week. Thanks for always keeping your WordPress themes up to date. Your level of support and dedication is second to none.</p>
                                            <div class="d-flex justify-content-sm-start justify-content-center">
                                                <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                                                <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="media border-top py-6 d-sm-flex d-block text-sm-left text-center">
                                        <div class="w-82px h-82 mr-2 bg-gray-01 rounded-circle fs-25 font-weight-500 text-muted d-flex align-items-center justify-content-center text-uppercase mr-sm-8 mb-4 mb-sm-0 mx-auto">
                                            HI
                                        </div>
                                        <div class="media-body">
                                            <div class="row mb-1 align-items-center">
                                                <div class="col-sm-6 mb-2 mb-sm-0">
                                                    <h4 class="mb-0 text-heading fs-14">Harry Iglesias</h4>
                                                </div>
                                                <div class="col-sm-6">
                                                    <ul class="list-inline d-flex justify-content-sm-end justify-content-center mb-0">
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-warning fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                        <li class="list-inline-item mr-1">
                                                            <span class="text-border fs-12 lh-2"><i class="fas fa-star"></i></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="mb-3 pr-xl-17">Very good and fast support during the week. Thanks for always keeping your WordPress themes up to date. Your level of support and dedication is second to none.</p>
                                            <div class="d-flex justify-content-sm-start justify-content-center">
                                                <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                                                <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <%--<section>
                            <div class="card border-0">
                                <div class="card-body p-0">
                                    <h3 class="fs-16 lh-2 text-heading mb-4">Write A Review</h3>
                                    <form>
                                        <div class="form-group mb-4 d-flex justify-content-start">
                                            <div class="rate-input">
                                                <input type="radio" id="star5" name="rate" value="5">
                                                <label for="star5" title="text" class="mb-0 mr-1 lh-1">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <input type="radio" id="star4" name="rate" value="4">
                                                <label for="star4" title="text" class="mb-0 mr-1 lh-1">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <input type="radio" id="star3" name="rate" value="3">
                                                <label for="star3" title="text" class="mb-0 mr-1 lh-1">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <input type="radio" id="star2" name="rate" value="2">
                                                <label for="star2" title="text" class="mb-0 mr-1 lh-1">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <input type="radio" id="star1" name="rate" value="1">
                                                <label for="star1" title="text" class="mb-0 mr-1 lh-1">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group mb-4">
                                                    <input placeholder="Your Name" class="form-control form-control-lg border-0" type="text" name="name">
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group mb-4">
                                                    <input type="email" placeholder="Email" name="email" class="form-control form-control-lg border-0">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group mb-6">
                                            <textarea class="form-control form-control-lg border-0" placeholder="Your Review" name="message" rows="5"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-lg btn-primary px-10 mb-2">Submit</button>
                                    </form>
                                </div>
                            </div>
                        </section>--%>
                    </article>
                    <%--<aside class="col-lg-4 primary-sidebar sidebar-sticky" id="sidebar">
                            <div class="primary-sidebar-inner">
                                <div class="card border-0 widget-request-tour">
                                    <ul class="nav nav-tabs d-flex" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active px-3" data-toggle="tab" href="#schedule" role="tab" aria-selected="true">ScheduleA Tour</a>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                            <a class="nav-link px-3" data-toggle="tab" href="#request-info" role="tab" aria-selected="false">Request Info</a>
                                        </li>
                                    </ul>
                                    <div class="card-body px-sm-6 shadow-xxs-2 pb-5 pt-0">
                                        <form>
                                            <div class="tab-content pt-1 pb-0 px-0 shadow-none">
                                                <div class="tab-pane fade show active" id="schedule" role="tabpanel">
                                                    <div class="slick-slider calendar arrow-hide-disable mx-n1" data-slick-options='{"slidesToShow": 5, "autoplay":false,"dots":false}'>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer active border-0 shadow-xxs-1" data-date="March 17, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Tue</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">17</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 18, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Wed</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">18</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 19, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Thur</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">19</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 20, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Fri</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">20</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 21, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Sat</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">21</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 22, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Sun</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">22</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="box px-1 py-4">
                                                            <div class="card pointer border-0 shadow-xxs-1" data-date="March 23, 2020">
                                                                <div class="card-body p-1 text-center">
                                                                    <p class="day fs-12 text-muted lh-2 mb-0">Mon</p>
                                                                    <p class="date fs-18 text-heading lh-173 mb-0 font-weight-bold">23</p>
                                                                    <p class="month fs-13 letter-spacing-087 mb-0">Mar</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <input type="hidden" class="date" name="date" value="March 17, 2020">
                                                    <div class="form-group mb-2">
                                                        <div class="input-group input-group-lg bootstrap-timepicker timepicker">
                                                            <input type="text" class="form-control border-0 text-body shadow-none" placeholder="Choose a time">
                                                            <div class="input-group-append input-group-addon">
                                                                <button class="btn bg-input shadow-none fs-18 lh-1" type="button"><i class="fal fa-angle-down"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group mb-2">
                                                        <input type="text" class="form-control form-control-lg border-0" placeholder="First Name, Last Name">
                                                    </div>
                                                    <div class="form-group mb-2">
                                                        <input type="email" class="form-control form-control-lg border-0" placeholder="Your Email">
                                                    </div>
                                                    <div class="form-group mb-4">
                                                        <input type="tel" class="form-control form-control-lg border-0" placeholder="Your phone">
                                                    </div>
                                                    <button type="submit" class="btn btn-primary btn-lg btn-block rounded">Schedule A Tour</button>
                                                    <div class="form-group form-check mt-2 mb-0">
                                                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                                        <label class="form-check-label fs-13" for="exampleCheck1">
                                                            Egestas fringilla phasellus
faucibus
scelerisque
eleifend donec.</label>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade pt-5" id="request-info" role="tabpanel">
                                                    <div class="form-check d-flex align-items-center border-bottom pb-3 mb-3">
                                                        <input class="form-check-input" type="radio" name="agent" value="option1">
                                                        <div class="form-check-label ml-2">
                                                            <div class="d-flex align-items-center">
                                                                <a href="agent-details-1.html" class="d-block w-60px h-60 mr-3">
                                                                    <img src="images/agent-2.jpg" class="rounded-circle" alt="agent-2">
                                                                </a>
                                                                <div>
                                                                    <a href="agent-details-1.html" class="d-block text-dark font-weight-500 lh-15 hover-primary">Oliver
Beddows</a>
                                                                    <p class="mb-0 fs-13 mb-0 lh-17">Sales Excutive</p>
                                                                    <p class="mb-0 fs-13 mb-0 lh-17">
                                                                        <span>(+123)</span><span class="text-heading d-inline-block ml-2">1900 68668</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-check d-flex align-items-center mb-6">
                                                        <input class="form-check-input" type="radio" name="agent" id="inlineRadio2" value="option2">
                                                        <div class="form-check-label ml-2">
                                                            <div class="d-flex align-items-center">
                                                                <a href="agent-details-1.html" class="d-block w-60px h-60 mr-3">
                                                                    <img src="images/agent-1.jpg" class="rounded-circle" alt="agent-1">
                                                                </a>
                                                                <div>
                                                                    <a href="agent-details-1.html" class="d-block text-dark font-weight-500 lh-15 hover-primary">Max Kordex</a>
                                                                    <p class="mb-0 fs-13 mb-0 lh-17">Real estate broker</p>
                                                                    <p class="mb-0 fs-13 mb-0 lh-17">
                                                                        <span>(+123)</span><span class="text-heading d-inline-block ml-2">1900 68668</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group mb-2">
                                                        <input type="text" class="form-control form-control-lg border-0" placeholder="First Name, Last Name">
                                                    </div>
                                                    <div class="form-group mb-2">
                                                        <input type="email" class="form-control form-control-lg border-0" placeholder="Your Email">
                                                    </div>
                                                    <div class="form-group mb-2">
                                                        <input type="tel" class="form-control form-control-lg border-0" placeholder="Your phone">
                                                    </div>
                                                    <div class="form-group mb-4">
                                                        <textarea class="form-control border-0" rows="4">Hello, I'm interested in Villa Called Archangel</textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary btn-lg btn-block rounded">Request Info</button>
                                                    <div class="form-group form-check mt-2 mb-0">
                                                        <input type="checkbox" class="form-check-input" id="exampleCheck2">
                                                        <label class="form-check-label fs-13" for="exampleCheck2">
                                                            Egestas fringilla phasellus
faucibus
scelerisque
eleifend donec.</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </aside>--%>
                </div>
            </div>
        </div>



        <section class="pt-6 pb-8">
            <div class="container">
                <h4 class="fs-22 text-heading mb-6">Beğenebileceğin Diğer Ürünlerimiz</h4>
                <div class="slick-slider" data-slick-options='{"slidesToShow": 4, "dots":false,"arrows":false,"responsive":[{"breakpoint": 1200,"settings": {"slidesToShow":4,"arrows":false}},{"breakpoint": 992,"settings": {"slidesToShow":3}},{"breakpoint": 768,"settings": {"slidesToShow": 2}},{"breakpoint": 576,"settings": {"slidesToShow": 2}}]}'>

                    <asp:Repeater ID="RepeaterOnerilenUrunler" runat="server">
                        <ItemTemplate>

                            <div class="box">
                                <div class="card border-0 hover-change-image ">
                                    <div class="bg-hover-overlay rounded-lg card-img">
                                        <img src="<%# Eval("UrunResmi") %>" alt="Home in Metric Way">
                                        <div class="card-img-overlay p-2 d-flex flex-column">
                                            <div class="card-img-overlay p-2 d-flex flex-column">
                                                <div class="d-flex justify-content-between">
                                                    <span class="badge badge-danger" style="max-height: 25px;" runat="server" visible='<%# Convert.ToInt32(Eval("IndirimDurumu")) == 1 %>'>%<%# Eval("Indirimyüzdesi") %>
                                                    </span>

                                                    <span></span>
                                                    <asp:UpdatePanel ID="UpdatePanelFavori" runat="server" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <label class="ui-like ml-auto" style='<%# Session["KullaniciID"] == null ? "display:none;": "" %>'>
                                                                <asp:HiddenField ID="HiddenFieldUrunID" runat="server" Value='<%# Eval("UrunID") %>' />
                                                                <asp:CheckBox ID="CheckBoxFavorilereEkle" runat="server"
                                                                    OnCheckedChanged="CheckBoxFavorilereEkle_CheckedChanged" AutoPostBack="true" EnableViewState="True" />
                                                                <div class="like">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="">
                                                                        <g stroke-width="0" id="SVGRepo_bgCarrier"></g>
                                                                        <g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g>
                                                                        <g id="SVGRepo_iconCarrier">
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
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <ul class="list-inline mb-0 d-flex align-items-end mr-n3">
                                                    <!-- Diğer içerik burada kalabilir -->
                                                </ul>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body pt-3 px-0 pb-1">
                                        <h2 class="fs-16 mb-1"><a href="UrunBilgisi.aspx?id=<%# Eval("UrunID") %>" class="text-dark hover-primary text-truncate"><%# Eval("UrunAdi") %></a></h2>
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

                </div>
            </div>
        </section>




        <%--<section class="pb-12">
                <div class="container">
                    <h4 class="fs-22 text-heading mb-6">Listings near 1135 Clayton St</h4>
                    <div class="slick-slider" data-slick-options='{"slidesToShow": 3, "dots":false,"arrows":false,"responsive":[{"breakpoint": 1200,"settings": {"slidesToShow":3,"arrows":false}},{"breakpoint": 992,"settings": {"slidesToShow":2}},{"breakpoint": 768,"settings": {"slidesToShow": 1}},{"breakpoint": 576,"settings": {"slidesToShow": 1}}]}'>

                        <asp:Repeater ID="RepeaterOnerilenlerAltKisim" runat="server">
                            <ItemTemplate>

                                <div class="box">
                                    <div class="card shadow-hover-2">
                                        <div class="hover-change-image bg-hover-overlay rounded-lg card-img-top">
                                            <img src="<%# Eval("UrunResmi") %>" alt="Home in Metric Way">
                                            <div class="card-img-overlay p-2 d-flex flex-column">
                                                <div>
                                                    <span class="badge mr-2 badge-primary">for Sale</span>
                                                </div>
                                                <ul class="list-inline mb-0 mt-auto hover-image">
                                                    <li class="list-inline-item mr-2" data-toggle="tooltip" title="9 Images">
                                                        <a href="#" class="text-white hover-primary">
                                                            <i class="far fa-images"></i><span class="pl-1">9</span>
                                                        </a>
                                                    </li>
                                                    <li class="list-inline-item" data-toggle="tooltip" title="2 Video">
                                                        <a href="#" class="text-white hover-primary">
                                                            <i class="far fa-play-circle"></i><span class="pl-1">2</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="card-body pt-3">
                                            <h2 class="card-title fs-16 lh-2 mb-0"><a href="UrunBilgisi.aspx?id=<%# Eval("UrunID") %>" class="text-dark hover-primary"><%# Eval("UrunAdi") %></a></h2>
                                            <p class="card-text font-weight-500 text-gray-light mb-2">1421 San Pedro St, Los Angeles</p>
                                            <ul class="list-inline d-flex mb-0 flex-wrap mr-n5">
                                                <li class="list-inline-item text-gray font-weight-500 fs-13 d-flex align-items-center mr-5" data-toggle="tooltip" title="3 Bedroom">
                                                    <svg class="icon icon-bedroom fs-18 text-primary mr-1">
                                                        <use xlink:href="#icon-bedroom"></use></svg>3 Br
                                                </li>
                                                <li class="list-inline-item text-gray font-weight-500 fs-13 d-flex align-items-center mr-5" data-toggle="tooltip" title="3 Bathrooms">
                                                    <svg class="icon icon-shower fs-18 text-primary mr-1">
                                                        <use xlink:href="#icon-shower"></use></svg>3 Ba
                                                </li>
                                                <li class="list-inline-item text-gray font-weight-500 fs-13 d-flex align-items-center mr-5" data-toggle="tooltip" title="Size">
                                                    <svg class="icon icon-square fs-18 text-primary mr-1">
                                                        <use xlink:href="#icon-square"></use></svg>2300 Sq.Ft
                                                </li>
                                                <li class="list-inline-item text-gray font-weight-500 fs-13 d-flex align-items-center mr-5" data-toggle="tooltip" title="1 Garage">
                                                    <svg class="icon icon-Garage fs-18 text-primary mr-1">
                                                        <use xlink:href="#icon-Garage"></use></svg>1 Gr
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="card-footer bg-transparent d-flex justify-content-between align-items-center py-3">
                                            <p class="fs-17 font-weight-bold text-heading mb-0">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></p>
                                            <ul class="list-inline mb-0">
                                                <li class="list-inline-item">
                                                    <a href="#" class="w-40px h-40 border rounded-circle d-inline-flex align-items-center justify-content-center text-secondary bg-accent border-accent" data-toggle="tooltip" title="Wishlist"><i class="fas fa-heart"></i></a>
                                                </li>
                                                <li class="list-inline-item">
                                                    <a href="#" class="w-40px h-40 border rounded-circle d-inline-flex align-items-center justify-content-center text-body hover-secondary bg-hover-accent border-hover-accent" data-toggle="tooltip" title="Compare"><i class="fas fa-exchange-alt"></i></a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>
            </section>--%>
        
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
    </main>
</asp:Content>
