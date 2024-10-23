using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class AnaSayfa : System.Web.UI.Page
    {
        Sepetim sepetim = new Sepetim();
        Urunler UrunlerSayfasi = new Urunler();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FavoriUrunler();
                KategorileriYukle();
                //AnaSayfaGiris();
                if (Session["KullaniciID"] != null)
                {
                    PanelSepet.Visible = true;
                    Sepetteki_Urunler();
                }
                else
                {
                    PanelSepet.Visible = false;
                }
            }
            HttpCookie visitCookie = Request.Cookies["visitedToday"];
            string currentDate = DateTime.Now.ToString("yyyy-MM-dd");

            if (visitCookie == null || visitCookie.Value != currentDate)
            {
                // Eğer çerez yoksa ya da tarihi bugünden farklıysa (ilk kez bugün ziyaret ediyorsa)
                IncrementDailyVisit();

                // Çerezi oluştur ve bugünkü tarih ile kaydet, tarayıcıda 1 gün sakla
                HttpCookie newVisitCookie = new HttpCookie("visitedToday");
                newVisitCookie.Value = currentDate;
                newVisitCookie.Expires = DateTime.Now.AddDays(1);  // Çerez 1 gün geçerli olacak
                Response.Cookies.Add(newVisitCookie);
            }
        }
        private void IncrementDailyVisit()
        {
            // SQL sorgusu: Günlük ziyaret sayısını arttır
            string query = @"
                IF EXISTS (SELECT 1 FROM GunlukZiyaretler WHERE ZiyaretTarihi = CAST(GETDATE() AS DATE))
                BEGIN
                    -- Kayıt varsa güncelle
                    UPDATE GunlukZiyaretler
                    SET ZiyaretSayisi = ZiyaretSayisi + 1
                    WHERE ZiyaretTarihi = CAST(GETDATE() AS DATE);
                END
                ELSE
                BEGIN
                    -- Kayıt yoksa yeni satır ekle
                    INSERT INTO GunlukZiyaretler (ZiyaretTarihi, ZiyaretSayisi)
                    VALUES (CAST(GETDATE() AS DATE), 1);
                END;
                ";

            using (SqlCommand command = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                command.ExecuteNonQuery();
            }
        }


        public void FavoriUrunler()
        {
            string query = @"SELECT u.* FROM Urun_Table u INNER JOIN AnasayfaFavoriUrun_Table afu ON u.UrunID = afu.AnaSayfaFavoriUrunID";

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterFavoriUrunler.DataSource = dr;
                    RepeaterFavoriUrunler.DataBind();
                }
            }
        }

        //public void SliderUrunler()
        //{
        //    string query = @"SELECT u.* FROM Urun_Table u INNER JOIN AnasayfaSliderUrun_Table asu ON u.UrunID = asu.AnaSayfaSliderUrunID";

        //    using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
        //    {
        //        SqlConnectionClass.CheckConnection();

        //        using (SqlDataReader dr = commandList.ExecuteReader())
        //        {
        //            RepeaterSliderUrunler.DataSource = dr;
        //            RepeaterSliderUrunler.DataBind();
        //        }
        //    }
        //}
        //public void AnaSayfaGiris()
        //{
        //    string query = @"SELECT * FROM AnaSayfaGiris_Table";

        //    using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
        //    {
        //        SqlConnectionClass.CheckConnection();

        //        using (SqlDataReader dr = commandList.ExecuteReader())
        //        {
        //            RepeaterAnaSayfaGiris.DataSource = dr;
        //            RepeaterAnaSayfaGiris.DataBind();
        //        }
        //    }
        //}
        protected void CheckBoxFavorilereEkle_CheckedChanged(object sender, EventArgs e)
        {

            CheckBox checkBox = (CheckBox)sender;
            RepeaterItem item = (RepeaterItem)checkBox.NamingContainer;
            HiddenField hiddenFieldUrunID = (HiddenField)item.FindControl("HiddenFieldUrunID");

            int urunId;
            if (int.TryParse(hiddenFieldUrunID.Value, out urunId))
            {
                if (checkBox.Checked)
                {
                    // Checkbox işaretlenmişse, veritabanına ekleme işlemi yapılır.

                    UrunlerSayfasi.AddToFavorites(urunId);
                }
                else
                {
                    // Checkbox işaretlenmemişse, veritabanından çıkarma işlemi yapılır.
                    UrunlerSayfasi.RemoveFromFavorites(urunId);
                }
            }
            else
            {

            }
        }
        protected void BtnSepeteEkle_Click(object sender, EventArgs e)
        {
            HiddenField hiddenField = (HiddenField)((Button)sender).NamingContainer.FindControl("HiddenFieldUrunID");
            if (hiddenField != null)
            {
                int urunID = Convert.ToInt32(hiddenField.Value);
                string query = @"SELECT UrunAdi FROM Urun_Table WHERE UrunID=@purunid";

                using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
                {
                    commandList.Parameters.AddWithValue("@purunid", urunID);
                    SqlConnectionClass.CheckConnection();

                    using (SqlDataReader reader = commandList.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string urunAdi = reader.GetString(reader.GetOrdinal("UrunAdi"));
                            reader.Close();
                            // Ürün bilgilerini Sepet_Ekle metoduna iletin
                            Sepet_Ekle(urunID, 1); // Fiyatı kaldırdık
                        }
                        else
                        {
                            // Ürün bulunamadıysa yapılacak işlemler
                        }
                    }
                }
            }
        }

        public void Sepet_Ekle(int urunID, int adet)
        {
            if (Session["KullaniciID"] == null)
            {
                // Kullanıcı girişi yapılmamışsa burada bir işlem yapabilirsiniz
                return;
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
                SqlCommand commandSepet = new SqlCommand("INSERT INTO Sepet_Table(SepetOlusturanID, SepetOlusturmaTarihi) VALUES (@psepetolusturan, @psepetolusturmatarihi); SELECT SCOPE_IDENTITY();", SqlConnectionClass.connection);
                commandSepet.Parameters.AddWithValue("@psepetolusturan", kullaniciID);
                commandSepet.Parameters.AddWithValue("@psepetolusturmatarihi", currentDateTime);
                sepetID = Convert.ToInt32(commandSepet.ExecuteScalar());
            }

            // Sepet ID'yi session'a kaydet
            Session["SepetID"] = sepetID;

            // Ürünün sepette mevcut olup olmadığını kontrol et
            SqlCommand commandCheckProduct = new SqlCommand("SELECT SepetUrunAdet FROM Sepet_Icerik_Table WHERE SepetinID = @psepetid AND SepetUrunID = @purunid", SqlConnectionClass.connection);
            commandCheckProduct.Parameters.AddWithValue("@psepetid", sepetID);
            commandCheckProduct.Parameters.AddWithValue("@purunid", urunID);

            object existingProduct = commandCheckProduct.ExecuteScalar();

            if (existingProduct != null)
            {
                // Ürün sepette mevcut, adeti artır
                int mevcutAdet = Convert.ToInt32(existingProduct);
                int yeniAdet = mevcutAdet + adet;

                // Sepet içeriği güncelle
                SqlCommand commandUpdateAdet = new SqlCommand("UPDATE Sepet_Icerik_Table SET SepetUrunAdet = @yeniAdet WHERE SepetinID = @psepetid AND SepetUrunID = @purunid", SqlConnectionClass.connection);
                commandUpdateAdet.Parameters.AddWithValue("@yeniAdet", yeniAdet);
                commandUpdateAdet.Parameters.AddWithValue("@psepetid", sepetID); // Sepet ID'yi ekle
                commandUpdateAdet.Parameters.AddWithValue("@purunid", urunID); // Ürün ID'yi ekle
                commandUpdateAdet.ExecuteNonQuery();
            }
            else
            {
                // Ürün sepette mevcut değil, yeni kayıt ekle
                SqlCommand commandEkle = new SqlCommand("INSERT INTO Sepet_Icerik_Table (SepetinID, SepetUrunID, SepetUrunAdet) VALUES (@psepetid, @purunid, @padet)", SqlConnectionClass.connection);
                commandEkle.Parameters.AddWithValue("@psepetid", sepetID);
                commandEkle.Parameters.AddWithValue("@purunid", urunID);
                commandEkle.Parameters.AddWithValue("@padet", adet);

                commandEkle.ExecuteNonQuery();
            }

            // Sepet toplam tutarını güncelleme kısmı kaldırıldı

            Sepetteki_Urunler();
            UpdatePanelSepetimdekiler.Update();
        }

        protected void BtnSepetimdenCikar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int icerikID = Convert.ToInt32(btn.CommandArgument);
            int kullaniciID = (int)Session["KullaniciID"];

            SqlCommand commandDelete = new SqlCommand("DELETE FROM Sepet_Icerik_Table WHERE IcerikID = @icerikid", SqlConnectionClass.connection);
            commandDelete.Parameters.AddWithValue("@icerikid", icerikID);
            commandDelete.Parameters.AddWithValue("@kullaniciID", kullaniciID);
            SqlConnectionClass.CheckConnection();

            int affectedRows = commandDelete.ExecuteNonQuery();

            if (affectedRows > 0)
            {
                Sepetteki_Urunler();
            }
            else
            {

            }
        }
        public void Sepetteki_Urunler()
        {
            int sepetid = sepetim.SepetID();
            string query = @"SELECT Urun_Table.*, Sepet_Icerik_Table.*
                     FROM Sepet_Icerik_Table 
                     INNER JOIN Urun_Table ON Sepet_Icerik_Table.SepetUrunID = Urun_Table.UrunID 
                     WHERE Sepet_Icerik_Table.SepetinID=@psepetid";

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {

                SqlConnectionClass.CheckConnection();

                commandList.Parameters.AddWithValue("@psepetid", sepetid);


                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterSepetIcerik.DataSource = dr;
                    RepeaterSepetIcerik.DataBind();
                }
            }

        }
        private void KategorileriYukle()
        {
            string query = @"SELECT Kategori, KategoriResim FROM Kategori_Table";

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {

                SqlConnectionClass.CheckConnection();


                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterKategoriler.DataSource = dr;
                    RepeaterKategoriler.DataBind();
                }
            }
        }
    }
}