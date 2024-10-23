<%@ Page Title="" Language="C#" MasterPageFile="~/Profilim.master" AutoEventWireup="true" CodeBehind="Siparislerim.aspx.cs" Inherits="KıyafetSitesi.Siparislerim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10 invoice-listing">
            <div class="table-responsive">
                <table id="invoice-list" class="table table-hover bg-white border rounded-lg">
                    <thead>
                        <tr role="row">
                            <th class="py-6">Sipariş Id</th>
                            <th class="py-6">Sipariş Tarihi</th>
                            <th class="py-6">Tutar</th>
                            <th class="py-6">Sipariş Durumu</th>
                            <th class="no-sort py-6">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepeaterSiparisler" runat="server">
                            <ItemTemplate>
                                <tr role="row">

                                    <td class="align-middle">
                                        <a href='Siparislerim_Detay.aspx?SiparisID=<%# Eval("SiparisID") %>'>
                                            <span class="inv-number">#<%# Eval("SiparisID") %></span>
                                        </a>
                                    </td>
                                    </td>
                                <td class="align-middle"><span class="text-success pr-1"><i class="fal fa-calendar"></i></span><%# Eval("SiparisOlusturmaTarihi") %></td>
                                    <td class="align-middle"><span class="inv-amount">₺<%# string.Format("{0:F2}", Eval("SiparisTutari")) %></span></td>
                                    <td class="align-middle"><span class="badge badge-green text-capitalize"><%# Eval("SiparisDurumu") %></span></td>
                                    <td class="align-middle">
                                        <a href="#" data-toggle="tooltip" title="Edit" class="d-inline-block fs-18 text-muted hover-primary mr-5"><i class="fal fa-pencil-alt"></i></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
            <div class="mt-6">
                <div class="mt-6">
                    <nav>
                        <ul class="pagination rounded-active justify-content-center">
                            <asp:Literal ID="litPagination" runat="server" />
                        </ul>
                    </nav>
                </div>
                <div class="text-center mt-2">6-10 of 29 Results</div>
            </div>
        </div>
    </main>
</asp:Content>
