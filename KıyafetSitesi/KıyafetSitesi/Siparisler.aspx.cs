using KıyafetSitesi.Classlar;
using System;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Siparisler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ddlPageSize.SelectedValue = "10"; // Varsayılan olarak 10 kayıt göster

                // Sayfa bilgilerini ayarla
                int pageIndex = 1;
                if (Request.QueryString["page"] != null)
                {
                    int.TryParse(Request.QueryString["page"], out pageIndex);
                }

                int totalRecords = GetTotalRecordCount();
                int pageSize = Convert.ToInt32(ddlPageSize.SelectedValue); // Seçilen pageSize değerini al
                int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
                int previousPage = pageIndex > 1 ? pageIndex - 1 : 1;
                int nextPage = pageIndex < totalPages ? pageIndex + 1 : totalPages;

                // Dinamik olarak sayfalama linklerini oluştur
                BuildPagination(totalPages, pageIndex, previousPage, nextPage);

                // Siparişleri getir
                SiparisleriGoruntule(pageIndex, pageSize);
            }
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            int pageIndex = 1; // Sayfayı 1'den başlat
            int pageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            int totalRecords = GetTotalRecordCount();
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
            int previousPage = pageIndex > 1 ? pageIndex - 1 : 1;
            int nextPage = pageIndex < totalPages ? pageIndex + 1 : totalPages;
            
            // Dinamik olarak sayfalama linklerini oluştur
            BuildPagination(totalPages, pageIndex, previousPage, nextPage);

            // Siparişleri getir
            SiparisleriGoruntule(pageIndex, pageSize);
        }

        private int GetTotalRecordCount()
        {
            string countQuery = "SELECT COUNT(*) FROM Siparis_Table";
            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand countCommand = new SqlCommand(countQuery, connection);

                connection.Open();  // Bağlantıyı açıyoruz
                return (int)countCommand.ExecuteScalar();
            }
        }

        private void BuildPagination(int totalPages, int pageIndex, int previousPage, int nextPage)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append($"<li class='page-item'><a class='page-link' href='?page={previousPage}'><i class='far fa-angle-double-left'></i></a></li>");

            for (int i = 1; i <= totalPages; i++)
            {
                sb.Append($"<li class='page-item {(i == pageIndex ? "active" : "")}'><a class='page-link' href='?page={i}'>{i}</a></li>");
            }

            sb.Append($"<li class='page-item'><a class='page-link' href='?page={nextPage}'><i class='far fa-angle-double-right'></i></a></li>");

            litPagination.Text = sb.ToString(); // litPagination bir Literal kontrolü
            int pageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            resultCountLabel.Text = $"{(pageIndex - 1) * pageSize + 1}-{Math.Min(pageIndex * pageSize, GetTotalRecordCount())} of {GetTotalRecordCount()} Results";
        }
        private void SiparisleriGoruntule(int pageIndex, int pageSize)
        {
            int offset = (pageIndex - 1) * pageSize;

            string query = @"
        WITH OrderedSiparis AS (
            SELECT 
                s.*, 
                u.KullaniciIsim, 
                u.KullaniciSoyisim, 
                ROW_NUMBER() OVER (ORDER BY s.SiparisOlusturmaTarihi ASC) AS RowNum
            FROM Siparis_Table s
            INNER JOIN Kullanici_Table u ON s.SiparisVerenID = u.KullaniciID
        )
        SELECT * FROM OrderedSiparis
        WHERE RowNum BETWEEN @offset + 1 AND @offset + @pageSize";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);
                connection.Open();
                commandList.Parameters.AddWithValue("@offset", offset);
                commandList.Parameters.AddWithValue("@pageSize", pageSize);

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterSiparisler.DataSource = dr;
                    RepeaterSiparisler.DataBind(); // Repeater kontrolünü verilerle bağlar
                }
            }
        }


    }
}
