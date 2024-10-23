using KıyafetSitesi.Classlar;
using System;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace KıyafetSitesi
{
    public partial class Siparislerim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] == null)
            {
                Response.Redirect("AnaSayfa.aspx");

            }
            if (!IsPostBack)
            {
                int pageIndex = 1;
                if (Request.QueryString["page"] != null)
                {
                    int.TryParse(Request.QueryString["page"], out pageIndex);
                }

                int kullaniciid = (int)Session["KullaniciID"]; // Kullanıcı ID'si oturumdan alınıyor
                int totalRecords = GetTotalRecordCount(kullaniciid); // Toplam sipariş sayısını getiren metod
                int pageSize = 10; // Sayfa başına gösterilecek sipariş sayısı
                int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
                int previousPage = pageIndex > 1 ? pageIndex - 1 : 1;
                int nextPage = pageIndex < totalPages ? pageIndex + 1 : totalPages;

                // Dinamik olarak sayfalama linklerini oluştur
                BuildPagination(totalPages, pageIndex, previousPage, nextPage);

                // Siparişleri getiren metodu çağır
                SiparisleriGoruntule(kullaniciid, pageIndex, pageSize);
            }
        }

        // Toplam sipariş sayısını getiren metod
        private int GetTotalRecordCount(int kullaniciid)
        {
            string countQuery = "SELECT COUNT(*) FROM Siparis_Table WHERE SiparisVerenID = @kullaniciID";
            using (SqlCommand countCommand = new SqlCommand(countQuery, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                countCommand.Parameters.AddWithValue("@kullaniciID", kullaniciid);
                return (int)countCommand.ExecuteScalar();
            }
        }

        // Dinamik sayfalama yapısı oluşturan metod
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
        }

        // Siparişleri sayfalama ile getiren metod
        private void SiparisleriGoruntule(int kullaniciid, int pageIndex, int pageSize)
        {
            int offset = (pageIndex - 1) * pageSize;

            string query = @"
                WITH OrderedSiparis AS (
                    SELECT 
                        *, 
                        ROW_NUMBER() OVER (ORDER BY SiparisOlusturmaTarihi ASC) AS RowNum
                    FROM Siparis_Table
                    WHERE SiparisVerenID = @kullaniciID
                )
                SELECT * FROM OrderedSiparis
                WHERE RowNum BETWEEN @offset + 1 AND @offset + @pageSize";

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@kullaniciID", kullaniciid);
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
