using KıyafetSitesi.Classlar;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace KıyafetSitesi
{
    public partial class Kullanicilar : System.Web.UI.Page
    {
        private int pageSize = 10; // Sayfa başına gösterilecek kullanıcı sayısı
        private int totalRecords;   // Toplam kullanıcı sayısı

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlPageSize.SelectedValue = "10"; // Varsayılan olarak 10 kayıt göster
                int pageIndex = GetPageIndex();
                KullanicilariGoster(pageIndex);
            }
        }


        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Sayfa boyutunu güncelle
            pageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            int pageIndex = GetPageIndex();
            KullanicilariGoster(pageIndex);
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

        private void KullanicilariGoster(int pageIndex)
        {
            string query = @"
                    SELECT * FROM 
                    (SELECT ROW_NUMBER() OVER (ORDER BY k.KullaniciID) AS RowNum, k.*, y.YetkiDurumu
                    FROM Kullanici_Table k
                    LEFT JOIN Yetki_Table y ON k.KullaniciYetkiID = y.YetkiID) AS Result
                    WHERE RowNum BETWEEN @StartRow AND @EndRow";

            int startRow = (pageIndex - 1) * pageSize + 1;
            int endRow = pageIndex * pageSize;

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                try
                {
                    connection.Open(); // Bağlantıyı açıyoruz

                    using (SqlCommand commandList = new SqlCommand(query, connection))
                    {
                        commandList.Parameters.AddWithValue("@StartRow", startRow);
                        commandList.Parameters.AddWithValue("@EndRow", endRow);

                        using (SqlDataReader dr = commandList.ExecuteReader())
                        {
                            RepeaterKullanicilar.DataSource = dr;
                            RepeaterKullanicilar.DataBind();
                        }
                    }

                    // Toplam kayıt sayısını al
                    TotalRecordCount();

                    // Sayfalama kontrolünü oluştur
                    SayfalamaKontrolu(pageIndex);
                }
                catch (Exception ex)
                {
                    // Bağlantı veya sorgu hatalarını burada yakalayabilirsiniz
                    throw new Exception("Kullanıcıları gösterirken bir hata oluştu: " + ex.Message);
                }
            }
        }

        private void TotalRecordCount()
        {
            string query = "SELECT COUNT(*) FROM Kullanici_Table";
            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    totalRecords = (int)command.ExecuteScalar();
                }
            }
        }

        private void SayfalamaKontrolu(int currentPage)
        {
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            paginationList.Text = ""; // Sayfalama kontrolü HTML'sini temizle

            // Önceki sayfa butonu
            if (currentPage > 1)
            {
                paginationList.Text += $"<li class='page-item'><a class='page-link' href='?page={currentPage - 1}&pageSize={pageSize}'><i class='far fa-angle-double-left'></i></a></li>";
            }

            // Sayfa numaraları
            if (totalPages > 1)
            {
                for (int i = 1; i <= totalPages; i++)
                {
                    if (i == currentPage)
                    {
                        paginationList.Text += $"<li class='page-item active'><a class='page-link' href='?page={i}&pageSize={pageSize}'>{i}</a></li>";
                    }
                    else
                    {
                        paginationList.Text += $"<li class='page-item'><a class='page-link' href='?page={i}&pageSize={pageSize}'>{i}</a></li>";
                    }
                }
            }

            // Sonraki sayfa butonu
            if (currentPage < totalPages)
            {
                paginationList.Text += $"<li class='page-item'><a class='page-link' href='?page={currentPage + 1}&pageSize={pageSize}'><i class='far fa-angle-double-right'></i></a></li>";
            }

            // Toplam sonuç bilgisi
            resultCountLabel.Text = $"{(currentPage - 1) * pageSize + 1}-{Math.Min(currentPage * pageSize, totalRecords)} of {totalRecords} Results";
        }

    }
}
