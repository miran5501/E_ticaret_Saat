using KıyafetSitesi.Classlar;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace KıyafetSitesi
{
    public partial class AdminUrunler : System.Web.UI.Page
    {
        private int pageSize = 10;  // Sayfa başına gösterilecek ürün sayısı
        private int totalRecords;  // Toplam ürün sayısı

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Varsayılan sayfa boyutunu ayarla
                ddlPageSize.SelectedValue = "10";

                // Sayfa numarasını al
                int pageIndex = GetPageIndex();

                // Arama terimini al
                string searchQuery = Request.QueryString["search"] ?? string.Empty;

                // Ürünleri getir
                UrunleriGetir(pageIndex, searchQuery);
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Arama terimini al ve sayfayı yenile
            string searchQuery = txtSearch.Text.Trim();
            Response.Redirect($"AdminUrunler.aspx?search={searchQuery}");
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Sayfa boyutunu güncelle
            pageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            // Mevcut sayfa numarasını al
            int pageIndex = GetPageIndex();
            // Ürünleri getir
            string searchQuery = Request.QueryString["search"] ?? string.Empty;
            UrunleriGetir(pageIndex, searchQuery);
        }

        private int GetPageIndex()
        {
            int pageIndex = 1;
            if (Request.QueryString["page"] != null)
            {
                int.TryParse(Request.QueryString["page"], out pageIndex);
            }
            return pageIndex;
        }

        private void UrunleriGetir(int pageIndex, string searchQuery)
        {
            string query = @"SELECT * FROM 
                     (SELECT ROW_NUMBER() OVER (ORDER BY UrunID) AS RowNum, * 
                      FROM Urun_Table 
                      WHERE UrunAdi LIKE @SearchQuery) AS Result
                      WHERE RowNum BETWEEN @StartRow AND @EndRow";

            int startRow = (pageIndex - 1) * pageSize + 1;
            int endRow = pageIndex * pageSize;

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StartRow", startRow);
                    command.Parameters.AddWithValue("@EndRow", endRow);
                    command.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%"); // Arama terimini ekleyin

                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        RepeaterTumUrunler.DataSource = dr;
                        RepeaterTumUrunler.DataBind();
                    }
                }
            }

            TotalRecordCount(searchQuery);  // Toplam kayıt sayısını hesapla
            SayfalamaKontrolu(pageIndex, searchQuery);  // Dinamik sayfalama oluştur
        }

        
        private void TotalRecordCount(string searchQuery)
        {
            string query = "SELECT COUNT(*) FROM Urun_Table WHERE UrunAdi LIKE @SearchQuery";
            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%"); // Arama terimini ekleyin

                    connection.Open();
                    totalRecords = (int)command.ExecuteScalar();
                    lblurunsayisi.Text = totalRecords.ToString();
                }
            }

        }


        private void SayfalamaKontrolu(int currentPage, string searchQuery)
        {
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
            paginationList.InnerHtml = ""; // Sayfalama kontrolü HTML'sini temizle

            // Önceki sayfa butonu
            if (currentPage > 1)
            {
                paginationList.InnerHtml += $"<li class='page-item'><a class='page-link' href='?page={currentPage - 1}&pageSize={pageSize}&search={searchQuery}'><i class='far fa-angle-double-left'></i></a></li>";
            }

            // Sayfa numaraları
            if (totalPages > 1)
            {
                // Görüntülenecek sayfa aralığı
                int startPage = Math.Max(1, currentPage - 2);
                int endPage = Math.Min(totalPages, currentPage + 2);

                // Sayfa numaralarını ekle
                for (int i = startPage; i <= endPage; i++)
                {
                    if (i == currentPage)
                    {
                        paginationList.InnerHtml += $"<li class='page-item active'><a class='page-link' href='?page={i}&pageSize={pageSize}&search={searchQuery}'>{i}</a></li>";
                    }
                    else
                    {
                        paginationList.InnerHtml += $"<li class='page-item'><a class='page-link' href='?page={i}&pageSize={pageSize}&search={searchQuery}'>{i}</a></li>";
                    }
                }

                // "..." ifadesini ekle
                if (endPage < totalPages)
                {
                    paginationList.InnerHtml += $"<li class='page-item'><span class='page-link'>...</span></li>";
                }

                // Son sayfayı ekle
                if (endPage < totalPages)
                {
                    paginationList.InnerHtml += $"<li class='page-item'><a class='page-link' href='?page={totalPages}&pageSize={pageSize}&search={searchQuery}'>{totalPages}</a></li>";
                }
            }

            // Sonraki sayfa butonu
            if (currentPage < totalPages)
            {
                paginationList.InnerHtml += $"<li class='page-item'><a class='page-link' href='?page={currentPage + 1}&pageSize={pageSize}&search={searchQuery}'><i class='far fa-angle-double-right'></i></a></li>";
            }

            // Toplam sonuç bilgisi
            resultCountLabel.Text = $"{(currentPage - 1) * pageSize + 1}-{Math.Min(currentPage * pageSize, totalRecords)} of {totalRecords} Results";
        }


    }
}
