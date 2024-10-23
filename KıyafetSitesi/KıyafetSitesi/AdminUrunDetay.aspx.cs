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
    public partial class AdminUrunDetay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string urunIDStr = Request.QueryString["id"];


                if (int.TryParse(urunIDStr, out int urunID))
                {
                    // Ürün ID'sini kullanarak ürünü veritabanından çekebilirsiniz
                    Urun(urunID);
                    UrunResimleri(urunID);
                    UrunResimleri2(urunID);
                    GetUrunDetaylari(urunID);
                    BindCategories();
                }
                else
                {
                    Response.Redirect("AdminUrunler.aspx");
                    // Hatalı veya eksik ürün ID'si durumu
                }


            }
        }

        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            string urunIDStr = Request.QueryString["id"];
            if (int.TryParse(urunIDStr, out int urunID))
            {
                UrunGuncelleFonksiyon(urunID);
            }
        }


        private void BindCategories()
        {
            string query = "SELECT Kategori FROM Kategori_Table"; // Kategori verilerini almak için sorgu

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();  // Bağlantıyı açıyoruz

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    ddlUrunTuru.DataSource = reader; // DataReader'dan veriyi al
                    ddlUrunTuru.DataValueField = "Kategori"; // Değer alanı
                    ddlUrunTuru.DataTextField = "Kategori"; // Görünen alan
                    ddlUrunTuru.DataBind(); // Verileri bağla
                }
            }
        }
        private void GetUrunDetaylari(int urunId)
        {
            // Veritabanı bağlantısı ve SQL sorgusu
            string query = "SELECT IndirimsizFiyat, UrunAdi, UrunFiyat, UrunResmi, UrunYanResmi1, UrunYanResmi2, IndirimDurumu, Indirimyüzdesi, UrunKategori, UrunStokAdet FROM Urun_Table WHERE UrunID = @UrunID";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);

                connection.Open();  // Bağlantıyı açıyoruz
                cmd.Parameters.AddWithValue("@UrunID", urunId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Ürün bilgilerini TextBox'lara doldur
                    txtUrunAdi.Text = reader["UrunAdi"].ToString();
                    // UrunFiyat'ı okuyun
                    decimal urunFiyati = reader.IsDBNull(reader.GetOrdinal("UrunFiyat")) ? 0 : reader.GetDecimal(reader.GetOrdinal("UrunFiyat"));

                    // IndirimsizFiyat'ı kontrol edin
                    decimal indirimsizFiyat = reader.IsDBNull(reader.GetOrdinal("IndirimsizFiyat")) ? 0 : reader.GetDecimal(reader.GetOrdinal("IndirimsizFiyat"));

                    // Eğer IndirimsizFiyat null veya 0 değilse onu yaz, aksi takdirde UrunFiyat yaz
                    if (indirimsizFiyat > 0)
                    {
                        txtUrunFiyati.Text = indirimsizFiyat.ToString("F2"); // İndirimli fiyatı yaz
                    }
                    else
                    {
                        txtUrunFiyati.Text = urunFiyati.ToString("F2"); // Normal fiyatı yaz
                    }

                    txtUrunResmi.Text = reader["UrunResmi"].ToString();
                    txtYanResim1.Text = reader["UrunYanResmi1"].ToString();
                    txtYanResim2.Text = reader["UrunYanResmi2"].ToString();
                    txtUrunstok.Text = reader["UrunStokAdet"].ToString();

                    // İndirim durumunu kontrol et ve RadioButtonList'te seçimi yap
                    string indirimDurumu = reader["IndirimDurumu"].ToString();

                    if (indirimDurumu == "1")
                    {
                        rblIndirim.SelectedValue = "Evet";
                        pnlIndirimYuzdesi.Visible = true;
                        txtIndirimYuzdesi.Text = reader["Indirimyüzdesi"].ToString();
                    }
                    else if (indirimDurumu == "0")
                    {
                        rblIndirim.SelectedValue = "Hayır";
                        pnlIndirimYuzdesi.Visible = false;
                    }
                    string kategori = reader["UrunKategori"].ToString();

                    ddlUrunTuru.SelectedValue = kategori; // Kategoriyi seçili yap

                }

                reader.Close();
            }
        }

        protected void rblIndirim_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Eğer "Evet" seçilirse, indirim yüzdesi girişini göster
            if (rblIndirim.SelectedValue == "Evet")
            {
                pnlIndirimYuzdesi.Visible = true;
            }
            else
            {
                pnlIndirimYuzdesi.Visible = false;
                txtIndirimYuzdesi.Text = string.Empty; // Yüzde alanını temizle
            }
        }

        private void UrunResimleri(int urunID)
        {
            string query = @"SELECT UrunResmi, UrunYanResmi1, UrunYanResmi2 FROM Urun_Table WHERE UrunID=@purunıd";


            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);

                
                commandList.Parameters.AddWithValue("@purunıd", urunID);
                connection.Open();  // Bağlantıyı açıyoruz

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


            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);


                commandList.Parameters.AddWithValue("@purunıd", urunID);
                connection.Open();  // Bağlantıyı açıyoruz

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterUrunResimler2.DataSource = dr;
                    RepeaterUrunResimler2.DataBind();
                }
            }
        }

        private void Urun(int urunid)
        {
            string query = @"SELECT * FROM Urun_Table WHERE UrunID=@urunid";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);


                commandList.Parameters.AddWithValue("@urunid", urunid);
                connection.Open();  // Bağlantıyı açıyoruz
                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterTumUrunler.DataSource = dr;
                    RepeaterTumUrunler.DataBind();

                }
            }
        }

        private void UrunGuncelleFonksiyon(int urunId)
        {
            string urunAdi = txtUrunAdi.Text;
            decimal urunFiyati = decimal.Parse(txtUrunFiyati.Text);

            string urunResmi = txtUrunResmi.Text;
            string urunYanResmi1 = txtYanResim1.Text;
            string urunYanResmi2 = txtYanResim2.Text;
            string urunGuncellemeTarihi = DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss", new System.Globalization.CultureInfo("tr-TR"));

            int indirimYuzdesi = 0; // Varsayılan olarak 0 indirim
            int indirimDurumu = 0;  // Varsayılan olarak indirim yok (0)
            decimal indirimsizFiyat = urunFiyati; // İndirimli fiyat başlangıçta normal fiyat

            // İndirim radyo butonuna göre kontrol
            if (rblIndirim.SelectedValue == "Evet")
            {
                // İndirim yüzdesi TextBox'a bir değer yazıldıysa al
                if (!string.IsNullOrEmpty(txtIndirimYuzdesi.Text))
                {
                    int.TryParse(txtIndirimYuzdesi.Text, out indirimYuzdesi);

                    // İndirim yüzdesi 0 veya negatif değilse hesapla
                    if (indirimYuzdesi > 0)
                    {
                        // İndirimli fiyat hesaplama (örn: %10 indirim için 90% fiyatı)
                        urunFiyati = urunFiyati - (urunFiyati * indirimYuzdesi / 100);
                        indirimDurumu = 1; // İndirim aktif (1)
                    }
                }

            }
            else
            {
                string query1 = "SELECT IndirimsizFiyat FROM Urun_Table WHERE UrunID = @UrunID"; // 'IndirimsizFiyat' ve 'UrunID' ile sorgu

                using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
                {
                    SqlCommand commandList = new SqlCommand(query1, connection);

                    commandList.Parameters.AddWithValue("@UrunID", urunId); // 'urunID' değişkeninin doğru tanımlandığından emin olun

                    connection.Open();

                    object result = commandList.ExecuteScalar(); // ExecuteScalar, tek bir değeri döndürmek için kullanılır

                    if (result != null && result != DBNull.Value) // Sonucun null ve DBNull.Value olmadığını kontrol et
                    {
                        urunFiyati = decimal.Parse(txtUrunFiyati.Text);
                        // Convert.ToSingle kullanarak float'a çevir
                    }
                    else
                    {

                        urunFiyati = 0; // Örneğin, varsayılan değer
                    }
                }
            }



            // Veritabanı sorgusu - indirim yüzdesini, indirim durumunu ve indirimli fiyatı ekliyoruz
            string query = "UPDATE Urun_Table SET UrunAdi = @UrunAdi, UrunFiyat = @UrunFiyati, UrunResmi = @UrunResmi, UrunYanResmi1 = @UrunYanResmi1, UrunYanResmi2 = @UrunYanResmi2, UrunSonGuncellemeTarihi = @urunGuncellemeTarihi, Indirimyüzdesi = @IndirimYuzdesi, IndirimDurumu = @IndirimDurumu, IndirimsizFiyat = @indirimsizFiyat WHERE UrunID = @UrunID";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);
                connection.Open();
                commandList.Parameters.AddWithValue("@UrunID", urunId);
                commandList.Parameters.AddWithValue("@UrunAdi", urunAdi);
                commandList.Parameters.AddWithValue("@UrunFiyati", urunFiyati);
                commandList.Parameters.AddWithValue("@UrunResmi", urunResmi);
                commandList.Parameters.AddWithValue("@UrunYanResmi1", urunYanResmi1);
                commandList.Parameters.AddWithValue("@UrunYanResmi2", urunYanResmi2);
                commandList.Parameters.AddWithValue("@urunGuncellemeTarihi", urunGuncellemeTarihi);
                commandList.Parameters.AddWithValue("@IndirimYuzdesi", indirimYuzdesi);
                commandList.Parameters.AddWithValue("@IndirimDurumu", indirimDurumu); // İndirim durumu (0 veya 1)
                commandList.Parameters.AddWithValue("@indirimsizFiyat", indirimsizFiyat); // İndirimli fiyatı güncelliyoruz

                commandList.ExecuteNonQuery();
            }
            Urun(urunId);
            UrunResimleri(urunId);
            UrunResimleri2(urunId);
        }




    }
}