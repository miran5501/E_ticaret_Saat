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
    public partial class UrunEkle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Sayfa ilk yüklendiğinde
            {
                BindCategories();
            }
        }
        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            UrunEkleFonksiyon();
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

        private void UrunEkleFonksiyon()
        {
            string urunAdi = txtUrunAdi.Text;
            decimal urunFiyati = decimal.Parse(txtUrunFiyati.Text);

            string urunResmi = txtUrunResmi.Text;
            
            string urunYanResmi1 = txtYanResim1.Text;
            string urunYanResmi2 = txtYanResim2.Text;
            string Kategori = ddlUrunTuru.SelectedValue;
            //string urunYanResmi3 = txtYanResim3.Text;
            //string urunYanResmi4 = txtYanResim4.Text;
            string urunOlusturmaTarihi = DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss", new System.Globalization.CultureInfo("tr-TR"));

            int indirimYuzdesi = 0; // Varsayılan olarak 0 indirim
            int indirimDurumu = 0;  // Varsayılan olarak indirim yok (0)
            decimal indirimsizFiyat = urunFiyati; // İndirimli fiyat başlangıçta normal fiyat

            int urunStok;
            bool isNumeric = int.TryParse(txtUrunstok.Text, out urunStok);

            if (isNumeric && urunStok >= 0)
            {
                
            }
            else
            {
                //hata mesajı yazdırt
                return;
            }
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

            string query = "INSERT INTO Urun_Table (UrunAdi, UrunFiyat, UrunResmi, UrunYanResmi1, UrunYanResmi2, UrunOlusturmaTarihi, UrunKategori, UrunPasifDurum, IndirimDurumu, Indirimyüzdesi, IndirimsizFiyat, UrunStokAdet) OUTPUT INSERTED.UrunID VALUES (@UrunAdi, @UrunFiyati, @UrunResmi, @UrunYanResmi1, @UrunYanResmi2, @urunolusturmatarihi, @Kategori, 0, @indirimDurumu, @indirimYuzdesi, @indirimsizFiyat, @urunStok)";
            int urunId; // Yeni eklenen ürünün ID'sini tutacak değişken
            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                SqlCommand commandList = new SqlCommand(query, connection);

                connection.Open();  // Bağlantıyı açıyoruz
                commandList.Parameters.AddWithValue("@UrunAdi", urunAdi);
                commandList.Parameters.AddWithValue("@UrunFiyati", urunFiyati);
                commandList.Parameters.AddWithValue("@UrunResmi", urunResmi);
                commandList.Parameters.AddWithValue("@UrunYanResmi1", urunYanResmi1);
                commandList.Parameters.AddWithValue("@UrunYanResmi2", urunYanResmi2);
                commandList.Parameters.AddWithValue("@urunolusturmatarihi", urunOlusturmaTarihi);
                commandList.Parameters.AddWithValue("@Kategori", Kategori);
                commandList.Parameters.AddWithValue("@indirimDurumu", indirimDurumu);
                commandList.Parameters.AddWithValue("@indirimYuzdesi", indirimYuzdesi);   
                commandList.Parameters.AddWithValue("@indirimsizFiyat", indirimsizFiyat);
                commandList.Parameters.AddWithValue("@urunStok", urunStok);
                
                urunId = (int)commandList.ExecuteScalar();
            }
        }

        
    }
}