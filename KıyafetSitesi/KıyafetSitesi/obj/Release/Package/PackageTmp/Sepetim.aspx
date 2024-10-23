<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSayfa.Master" AutoEventWireup="true" CodeBehind="Sepetim.aspx.cs" Inherits="KıyafetSitesi.Sepetim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <title>Miran Eser | Sepetim</title>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <main id="content" class="bg-gray-01">
        <div class="container align-items-center">
            <asp:UpdatePanel ID="UpdatePanelsepet" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10">
                                <div class="card border-0 mb-4">
                                    <asp:Label ID="lblErrorStok" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                    <div class="card-body p-0 p-sm-8 p-4">

                                        <h3 class="fs-16 lh-2 text-heading mb-0 d-inline-block pr-4 border-bottom border-primary">Sepetinizde
                                            <asp:Label ID="lblurunadet" runat="server"></asp:Label>
                                            Adet Ürün Var</h3>
                                        <asp:Repeater ID="RepeaterSepettekiUrunler" runat="server" OnItemDataBound="RepeaterSepetIcerik_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="media border-bottom pt-7 pb-6 d-sm-flex d-block text-sm-left text-center">
                                                    <img src="<%# Eval("UrunResmi") %>" alt="Danny Fox" class="mr-sm-2 mb-4 mb-sm-0" style="width: 150px; height: 150px;">
                                                    <div class="media-body row">
                                                        <div class="col-sm-7 mb-1 align-items-center">
                                                            <div class="mb-2 mb-sm-0">
                                                                <h4 class="mb-0 text-heading fs-20"><%# Eval("UrunAdi") %></h4>
                                                            </div>
                                                            <p class="mb-3">₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %></p>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <div class="text-sm-right">
                                                                <asp:Button ID="btnAdetAzalt" runat="server" Text="-" Style="display: inline-block; vertical-align: middle;" CssClass="btn btn-primary btn-sm" OnClick="BtnAdetAzalt_Click" CommandArgument='<%# Eval("IcerikID") %>' />
                                                                <asp:LinkButton ID="btnSil" runat="server" Text="Sil" CssClass="btn btn-danger btn-sm" OnClick="BtnUrunSil_Click" CommandArgument='<%# Eval("IcerikID") %>'>
                                                                    <i class="bi bi-trash3-fill"></i>
                                                                </asp:LinkButton>
                                                                <div class="mx-1" style="display: inline-block; vertical-align: middle;">
                                                                    <%# Eval("SepetUrunAdet") %>
                                                                </div>
                                                                <asp:Button ID="btnAdetArttir" runat="server" Text="+" Style="display: inline-block; vertical-align: middle;" CssClass="btn btn-primary btn-sm" OnClick="BtnAdetArttir_Click" CommandArgument='<%# Eval("IcerikID") %>' />
                                                            </div>
                                                        </div>

                                                        <%--<div class="d-flex justify-content-sm-start justify-content-center">
                        <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
                        <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
                    </div>--%>
                                                        <asp:HiddenField ID="hiddenUrunID" runat="server" Value='<%# Eval("UrunID") %>' />
                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="py-5 py-lg-10">
                                <div class="card border-0 mb-4">

                                    <div class="card-body p-4 p-sm-8">
                                        <div class="">
                                            <div class="mb-1 align-items-center border-bottom">
                                                <div class="mb-4">
                                                    <h4 class="mb-0 text-heading fs-25">Sepet Tutarı</h4>
                                                </div>
                                            </div>
                                            <div>
                                                <p class="mb-2 mt-4"><strong>Sepet Tutarı: </strong>
                                                <asp:Label ID="LabelSepetTutari" runat="server" CssClass="mb-2 mt-4"
                                                    Text='0' />

                                            </div>
                                            <div>
                                                <p class="mb-2 "><strong>Kargo Ücreti: </strong>₺100,00</p>
                                            </div>
                                            <div>
                                                <p class="mb-2 mt-4"><strong>Toplam İndirim: </strong>
                                                <asp:Label ID="LabelToplamIndirim" runat="server" CssClass="mb-2"
                                                    Text='0' />
                                            </div>
                                            <div class="mb-1 align-items-center border-top pt-4">
                                                <div class="mb-4">
                                                    <h4 class="mb-0 text-heading fs-20">Toplam Tutar: 1750,00 TL</h4>
                                                </div>
                                            </div>
                                            <div class="form-group mt-3">
                                                <label for="ddlAdres" class="text-heading">Adres</label>
                                                <asp:DropDownList
                                                    ID="ddlAdres"
                                                    runat="server"
                                                    CssClass="form-control border-0 shadow-xxs-1 bg-transparent font-weight-600"
                                                    DataTextField="Text"
                                                    DataValueField="Value"
                                                    AppendDataBoundItems="true"
                                                    DataStyle="bg-white">
                                                </asp:DropDownList>
                                                <p style="font-weight: 100; font-size: 12px;" class="mt-2">Yeni Adres Oluşturmak İçin <a href="Adres_Ekle.aspx">Tıklayınız</a>.</p>
                                            </div>
                                            <label for="txtSiparisNotu" class="text-heading">Sipariş Notu</label>
                                            <asp:TextBox CssClass="form-control form-control-lg border-0" ID="txtSiparisNotu" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>


                                            <asp:Button ID="BtnSiparis" CssClass="btn btn-primary btn-lg btn-block mt-5" runat="server" Text="Alışverişi Tamamla" OnClick="BtnSiparis_Click" />
                                            <%--<div class="d-flex justify-content-sm-start justify-content-center">
    <p class="mb-0 text-muted fs-13 lh-1">02 Dec 2020 at 2:40pm</p>
    <a href="#" class="mb-0 text-heading border-left border-dark hover-primary lh-1 ml-2 pl-2">Reply</a>
</div>--%>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </main>



</asp:Content>
