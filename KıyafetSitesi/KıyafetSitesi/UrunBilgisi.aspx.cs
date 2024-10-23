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
    public partial class UrunBilgisi : System.Web.UI.Page
    {
        Urunler UrunlerSayfasi = new Urunler();
        Sepetim sepetim = new Sepetim();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.DataBind();
            if (!IsPostBack)
            {
                if (Session["KullaniciID"] == null)
                {
                    PanelSepet.Visible = false;
                    
                }
                else
                {
                    PanelSepet.Visible = true;
                    Sepetteki_Urunler();
                }


                string urunIDStr = Request.QueryString["id"];
                PanelSepet.Visible = true;


                if (int.TryParse(urunIDStr, out int urunID))
                {
                    if (Session["ZiyaretEdilen_" + urunID] == null)
                    {
                        // Ziyaret sayısını artır ve oturuma işaret ekle
                        ZiyaretSayisiniArtir(urunID);
                        Session["ZiyaretEdilen_" + urunID] = true;
                    }
                    // Ürün ID'sini kullanarak ürünü veritabanından çekebilirsiniz
                    OzellikleriGetir(urunID);
                    UrunListele(urunID);
                    Oneriler();
                    UrunResimleri(urunID);
                    UrunResimleri2(urunID);
                    //OnerilerAltKisim();

                    if (Session["KullaniciID"] != null)
                    {
                        int kullaniciId = (int)Session["KullaniciID"];
                        UrunlerSayfasi.LoadFavoriteItems(RepeaterOnerilenUrunler);
                        bool favorideMi = IsFavorite(urunID, kullaniciId);
                        CheckBoxFavorilereEkle1.Checked = favorideMi;
                    }
                    

                    // CheckBox'ı seçili yapıyoruz.
                    
                }
                else
                {
                    Response.Redirect("AnaSayfa.aspx");
                    // Hatalı veya eksik ürün ID'si durumu
                }


            }
            // URL'den ürün ID'sini almak
        }

        private void ZiyaretSayisiniArtir(int urunID)
        {
            string query = "UPDATE Urun_Table SET ZiyaretSayisi = ISNULL(ZiyaretSayisi, 0) + 1 WHERE UrunID = @UrunID";

            using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
            {
                cmd.Parameters.AddWithValue("@UrunID", urunID);
                SqlConnectionClass.CheckConnection();
                cmd.ExecuteNonQuery();
            }
        }

        private void UrunListele(int urunID)
        {
            string query = @"SELECT * FROM Urun_Table WHERE UrunID=@purunıd";


            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                commandList.Parameters.AddWithValue("@purunıd", urunID);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterUrunBilgisi.DataSource = dr;
                    RepeaterUrunBilgisi.DataBind();
                }
            }
        }
        private void UrunResimleri(int urunID)
        {
            string query = @"SELECT UrunResmi, UrunYanResmi1, UrunYanResmi2 FROM Urun_Table WHERE UrunID=@purunıd";


            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                commandList.Parameters.AddWithValue("@purunıd", urunID);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterUrunResimler1.DataSource = dr;
                    RepeaterUrunResimler1.DataBind();
                }
            }
        }
        private void UrunResimleri2(int urunID)
        {
            string query = @"SELECT UrunResmi, UrunYanResmi1, UrunYanResmi2 FROM Urun_Table WHERE UrunID=@purunıd";


            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                commandList.Parameters.AddWithValue("@purunıd", urunID);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterUrunResimler2.DataSource = dr;
                    RepeaterUrunResimler2.DataBind();
                }
            }
        }

        private void Oneriler()
        {
            string query = @"SELECT TOP 5 * FROM Urun_Table ORDER BY NEWID()";


            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterOnerilenUrunler.DataSource = dr;
                    RepeaterOnerilenUrunler.DataBind();
                }
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
        protected void CheckBoxFavorilereEkle_CheckedChanged1(object sender, EventArgs e)
        {
            string urunIDStr = Request.QueryString["id"];

            if (int.TryParse(urunIDStr, out int urunID))
            {
                CheckBox checkBox = (CheckBox)sender;


                if (checkBox.Checked)
                {
                    // Checkbox işaretlenmişse, veritabanına ekleme işlemi yapılır.

                    UrunlerSayfasi.AddToFavorites(urunID);
                }
                else
                {
                    // Checkbox işaretlenmemişse, veritabanından çıkarma işlemi yapılır.
                    UrunlerSayfasi.RemoveFromFavorites(urunID);
                }
            }
        }


        private bool IsFavorite(int urunID, int kullaniciID)
        {
            string query = "SELECT COUNT(1) FROM Favoriler_Table WHERE UrunID = @UrunID AND KullaniciID = @KullaniciID";
            SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection);
            cmd.Parameters.AddWithValue("@UrunID", urunID);
            cmd.Parameters.AddWithValue("@KullaniciID", kullaniciID);


            int count = (int)cmd.ExecuteScalar();
            return count > 0;

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

        private void OzellikleriGetir(int urunid)
        {

            string query = @"
            SELECT 
                o.OzellikAdi,
                d.Deger
            FROM 
                UrunOzellik_Table u
            JOIN 
                Ozellik_Degerleri_Table d ON u.OzellikDegerID = d.OzellikDegerID
            JOIN 
                Ozellik_Tanimlari_Table o ON d.OzellikTanimID = o.OzellikTanimID
            WHERE 
                u.UrunID = @UrunID";


            using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                cmd.Parameters.AddWithValue("@UrunID", urunid); // UrunID parametresini ayarlayın.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptPropertyFeatures.DataSource = dt;
                rptPropertyFeatures.DataBind();
            }

        }

    }
}


