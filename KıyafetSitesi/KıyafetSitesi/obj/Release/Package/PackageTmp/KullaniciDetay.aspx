<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="KullaniciDetay.aspx.cs" Inherits="KıyafetSitesi.KullaniciDetay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 add-new-invoice">
            <div class="row">
                <div class="col-xl-9 mb-6 mb-xl-0">
                    <div class="card card-body main-invoice-info p-6">
                        <div class="row">
                            <div class="col-12 mb-6">
                                <p class="fs-18 mb-0"><span class="inv-title">Kullanıcı ID : </span><span class="text-primary">#<asp:Label ID="lblkullaniciid" runat="server"></asp:Label></span></p>
                            </div>
                        </div>
                        <div class="pt-3 mb-7">
                            <div class="row">

                                <div class="col-12 align-self-center">
                                    <h6 class="card-title text-heading fs-22 lh-15">Kullanıcı Bilgileri</h6>
                                </div>

                                <div class="col-12 align-self-center mt-3">
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Adi: </span>
                                        <asp:Label ID="lblKullaniciAdi" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Adı: </span>
                                        <asp:Label ID="lblKullaniciIsim" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Soyadı: </span>
                                        <asp:Label ID="lblKullaniciSoyisim" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">E-mail: </span>
                                        <asp:Label ID="lblKullaniciEmail" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Telefon Numarası: </span>
                                        <asp:Label ID="lblKullaniciTelefon" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Hesap Oluşturma Tarihi: </span>
                                        <asp:Label ID="lblKullaniciOlusturmaTarihi" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Statüsü: </span>
                                        <asp:Label ID="lblKullaniciYetki" runat="server"></asp:Label>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Durumu: </span>
                                        <asp:Label ID="lblKullaniciPasifDurumu" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div class="col-12 align-self-center order-sm-0 order-1 border-top mt-3 pt-3">
                                    <h6 class="card-title text-heading fs-22 lh-15">Kullanıcı İşlemleri:</h6>
                                </div>
                                <div class="col-12 align-self-center mt-3">
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Bekleyen Siparişleri: </span>
                                        <span class="inv-date">
                                            <asp:Label ID="lblSiparisDurumu" runat="server" CssClass="inv-date"></asp:Label>
                                        </span>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Yaptığı Toplam Alışveriş Sayısı: </span>
                                        <span class="inv-date">
                                            <asp:Label ID="lblSiparisTarihi" runat="server" CssClass="inv-date"></asp:Label>
                                        </span>
                                    </p>
                                    <p class="mb-0">
                                        <span class="text-heading font-weight-500">Kullanıcı Harcadığı Toplam Tutar: </span>
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
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 invoice-preview-button">
                    <div class="card card-body p-6">
                        <div class="row">
                            <div class="col-xl-12 col-md-3 col-sm-6 mb-3">
                                <a href="javascript:void(0);" class="btn btn-primary btn-send btn-block">Send Invoice</a>
                            </div>
                            <div class="col-xl-12 col-md-3 col-sm-6 mb-3">
                                <a href="javascript:void(0);" class="btn btn-secondary btn-print invoice-action-print btn-block">Print</a>
                            </div>
                            <div class="col-xl-12 col-md-3 col-sm-6 mb-3">
                                <a href="javascript:void(0);" class="btn btn-success btn-download btn-block">Download</a>
                            </div>
                            <div class="col-xl-12 col-md-3 col-sm-6 mb-3">
                                <a href="dashboard-edit-invoice.html" class="btn btn-dark btn-edit btn-block">Edit</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
