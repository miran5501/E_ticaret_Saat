using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Profilim : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kullanıcının oturumda olup olmadığını kontrol et (örneğin, Session kullanarak)
                if (Session["KullaniciID"] != null)
                {
                    int kullaniciID = Convert.ToInt32(Session["KullaniciID"]);
                    GetUserDetails(kullaniciID); // Kullanıcı bilgilerini çek ve TextBox'lara yerleştir
                }
                else
                {
                    // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                    Response.Redirect("AnaSayfa.aspx");
                }
            }
        }

        // Kullanıcı bilgilerini almak için fonksiyon
        private void GetUserDetails(int kullaniciID)
        {
            using (SqlConnection con = new SqlConnection(SqlConnectionClass.connectionString))
            {
                string query = "SELECT KullaniciIsim, KullaniciSoyisim, KullaniciTelefon_No, KullaniciE_mail FROM Kullanici_Table WHERE kullaniciID = @kullaniciID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@kullaniciID", kullaniciID);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // TextBox'lara kullanıcı bilgilerini doldur
                    txtisim.Text = reader["KullaniciIsim"].ToString();
                    txtsoyisim.Text = reader["KullaniciSoyisim"].ToString();
                    txttelefonno.Text = reader["KullaniciTelefon_No"].ToString();
                    txtemail.Text = reader["KullaniciE_mail"].ToString();
                }
                con.Close();
            }
        }

        // Güncelleme butonuna tıklandığında kullanıcı bilgilerini güncelle
        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {
                int KullaniciID = Convert.ToInt32(Session["KullaniciID"]);
                UpdateUserDetails(KullaniciID);
            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
        }

        // Kullanıcı bilgilerini güncelleme fonksiyonu
        private void UpdateUserDetails(int KullaniciID)
        {
            using (SqlConnection con = new SqlConnection(SqlConnectionClass.connectionString))
            {
                string query = "UPDATE Kullanici_Table SET KullaniciIsim = @KullaniciIsim, KullaniciSoyisim = @KullaniciSoyisim, KullaniciTelefon_No = @KullaniciTelefon_No, KullaniciE_mail = @KullaniciE_mail WHERE KullaniciID = @KullaniciID";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@KullaniciIsim", txtisim.Text);
                cmd.Parameters.AddWithValue("@KullaniciSoyisim", txtsoyisim.Text);
                cmd.Parameters.AddWithValue("@KullaniciTelefon_No", txttelefonno.Text);
                cmd.Parameters.AddWithValue("@KullaniciE_mail", txtemail.Text);
                cmd.Parameters.AddWithValue("@KullaniciID", KullaniciID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }


}