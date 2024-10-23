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
    public partial class Urunler : System.Web.UI.Page
    {
        AnaSayfaMaster anasayfamaster = new AnaSayfaMaster();
        Sepetim sepetim = new Sepetim();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                OzellikTanimlariniGetir();

                string kategori = Request.QueryString["kategori"];
                string siralama = Request.QueryString["siralama"];
                string aramaKelimesi = Request.QueryString["search"];
                string indirim = Request.QueryString["indirim"]; // İndirim parametresini al

                UrunleriListele(kategori, siralama, aramaKelimesi, indirim);

                if (!string.IsNullOrEmpty(kategori))
                {
                    kategoriItem.InnerText = kategori;
                    kategoriItem.Attributes.Add("class", "breadcrumb-item active");
                }
                else
                {
                    urunlerItem.InnerHtml = "Ürünler";
                    urunlerItem.Attributes.Add("class", "breadcrumb-item active");
                }

                if (Session["KullaniciID"] != null)
                {
                    LoadFavoriteItems(RepeaterTumUrunler);
                    PanelSepet.Visible = true;
                    Sepetteki_Urunler();
                }
                else
                {
                    PanelSepet.Visible = false;
                }
            }
        }


        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string kategori = Request.QueryString["kategori"];
            string aramaKelimesi = Request.QueryString["search"];
            string indirim = Request.QueryString["indirim"];
            string siralama = ddlSortBy.SelectedValue; // Seçilen sıralama değerini al

            UrunleriListele(kategori, siralama, aramaKelimesi, indirim); // Ürünleri listele
        }

        private void UrunleriListele(string kategori, string siralama, string aramaKelimesi, string indirim)
        {
            // Temel sorgu
            string query = "SELECT * FROM Urun_Table WHERE 1=1";

            // İndirim kontrolü
            if (!string.IsNullOrEmpty(indirim) && indirim == "1")
            {
                query += " AND IndirimDurumu = 1"; // İndirimli ürünleri göster
            }

            // Kategori kontrolü
            if (!string.IsNullOrEmpty(kategori))
            {
                query += " AND UrunKategori = @Kategori";
            }

            // Arama kelimesi kontrolü
            if (!string.IsNullOrEmpty(aramaKelimesi))
            {
                query += " AND (UrunAdi LIKE @AramaKelimesi)";
            }

            // Sıralama kontrolü
            if (!string.IsNullOrEmpty(siralama))
            {
                switch (siralama)
                {
                    case "most-viewed":
                        query += " ORDER BY ZiyaretSayisi DESC";
                        break;
                    case "price-low-high":
                        query += " ORDER BY UrunFiyat ASC";
                        break;
                    case "price-high-low":
                        query += " ORDER BY UrunFiyat DESC";
                        break;
                }
            }

            using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
            {
                // Parametreleri ekle
                if (!string.IsNullOrEmpty(kategori))
                {
                    cmd.Parameters.AddWithValue("@Kategori", kategori);
                }

                if (!string.IsNullOrEmpty(aramaKelimesi))
                {
                    cmd.Parameters.AddWithValue("@AramaKelimesi", "%" + aramaKelimesi + "%");
                }

                SqlConnectionClass.CheckConnection();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Repeater'a ürünleri bağla
                RepeaterTumUrunler.DataSource = dt;
                RepeaterTumUrunler.DataBind();

                // Ürün sayısını hesapla ve bir labelda göster
                int urunSayisi = dt.Rows.Count;
                lblPropertyCount.Text = urunSayisi.ToString();
            }
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
                    AddToFavorites(urunId);
                    //anasayfamaster.UpdateMasterPanel();
                }
                else
                {
                    // Checkbox işaretlenmemişse, veritabanından çıkarma işlemi yapılır.
                    RemoveFromFavorites(urunId);
                    //anasayfamaster.UpdateMasterPanel();
                }
            }
            else
            {

            }
        }
        public void AddToFavorites(int urunId)
        {

            string query = "INSERT INTO Favoriler_Table (UrunID,KullaniciID) VALUES (@UrunID,@Kullaniciid)";
            int kullaniciıd = (int)Session["KullaniciID"];
            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@UrunID", urunId);
                commandList.Parameters.AddWithValue("@Kullaniciid", kullaniciıd);

                commandList.ExecuteNonQuery();
            }

        }

        public void RemoveFromFavorites(int urunId)
        {
            string query = "DELETE FROM Favoriler_Table WHERE UrunID = @UrunID AND KullaniciID=@Kullaniciid";
            int kullaniciıd = (int)Session["KullaniciID"];

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@UrunID", urunId);
                commandList.Parameters.AddWithValue("@Kullaniciid", kullaniciıd);

                commandList.ExecuteNonQuery();
            }
        }
        public void LoadFavoriteItems(Repeater repeater)
        {
            if (Session["KullaniciID"] != null)
            {
                int kullaniciID = (int)Session["KullaniciID"];

                // Kullanıcıya ait favori ürünleri veritabanından al
                SqlCommand commandCheckFavorites = new SqlCommand("SELECT UrunID FROM Favoriler_Table WHERE KullaniciID = @pKullaniciID", SqlConnectionClass.connection);
                commandCheckFavorites.Parameters.AddWithValue("@pKullaniciID", kullaniciID);

                SqlConnectionClass.CheckConnection();
                SqlDataReader reader = commandCheckFavorites.ExecuteReader();
                List<int> favoriteProducts = new List<int>();

                while (reader.Read())
                {
                    favoriteProducts.Add(reader.GetInt32(0));
                }

                reader.Close();

                // Repeater içindeki ürünlerle favori ürünleri karşılaştır ve eşleşenleri seçili yap
                foreach (RepeaterItem item in repeater.Items)
                {
                    CheckBox cb = (CheckBox)item.FindControl("CheckBoxFavorilereEkle");
                    HiddenField hf = (HiddenField)item.FindControl("HiddenFieldUrunID");

                    if (cb != null && hf != null && favoriteProducts.Contains(int.Parse(hf.Value)))
                    {
                        cb.Checked = true;
                    }
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
        
        private void OzellikTanimlariniGetir()
        {
            string query = "SELECT OzellikTanimID, OzellikAdi FROM Ozellik_Tanimlari_Table";
            SqlDataAdapter da = new SqlDataAdapter(query, SqlConnectionClass.connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOzellikTanimlari.DataSource = dt;
            rptOzellikTanimlari.DataBind();
        }

        // Her Repeater Item’i için CheckBoxList’i doldurma
        protected void rptOzellikTanimlari_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                int ozellikTanimID = Convert.ToInt32(row["OzellikTanimID"]);

                CheckBoxList chkOzellikDegerleri = (CheckBoxList)e.Item.FindControl("chkOzellikDegerleri");

                string query = "SELECT OzellikDegerID, Deger FROM Ozellik_Degerleri_Table WHERE OzellikTanimID = @OzellikTanimID";
                using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
                {
                    cmd.Parameters.AddWithValue("@OzellikTanimID", ozellikTanimID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    chkOzellikDegerleri.DataSource = dt;
                    chkOzellikDegerleri.DataTextField = "Deger";
                    chkOzellikDegerleri.DataValueField = "OzellikDegerID";
                    chkOzellikDegerleri.DataBind();
                }
            }
        }


        protected void chk_SelectedIndexChanged(object sender, EventArgs e)
        {
            Filtrele();
        }

        protected void Filtrele()
        {
            // Seçilen değerleri toplamak için bir liste
            var selectedValuesByGroup = new Dictionary<string, List<int>>();

            // Repeater içinde her CheckBoxList'i dolaş ve seçilen değerleri gruplara ayır
            foreach (RepeaterItem item in rptOzellikTanimlari.Items)
            {
                CheckBoxList chkOzellikDegerleri = (CheckBoxList)item.FindControl("chkOzellikDegerleri");
                string groupName = ((Label)item.FindControl("lblOzellikAdi")).Text; // Grup adı almak için label kullandım

                List<int> selectedValues = GetSelectedValues(chkOzellikDegerleri);

                // Eğer grup daha önce eklenmemişse yeni bir liste oluştur
                if (!selectedValuesByGroup.ContainsKey(groupName))
                {
                    selectedValuesByGroup[groupName] = new List<int>();
                }

                // Seçilen değerleri ilgili gruba ekle
                selectedValuesByGroup[groupName].AddRange(selectedValues);
            }

            // Ürünleri filtrelemek için Repeater içindeki her ürünü kontrol et
            foreach (RepeaterItem item in RepeaterTumUrunler.Items)
            {
                HiddenField hfUrunID = (HiddenField)item.FindControl("HiddenFieldUrunID");

                if (hfUrunID != null && !IsUrunVisible(Convert.ToInt32(hfUrunID.Value), selectedValuesByGroup))
                {
                    item.Visible = false;  // Ürün seçilen değerlere uymuyorsa görünmez yap
                }
                else
                {
                    item.Visible = true;  // Ürün seçilen değerlere uygunsa görünür bırak
                }
            }
        }

        private List<int> GetSelectedValues(CheckBoxList chkList)
        {
            List<int> selectedValues = new List<int>();

            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    selectedValues.Add(Convert.ToInt32(item.Value));
                }
            }

            return selectedValues;
        }

        private bool IsUrunVisible(int urunID, Dictionary<string, List<int>> selectedValuesByGroup)
        {
            if (selectedValuesByGroup.Count == 0)
                return true;  // Hiç seçim yapılmamışsa tüm ürünler görünür

            bool isMatch = true;

            // Her grup için ayrı ayrı kontrol et
            foreach (var group in selectedValuesByGroup)
            {
                string groupName = group.Key;
                List<int> values = group.Value;

                // Ürünün özelliklerini kontrol eden sorgu
                if (values.Count > 0)
                {
                    // Her grup için ürünün özelliklerini kontrol et
                    string ids = string.Join(",", values);
                    string query = $@"
            SELECT COUNT(*) 
            FROM UrunOzellik_Table
            WHERE UrunID = @UrunID AND OzellikDegerID IN ({ids})";

                    using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
                    {
                        cmd.Parameters.AddWithValue("@UrunID", urunID);
                        SqlConnectionClass.CheckConnection();
                        int count = (int)cmd.ExecuteScalar();

                        // Eğer bu grupta hiç eşleşme yoksa, o grup için false döneriz
                        if (count == 0)
                        {
                            isMatch = false;
                            break; // Eşleşme yoksa çık
                        }
                    }
                }
            }

            return isMatch; // Her grup için eşleşme varsa true döner
        }






    }




}
