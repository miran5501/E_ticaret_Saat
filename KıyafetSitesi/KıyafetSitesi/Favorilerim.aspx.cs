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
    public partial class Favorilerim : System.Web.UI.Page
    {
        Urunler urunler = new Urunler();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KullaniciID"] == null)
                {
                    Response.Redirect("AnaSayfa.aspx");
                }
                else
                {
                    FavoriUrunler();
                }
            }
        }

        private void FavoriUrunler()
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            // Kullanıcı ID'sini al
            int kullaniciId = (int)Session["KullaniciID"];

            // SQL sorgusunu hazırlayıp ürün ID'lerini al
            string favoriUrunlerQuery = @"
                                        SELECT UrunID 
                                        FROM Favoriler_Table 
                                        WHERE KullaniciID = @KullaniciID";

            List<int> favoriUrunIds = new List<int>();

            using (SqlCommand command = new SqlCommand(favoriUrunlerQuery, SqlConnectionClass.connection))
            {
                command.Parameters.AddWithValue("@KullaniciID", kullaniciId);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        favoriUrunIds.Add(reader.GetInt32(0)); // UrunID'yi listeye ekle
                    }
                }
            }

            // Eğer favori ürün ID'leri varsa, ürün bilgilerini çek
            if (favoriUrunIds.Count > 0)
            {
                // UrunID'leri için sorguyu hazırla
                string urunlerQuery = @"
                                        SELECT * 
                                        FROM Urun_Table 
                                        WHERE UrunID IN (" + string.Join(",", favoriUrunIds) + @")";

                using (SqlCommand commandList = new SqlCommand(urunlerQuery, SqlConnectionClass.connection))
                {
                    SqlConnectionClass.CheckConnection();

                    using (SqlDataReader dr = commandList.ExecuteReader())
                    {
                        RepeaterFavoriUrunler.DataSource = dr;
                        RepeaterFavoriUrunler.DataBind();
                    }
                }
            }
        }

        protected void BtnSepeteEkle_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            HiddenField hiddenField = (HiddenField)((Button)sender).NamingContainer.FindControl("HiddenFieldUrunID");
            if (hiddenField != null)
            {
                int urunID = Convert.ToInt32(hiddenField.Value);
                string query = @"SELECT UrunFiyat, UrunAdi FROM Urun_Table WHERE UrunID=@purunid";

                using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
                {
                    commandList.Parameters.AddWithValue("@purunid", urunID);
                    SqlConnectionClass.CheckConnection();

                    using (SqlDataReader reader = commandList.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            float urunFiyati = (float)reader.GetDouble(reader.GetOrdinal("UrunFiyat"));
                            string urunAdi = reader.GetString(reader.GetOrdinal("UrunAdi"));
                            reader.Close();
                            // Ürün bilgilerini Sepet_Ekle metoduna iletin
                            Sepet_Ekle(urunID, 1, urunFiyati);
                        }
                        else
                        {
                            // Ürün bulunamadıysa yapılacak işlemler
                        }
                    }
                }
            }
        }
        protected void BtnRemoveFavori_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            HiddenField hiddenField = (HiddenField)((LinkButton)sender).NamingContainer.FindControl("HiddenFieldUrunID");
            if (hiddenField != null)
            {
                int urunID = Convert.ToInt32(hiddenField.Value);
                urunler.RemoveFromFavorites(urunID);
                UpdatePanelFavorilerim.Update();
                FavoriUrunler();
            }
        }
        
        public void Sepet_Ekle(int urunID, int adet, float urunFiyati)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            int kullaniciID = (int)Session["KullaniciID"];
            DateTime currentDateTime = DateTime.Now;

            // Kullanıcının mevcut sepetini kontrol et
            SqlCommand commandCheckSepet = new SqlCommand("SELECT SepetID FROM Sepet_Table WHERE SepetOlusturanID = @psepetolusturan", SqlConnectionClass.connection);
            commandCheckSepet.Parameters.AddWithValue("@psepetolusturan", kullaniciID);

            SqlConnectionClass.CheckConnection();
            object result = commandCheckSepet.ExecuteScalar();
            int sepetID;

            if (result != null)
            {
                // Mevcut sepet varsa sepet ID'sini al
                sepetID = Convert.ToInt32(result);
            }
            else
            {
                // Mevcut sepet yoksa yeni bir sepet oluştur
                SqlCommand commandSepet = new SqlCommand("INSERT INTO Sepet_Table(SepetOlusturanID, SepetOlusturmaTarihi, SepetTutari) VALUES (@psepetolusturan, @psepetolusturmatarihi, @psepettutari); SELECT SCOPE_IDENTITY();", SqlConnectionClass.connection);
                commandSepet.Parameters.AddWithValue("@psepetolusturan", kullaniciID);
                commandSepet.Parameters.AddWithValue("@psepetolusturmatarihi", currentDateTime);
                commandSepet.Parameters.AddWithValue("@psepettutari", 0);
                sepetID = Convert.ToInt32(commandSepet.ExecuteScalar());
            }

            // Sepet ID'yi session'a kaydet
            Session["SepetID"] = sepetID;

            // Ürün sepete ekleniyor
            SqlCommand commandEkle = new SqlCommand("INSERT INTO Sepet_Icerik_Table (SepetinID, SepetUrunID, SepetUrunAdet, SepetUrunFiyatBirim, SepetUrunFiyatToplam) VALUES (@psepetid, @purunid, @padet, @purunfiyati, @puruntoplamfiyati)", SqlConnectionClass.connection);
            commandEkle.Parameters.AddWithValue("@psepetid", sepetID);
            commandEkle.Parameters.AddWithValue("@purunid", urunID);
            commandEkle.Parameters.AddWithValue("@padet", adet);
            commandEkle.Parameters.AddWithValue("@purunfiyati", urunFiyati);
            commandEkle.Parameters.AddWithValue("@puruntoplamfiyati", urunFiyati * adet);
            commandEkle.ExecuteNonQuery();

            // Sepet toplam tutarını güncelle
            SqlCommand updateSepetTutar = new SqlCommand("UPDATE Sepet_Table SET SepetTutari = (SELECT SUM(SepetUrunFiyatToplam) FROM Sepet_Icerik_Table WHERE SepetinID = @psepetid) WHERE SepetID = @psepetid", SqlConnectionClass.connection);
            updateSepetTutar.Parameters.AddWithValue("@psepetid", sepetID);
            updateSepetTutar.ExecuteNonQuery();

        }

    }
}