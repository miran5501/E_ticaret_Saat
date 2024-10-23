<%@ Page Title="" Language="C#" MasterPageFile="~/Profilim.Master" AutoEventWireup="true" CodeBehind="Profilim.aspx.cs" Inherits="KıyafetSitesi.Profilim" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="px-3 px-lg-6 px-xxl-13 py-lg-5 py-lg-10">
        <div class="card mb-6">
            <div class="card-body px-6 pt-lg-6 pb-5">
                <h3 class="card-title mb-0 text-heading fs-22 lh-15">Üyelik Bilgilerim</h3>
                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>

                <div class="form-row mx-n4">
                    <div class="form-group col-md-6 px-4">
                        <label for="firstName" class="text-heading">İsim</label>
                        <asp:TextBox ID="txtisim" runat="server" CssClass="form-control form-control-lg border-0" />
                    </div>
                    <div class="form-group col-md-6 px-4">
                        <label for="lastName" class="text-heading">Soy isim</label>
                        <asp:TextBox ID="txtsoyisim" runat="server" CssClass="form-control form-control-lg border-0" />
                    </div>
                </div>

                <div class="form-row mx-n4">
                    <div class="form-group col-md-6 px-4">
                        <label for="phone" class="text-heading">Telefon numarası</label>
                        <asp:TextBox ID="txttelefonno" runat="server" CssClass="form-control form-control-lg border-0" />
                    </div>
                    <div class="form-group col-md-6 px-4">
                        <label for="email" class="text-heading">Email</label>
                        <asp:TextBox ID="txtemail" runat="server" CssClass="form-control form-control-lg border-0" TextMode="Email" />
                    </div>
                </div>

                <div class="mt-2 mt-sm-5">
                    <asp:Button ID="btnGuncelle" runat="server" Text="Bilgilerimi Güncelle" CssClass="btn badge-primary btn-lg" OnClick="btnGuncelle_Click"/>
                </div>
            </div>

        </div>
        <div class="card mb-6">
            <div class="card-body px-6 pt-6 pb-5">

                <h3 class="card-title mb-0 text-heading fs-22 lh-15">Üyelik Bilgilerim</h3>
                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                <div class="form-row mx-n4">

                    <div class="form-group col-md-6 px-4 mb-md-0">
                        <label for="skype" class="text-heading">Skype</label>
                        <input type="text" class="form-control form-control-lg border-0" id="skype" name="skype">
                    </div>
                    <div class="form-group col-md-6 px-4 mb-md-0">
                        <label for="skype" class="text-heading">Skype</label>
                        <input type="text" class="form-control form-control-lg border-0" id="skype1" name="skype">
                    </div>
                </div>
                <div class="mt-2 mt-sm-5">
                    <asp:Button ID="Button3" runat="server" Text="Bilgilerimi Güncelle" CssClass="btn badge-primary btn-lg" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
