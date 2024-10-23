<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSayfasi.Master" AutoEventWireup="true" CodeBehind="GenelBilgiler.aspx.cs" Inherits="KıyafetSitesi.GenelBilgiler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main id="content" class="bg-gray-01">
        <div class="px-3 px-lg-6 px-xxl-13 py-5 py-lg-10">
            <div class="d-flex flex-wrap flex-md-nowrap mb-6">
                <div class="mr-0 mr-md-auto">
                    <h2 class="mb-0 text-heading fs-22 lh-15">Welcome back, Ronald Hunter!</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. At iusto, laboriosam. Atque</p>
                </div>
                <div>
                    <a href="dashboard-add-new-property.html" class="btn btn-primary btn-lg">
                        <span>Add New Property</span>
                        <span class="d-inline-block ml-1 fs-20 lh-1">
                            <svg class="icon icon-add-new">
                                <use xlink:href="#icon-add-new"></use></svg></span>
                    </a>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-xxl-3 mb-6">
                    <div class="card">
                        <div class="card-body row align-items-center px-6 py-7">
                            <div class="col-5">
                                <span class="w-83px h-83 d-flex align-items-center justify-content-center fs-36 badge badge-blue badge-circle">
                                    <svg class="icon icon-1">
                                        <use xlink:href="#icon-1"></use>
                                    </svg>
                                </span>
                            </div>
                            <div class="col-7 text-center">
                                <p class="fs-42 lh-12 mb-0 counterup" id="daily-visit-count" data-start="0" data-end='<%= dailyVisitCount %>' data-decimals="0" data-duration="1" data-separator=""><%= dailyVisitCount %></p>



                                <p>Site Ziyaret Sayısı</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xxl-3 mb-6">
                    <div class="card">
                        <div class="card-body row align-items-center px-6 py-7">
                            <div class="col-5">
                                <span class="w-83px h-83 d-flex align-items-center justify-content-center fs-36 badge badge-green badge-circle">
                                    <svg class="icon icon-2">
                                        <use xlink:href="#icon-2"></use></svg>
                                </span>
                            </div>
                            <div class="col-7 text-center">
                                <p class="fs-42 lh-12 mb-0 counterup" id="daily-order-count" data-start="0" data-end='<%= dailyOrderCount %>' data-decimals="0" data-duration="1" data-separator=""><%= dailyOrderCount %></p>
                                <p>Bugünki Toplam Sipariş</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xxl-3 mb-6">
                    <div class="card">
                        <div class="card-body row align-items-center px-6 py-7">
                            <div class="col-4">
                                <span class="w-83px h-83 d-flex align-items-center justify-content-center fs-36 badge badge-yellow badge-circle">
                                    <svg class="icon icon-review">
                                        <use xlink:href="#icon-review"></use></svg>
                                </span>
                            </div>
                            <div class="col-7 text-center">
                                <div class="d-flex align-items-center justify-content-center">
                                    <p class="fs-42 lh-12 mb-0"
                                        id="daily-order-total2">
                                        ₺
                                    </p>
                                    <p class="fs-42 lh-12 mb-0 counterup"
                                        id="daily-order-total"
                                        data-start="0"
                                        data-end='<%= wholePart %>'
                                        data-decimals="0"
                                        data-duration="1"
                                        data-separator="">
                                        <%= wholePart %>
                                    </p>
                                    <p class="fs-42 lh-12 mb-0">.</p>
                                    <p class="fs-42 lh-12 mb-0 counterup"
                                        id="daily-order-total1"
                                        data-start="0"
                                        data-end='<%= decimalPart %>'
                                        data-decimals="0"
                                        data-duration="1"
                                        data-separator="">
                                        <%= decimalPart %>
                                    </p>

                                </div>


                                <p>Günlük Sipariş Tutarı</p>
                            </div>



                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xxl-3 mb-6">
                    <div class="card">
                        <div class="card-body row align-items-center px-6 py-7">
                            <div class="col-5">
                                <span class="w-83px h-83 d-flex align-items-center justify-content-center fs-36 badge badge-pink badge-circle">
                                    <svg class="icon icon-heart">
                                        <use xlink:href="#icon-heart"></use></svg>
                                </span>
                            </div>
                            <div class="col-7 text-center">
                                <p class="fs-42 lh-12 mb-0 counterup" id="daily-user-count" data-start="0" data-end='<%= dailyYeniKullanici %>' data-decimals="0" data-duration="1" data-separator=""><%= dailyYeniKullanici %></p>
                                <p>Bugünki Yeni Kullanıcı</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xxl-8 mb-6">
                    <div class="card px-7 py-6 h-100 chart">
                        <div class="card-body p-0 collapse-tabs">
                            <div class="d-flex align-items-center mb-5">
                                <h2 class="mb-0 text-heading fs-22 lh-15 mr-auto">View statistics</h2>
                                <ul class="nav nav-pills justify-content-end d-none d-sm-flex nav-pills-01" role="tablist">
                                    <li class="nav-item px-5 py-1">
                                        <a class="nav-link active bg-transparent shadow-none p-0 letter-spacing-1" id="hours-tab" data-toggle="tab" href="#hours" role="tab" aria-controls="hours" aria-selected="true">Günlük</a>
                                    </li>
                                    <li class="nav-item px-5 py-1">
                                        <a class="nav-link bg-transparent shadow-none p-0 letter-spacing-1" id="weekly-tab" data-toggle="tab" href="#weekly" role="tab" aria-controls="weekly" aria-selected="false">Haftalık</a>
                                    </li>
                                    <li class="nav-item px-5 py-1">
                                        <a class="nav-link bg-transparent shadow-none p-0 letter-spacing-1" id="monthly-tab" data-toggle="tab" href="#monthly" role="tab" aria-controls="monthly" aria-selected="false">Aylık</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content shadow-none p-0">
                                <div id="collapse-tabs-accordion">
                                    <div class="tab-pane tab-pane-parent fade show active px-0" id="hours" role="tabpanel" aria-labelledby="hours-tab">
                                        <div class="card bg-transparent mb-sm-0 border-0">
                                            <div class="card-header d-block d-sm-none bg-transparent px-0 py-1 border-bottom-0" id="headingHours">
                                                <h5 class="mb-0">
                                                    <button class="btn collapse-parent font-size-h5 btn-block border shadow-none" data-toggle="collapse" data-target="#hours-collapse" aria-expanded="true" aria-controls="hours-collapse">
                                                        Hours
                                                    </button>
                                                </h5>
                                            </div>
                                            <div id="hours-collapse" class="collapse show collapsible" aria-labelledby="headingHours" data-parent="#collapse-tabs-accordion">
                                                <div class="card-body p-0 py-4">
                                                    <canvas class="chartjs" data-chart-options="[]" data-chart-labels='["05h","08h","11h","14h","17h","20h","23h"]' data-chart-datasets='[{"label":"Clicked","data":[<%= string.Join(",", DailyOrders) %>],"backgroundColor":"rgba(105, 105, 235, 0.1)","borderColor":"#6969eb","borderWidth":3,"fill":true},{"label":"View","backgroundColor":"rgba(254, 91, 52, 0.1)","borderColor":"#ff6935","borderWidth":3,"fill":true}]'></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane tab-pane-parent fade px-0" id="weekly" role="tabpanel" aria-labelledby="weekly-tab">
                                        <div class="card bg-transparent mb-sm-0 border-0">
                                            <div class="card-header d-block d-sm-none bg-transparent px-0 py-1 border-bottom-0" id="headingWeekly">
                                                <h5 class="mb-0">
                                                    <button class="btn collapse-parent font-size-h5 btn-block collapsed border shadow-none" data-toggle="collapse" data-target="#weekly-collapse" aria-expanded="true" aria-controls="weekly-collapse">
                                                        Weekly
                                                    </button>
                                                </h5>
                                            </div>
                                            <div id="weekly-collapse" class="collapse collapsible" aria-labelledby="headingWeekly" data-parent="#collapse-tabs-accordion">
                                                <div class="card-body p-0 py-4">
                                                    <canvas class="chartjs" data-chart-options="[]" data-chart-labels='["Mar 12","Mar 13","Mar 14","Mar 15","Mar 16","Mar 17","Mar 18","Mar 19"]' data-chart-datasets='[{"label":"Clicked","data":[<%= string.Join(",", WeeklyOrders) %>],"backgroundColor":"rgba(105, 105, 235, 0.1)","borderColor":"#6969eb","borderWidth":3,"fill":true},{"label":"View","backgroundColor":"rgba(254, 91, 52, 0.1)","borderColor":"#ff6935","borderWidth":3,"fill":true}]'></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane tab-pane-parent fade px-0" id="monthly" role="tabpanel" aria-labelledby="monthly-tab">
                                        <div class="card bg-transparent mb-sm-0 border-0">
                                            <div class="card-header d-block d-sm-none bg-transparent px-0 py-1 border-bottom-0" id="headingMonthly">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-block collapse-parent collapsed border shadow-none" data-toggle="collapse" data-target="#monthly-collapse" aria-expanded="true" aria-controls="monthly-collapse">
                                                        Monthly
                                                    </button>
                                                </h5>
                                            </div>
                                            <div id="monthly-collapse" class="collapse collapsible" aria-labelledby="headingMonthly" data-parent="#collapse-tabs-accordion">
                                                <div class="card-body p-0 py-4">
                                                    <canvas class="chartjs" data-chart-options="[]" data-chart-labels='["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]' data-chart-datasets='[{"label":"Clicked","data":[<%= string.Join(",", MonthlyOrders) %>],"backgroundColor":"rgba(105, 105, 235, 0.1)","borderColor":"#6969eb","borderWidth":3,"fill":true},{"label":"View","backgroundColor":"rgba(254, 91, 52, 0.1)","borderColor":"#ff6935","borderWidth":3,"fill":true}]'></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xxl-4 mb-6">
                    <div class="card px-7 py-6 h-100">
                        <div class="card-body p-0">
                            <h2 class="mb-2 text-heading fs-22 lh-15">Recent Activities</h2>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
