<%@ Page Title="" Language="C#" MasterPageFile="~/Profilim.Master" AutoEventWireup="true" CodeBehind="Favorilerim.aspx.cs" Inherits="KıyafetSitesi.Favorilerim" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="UpdatePanelFavorilerim" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <section class="pb-11">
                <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10">
                    <div class="card mb-6">
                        <div class="card-body px-6 pt-6 pb-5 row">

                            <asp:Repeater ID="RepeaterFavoriUrunler" runat="server">
                                <ItemTemplate>

                                    <div class="col-6 col-xxl-4 col-lg-4 col-md-4 mb-7 px-2">
                                        <div class="card border-0 hover-change-image">
                                            <div class="bg-hover-overlay rounded-lg card-img">
                                                <img src="<%# Eval("UrunResmi") %>" alt="Home in Metric Way">
                                                <div class="card-img-overlay p-2 d-flex flex-column">
                                                    <div class="card-img-overlay p-2 d-flex flex-column">
                                                        <div class="d-flex justify-content-between">
                                                            <%--<span class="badge badge-primary" style="max-height: 25px;">For Sale</span>--%>
                                                        </div>
                                                        <ul class="list-inline mb-0 d-flex align-items-end mr-n3">
                                                            <!-- Diğer içerik burada kalabilir -->
                                                        </ul>
                                                        <div class="mt-auto d-flex hover-image">
                                                            <ul class="list-inline mb-0 d-flex align-items-end mr-auto">
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
                                                </div>
                                            </div>
                                            <div class="card-body pt-3 px-0 pb-1">
                                                <asp:HiddenField ID="HiddenFieldUrunID" runat="server" Value='<%# Eval("UrunID") %>' />
                                                <h2 class="fs-16 mb-1"><a href="UrunBilgisi.aspx?id=<%# Eval("UrunID") %>" class="text-dark hover-primary text-truncate"><%# Eval("UrunAdi") %></a></h2>
                                                <p class="font-weight-500 text-gray-light mb-1">1421 San Pedro St, Los Angeles</p>
                                                <p class="fs-17 font-weight-bold text-heading mb-1">
                                                    ₺<%# string.Format("{0:F2}", Eval("UrunFiyat")) %>
                                                </p>

                                                <div>
                                                    <asp:LinkButton ID="btnRemoveFavori" runat="server" CssClass="btn-transparent" Style="text-decoration: underline;" Text="Favorilerimden çıkar" OnClick="BtnRemoveFavori_Click" />
                                                </div>
                                                <div class="mt-2">
                                                    <asp:Button ID="BtnSepeteEkle" runat="server" Text="Sepete Ekle" OnClick="BtnSepeteEkle_Click" CssClass="btn badge-primary btn" />
                                                </div>
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
                </div>
            </section>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
