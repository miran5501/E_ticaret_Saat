using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Profilim1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {
                FavoriSayisiGuncelle();
                SiparisSayisiGuncelle();
            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
        }
        public void FavoriSayisiGuncelle()
        {
            if (Session["KullaniciID"] != null)
            {
                
            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            int favoriteCount = 0;


            string query = "SELECT COUNT(*) FROM Favoriler_Table WHERE KullaniciID=@Kullaniciid";
            int kullaniciıd = (int)Session["KullaniciID"];

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@Kullaniciid", kullaniciıd);

                object result = commandList.ExecuteScalar();
                if (result != null)
                {
                    favoriteCount = Convert.ToInt32(result);
                }
            }
            lblFavoriSayisi.Text = favoriteCount.ToString();

        }
        public void SiparisSayisiGuncelle()
        {

            int siparisCount = 0;
            if (Session["KullaniciID"] != null)
            {

                string query = "SELECT COUNT(*) FROM Siparis_Table WHERE SiparisVerenID=@Kullaniciid";
                int kullaniciıd = (int)Session["KullaniciID"];

                using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
                {
                    SqlConnectionClass.CheckConnection();
                    commandList.Parameters.AddWithValue("@Kullaniciid", kullaniciıd);

                    object result = commandList.ExecuteScalar();
                    if (result != null)
                    {
                        siparisCount = Convert.ToInt32(result);
                    }
                }
            }
            else
            {
                Response.Redirect("AnaSayfa.aspx");
            }
            lblSiparisSayisi.Text = siparisCount.ToString();
        }
    }
}