<%@ Page Title="" Language="C#" MasterPageFile="~/Profilim.master" AutoEventWireup="true" CodeBehind="Adres_Ekle.aspx.cs" Inherits="KıyafetSitesi.Adres_Ekle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10">
        <div class="card mb-6">
            <div class="card-body px-6 pt-6 pb-5">
                <h3 class="card-title mb-5 text-heading fs-22 lh-15">Adres Ekle</h3>
                
                <div class="form-row mx-n4">
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="txtAd" class="text-heading">Adınız</label>
                        <asp:TextBox CssClass="form-control form-control-lg border-0" ID="txtAd" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="txtSoyad" class="text-heading">Soyadınız</label>
                        <asp:TextBox CssClass="form-control form-control-lg border-0" ID="txtSoyad" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row mx-n4">
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="TextTelefonNo" class="text-heading">Telefon Numaranız</label>
                        <asp:TextBox CssClass="form-control form-control-lg border-0" ID="TextTelefonNo" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="ddlSehir" class="text-heading">İl</label>
                        <asp:DropDownList
                            ID="ddlSehir"
                            runat="server"
                            CssClass="form-control border-0 shadow-xxs-1 bg-transparent font-weight-600 selectpicker"
                            DataTextField="Text"
                            DataValueField="Value"
                            AppendDataBoundItems="true"
                            Title="İl"
                            DataStyle="bg-white"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlSehir_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="ddlIlce" class="text-heading">İlçe</label>
                        <asp:DropDownList
                            ID="ddlIlce"
                            runat="server"
                            CssClass="form-control border-0 shadow-xxs-1 bg-transparent font-weight-600 selectpicker"
                            DataTextField="Text"
                            DataValueField="Value"
                            AppendDataBoundItems="true"
                            Title="İlçe"
                            DataStyle="bg-white"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlIlce_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group col-md-6 px-4 mt-3">
                        <label for="ddlMahalle" class="text-heading">Mahalle</label>
                        <asp:DropDownList
                            ID="ddlMahalle"
                            runat="server"
                            CssClass="form-control border-0 shadow-xxs-1 bg-transparent font-weight-600 selectpicker"
                            DataTextField="Text"
                            DataValueField="Value"
                            AppendDataBoundItems="true"
                            Title="Mahalle"
                            DataStyle="bg-white"
                            AutoPostBack="True">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row mx-n4">

                    <div class="form-group col-12 px-4 mt-3">
                        <label for="txtAdres" class="text-heading">Adres
                            <p style="color:gray; font-weight:100; font-size: 13px;">Kargonuzun size sorunsuz bir şekilde ulaşabilmesi için mahalle, cadde, sokak, bina gibi detay bilgileri eksiksiz girdiğinizden emin olun.</p>
                        </label>
                        <asp:TextBox CssClass="form-control form-control-lg border-0" ID="txtAdres" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <div class="form-group col-12 px-4 mb-md-0 mt-3">
                        <label for="txtAdresBasligi" class="text-heading">Adres Başlığı</label>
                        <asp:TextBox CssClass="form-control form-control-lg border-0" ID="txtAdresBasligi" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="mt-2 mt-sm-5">
                    <asp:Button ID="BtnKaydet" runat="server" Text="Kaydet" CssClass="btn badge-primary btn-lg" OnClick="BtnKaydet_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
