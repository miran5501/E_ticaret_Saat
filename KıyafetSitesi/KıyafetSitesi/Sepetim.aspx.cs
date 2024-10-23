using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Sepetim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KullaniciID"] != null)
                {
                    Sepetteki_Urunler();
                    SepetTutari();
                    LoadAdresler();
                }
                else
                {
                    Response.Redirect("AnaSayfa.aspx");
                }
            }


        }

        private void Sepetteki_Urunler()
        {
            int sepetid = SepetID();
            string query = @"SELECT Urun_Table.*, Sepet_Icerik_Table.*
             FROM Sepet_Icerik_Table 
             INNER JOIN Urun_Table ON Sepet_Icerik_Table.SepetUrunID = Urun_Table.UrunID 
             WHERE Sepet_Icerik_Table.SepetinID = @psepetid";

            int urunAdedi = 0;
            SqlDataReader dr = null;

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@psepetid", sepetid);

                // SqlDataReader nesnesini al
                dr = commandList.ExecuteReader();

                // SqlDataReader'dan her satırı okuma
                while (dr.Read())
                {
                    urunAdedi++;
                }

                // SqlDataReader kapat
                dr.Close();

                // Repeater'e veri kaynağı olarak ata ve bağla
                dr = commandList.ExecuteReader();
                RepeaterSepettekiUrunler.DataSource = dr;
                RepeaterSepettekiUrunler.DataBind();
            }

            // Ürün adedini etiket üzerinde göster
            lblurunadet.Text = urunAdedi.ToString();

            // Eğer ürün adedi 0 ise, sipariş butonunu devre dışı bırak
            BtnSiparis.Enabled = urunAdedi > 0;

            // SqlDataReader'ı kapat
            if (dr != null)
            {
                dr.Close();
            }
        }

        private Decimal SepetTutari()
        {
            int sepetid = SepetID();
            decimal toplamTutar = 0;
            decimal toplamindirim = 0;

            // Sepet içeriğini almak için query
            string queryIcerik = @"SELECT SepetUrunID, SepetUrunAdet FROM Sepet_Icerik_Table WHERE SepetinID=@psepetid";

            // Sepet içeriğini almak için bir liste oluşturun
            var sepetIcerik = new List<(int urunID, int miktar)>();

            using (SqlCommand commandIcerik = new SqlCommand(queryIcerik, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandIcerik.Parameters.AddWithValue("@psepetid", sepetid);

                using (SqlDataReader drIcerik = commandIcerik.ExecuteReader())
                {
                    while (drIcerik.Read())
                    {
                        int urunID = drIcerik.GetInt32(drIcerik.GetOrdinal("SepetUrunID")); // Ürün ID'si
                        int miktar = drIcerik.GetInt32(drIcerik.GetOrdinal("SepetUrunAdet")); // Ürün adeti

                        sepetIcerik.Add((urunID, miktar)); // Listeye ekleyin
                    }
                }
            }

            // Her ürün için fiyatları kontrol etmek ve toplam tutarı hesaplamak
            foreach (var item in sepetIcerik)
            {
                int urunID = item.urunID;
                int miktar = item.miktar;

                // Ürün fiyatını almak için query
                string queryUrun = @"SELECT IndirimDurumu, IndirimsizFiyat, UrunFiyat FROM Urun_Table WHERE UrunID=@urunid";

                using (SqlCommand commandUrun = new SqlCommand(queryUrun, SqlConnectionClass.connection))
                {
                    commandUrun.Parameters.AddWithValue("@urunid", urunID);

                    using (SqlDataReader drUrun = commandUrun.ExecuteReader())
                    {
                        if (drUrun.Read())
                        {
                            decimal urunFiyati;
                            if (drUrun.GetInt32(drUrun.GetOrdinal("IndirimDurumu")) == 1) // IndirimDurumu = 1 ise
                            {
                                // IndirimsizFiyat'ı kullan
                                urunFiyati = drUrun.GetDecimal(drUrun.GetOrdinal("IndirimsizFiyat"));
                                toplamindirim += (drUrun.GetDecimal(drUrun.GetOrdinal("IndirimsizFiyat")) - drUrun.GetDecimal(drUrun.GetOrdinal("UrunFiyat"))) * miktar;
                            }
                            else
                            {
                                // UrunFiyat'ı kullan
                                urunFiyati = drUrun.GetDecimal(drUrun.GetOrdinal("UrunFiyat"));
                            }

                            // Toplam tutarı hesaplayın
                            toplamTutar += urunFiyati * miktar;
                        }
                    }
                }
            }

            // Toplam tutarı bir Label veya başka bir kontrolle gösterin
            LabelSepetTutari.Text = toplamTutar.ToString("C2"); // C2, para formatında gösterir
            LabelToplamIndirim.Text = toplamindirim.ToString("C2"); // İndirim toplamını gösterin
            return toplamTutar;
        }



        public int SepetID()
        {
            int kullaniciid = (int)Session["KullaniciID"];
            string query = @"SELECT SepetID FROM Sepet_Table WHERE SepetOlusturanID=@pkullaniciid";
            int sepetID = 0;

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                commandList.Parameters.AddWithValue("@pkullaniciid", kullaniciid);

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sepetID = dr.GetInt32(0); // İlk kolon olan SepetID değerini alıyoruz
                    }
                }
            }

            return sepetID; // SepetID değerini döndürüyoruz
        }
        protected void BtnSiparis_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] == null)
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }

            int sepetid = SepetID();
            int kullaniciid = (int)Session["KullaniciID"];
            decimal sepetTutari = SepetTutari(); // Sepet tutarını hesapla

            SqlConnectionClass.CheckConnection();
            SqlTransaction transaction = SqlConnectionClass.connection.BeginTransaction();
            string siparisNotu = txtSiparisNotu.Text;

            try
            {
                // Sipariş oluşturma
                string insertSiparisQuery = "INSERT INTO Siparis_Table (SiparisVerenID, SiparisOlusturmaTarihi, SiparisTutari, SiparisDurumu, SiparisAdresiID, SiparisNotu) OUTPUT INSERTED.SiparisID VALUES (@kullaniciid, @tarih, @siparistutari, @siparisdurumu, @SiparisAdresID, @siparisNotu)";
                int siparisID = 0;

                using (SqlCommand insertSiparisCmd = new SqlCommand(insertSiparisQuery, SqlConnectionClass.connection, transaction))
                {
                    insertSiparisCmd.Parameters.AddWithValue("@kullaniciid", kullaniciid);
                    insertSiparisCmd.Parameters.AddWithValue("@siparistutari", sepetTutari);
                    insertSiparisCmd.Parameters.AddWithValue("@SiparisAdresID", ddlAdres.SelectedValue);
                    insertSiparisCmd.Parameters.AddWithValue("@siparisdurumu", "Bekliyor");
                    insertSiparisCmd.Parameters.AddWithValue("@tarih", DateTime.Now);
                    insertSiparisCmd.Parameters.AddWithValue("@siparisNotu", siparisNotu);
                    siparisID = (int)insertSiparisCmd.ExecuteScalar();
                }

                // Sepetteki ürünleri sipariş ürünleri tablosuna ekleme ve stok güncelleme
                string insertSiparisUrunQuery = @"
                INSERT INTO Siparis_Icerik_Table (SiparisinID, SiparisUrunID, SiparisUrunAdet, SiparisUrunFiyatBirim, SiparisUrunFiyatToplam)
                SELECT @siparisID, si.SepetUrunID, si.SepetUrunAdet, u.UrunFiyat AS SiparisUrunFiyatBirim, 
                       si.SepetUrunAdet * u.UrunFiyat AS SiparisUrunFiyatToplam
                FROM Sepet_Icerik_Table si
                INNER JOIN Urun_Table u ON si.SepetUrunID = u.UrunID
                WHERE si.SepetinID = @sepetid";

                using (SqlCommand insertSiparisUrunCmd = new SqlCommand(insertSiparisUrunQuery, SqlConnectionClass.connection, transaction))
                {
                    insertSiparisUrunCmd.Parameters.AddWithValue("@siparisID", siparisID);
                    insertSiparisUrunCmd.Parameters.AddWithValue("@sepetid", sepetid);
                    insertSiparisUrunCmd.ExecuteNonQuery();
                }

                // Stok güncelleme
                string updateStokQuery = @"
                UPDATE Urun_Table 
                SET UrunStokAdet = UrunStokAdet - (
                    SELECT SUM(SepetUrunAdet) 
                    FROM Sepet_Icerik_Table 
                    WHERE SepetUrunID = UrunID AND SepetinID = @sepetid
                )
                WHERE UrunID IN (
                    SELECT DISTINCT SepetUrunID 
                    FROM Sepet_Icerik_Table 
                    WHERE SepetinID = @sepetid
                )";

                using (SqlCommand updateStokCmd = new SqlCommand(updateStokQuery, SqlConnectionClass.connection, transaction))
                {
                    updateStokCmd.Parameters.AddWithValue("@sepetid", sepetid);
                    updateStokCmd.ExecuteNonQuery();
                }

                // Sepeti temizleme
                string deleteSepetIcerikQuery = "DELETE FROM Sepet_Icerik_Table WHERE SepetinID = @sepetid";

                using (SqlCommand deleteSepetCmd = new SqlCommand(deleteSepetIcerikQuery, SqlConnectionClass.connection, transaction))
                {
                    deleteSepetCmd.Parameters.AddWithValue("@sepetid", sepetid);
                    deleteSepetCmd.ExecuteNonQuery();
                }

                // Transaction commit
                transaction.Commit();

                // Sepetteki ürünleri yeniden yükleyin (boş sepet)
                Sepetteki_Urunler();
                lblErrorStok.Visible = false;
            }
            catch (Exception ex)
            {
                transaction.Rollback(); // Hata oluşursa transaction geri al
                lblErrorStok.Text = "Sepetinizi oluştururken bir hata oluştu.";
                lblErrorStok.Visible = true;
            }
            SepetTutari();
            Sepetteki_Urunler();
            UpdatePanelsepet.Update();
        }

        protected void BtnAdetAzalt_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] == null)
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }

            Button btn = (Button)sender;
            int icerikID = Convert.ToInt32(btn.CommandArgument);
            int sepetid = SepetID();

            // Sepet içeriğinde ürün adedini azaltma işlemi
            SqlCommand commandUpdate = new SqlCommand("UPDATE Sepet_Icerik_Table SET SepetUrunAdet = SepetUrunAdet - 1 WHERE IcerikID = @icerikid AND SepetinID=@sepetid", SqlConnectionClass.connection);
            commandUpdate.Parameters.AddWithValue("@icerikid", icerikID);
            commandUpdate.Parameters.AddWithValue("@sepetid", sepetid);
            SqlConnectionClass.CheckConnection();

            int affectedRows = commandUpdate.ExecuteNonQuery();

            if (affectedRows > 0)
            {
                Sepetteki_Urunler();
                UpdatePanelsepet.Update();
                SepetTutari();
                lblErrorStok.Visible = false;
            }
            else
            {
                // Güncelleme işlemi başarısız olduğunda yapılacak işlemler
            }
        }

        protected void BtnAdetArttir_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] == null)
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }

            Button btn = (Button)sender;

            // HiddenField kontrolünü bul
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hiddenField = (HiddenField)item.FindControl("hiddenUrunID");
            int urunID = Convert.ToInt32(hiddenField.Value);
            int icerikID = Convert.ToInt32(btn.CommandArgument);
            int sepetid = SepetID();

            // Stok miktarını almak için sorgu
            SqlCommand commandStockCheck = new SqlCommand("SELECT UrunStokAdet FROM Urun_Table WHERE UrunID = @urunID", SqlConnectionClass.connection);
            commandStockCheck.Parameters.AddWithValue("@urunID", urunID);

            // Stok miktarını alıyoruz
            SqlConnectionClass.CheckConnection();
            object result = commandStockCheck.ExecuteScalar();
            int stokAdeti = (result != null && result != DBNull.Value) ? Convert.ToInt32(result) : 0;

            // Sepetteki ürün miktarını almak için sorgu
            SqlCommand commandCurrentQuantity = new SqlCommand("SELECT SepetUrunAdet FROM Sepet_Icerik_Table WHERE IcerikID = @icerikid AND SepetinID=@sepetid", SqlConnectionClass.connection);
            commandCurrentQuantity.Parameters.AddWithValue("@icerikid", icerikID);
            commandCurrentQuantity.Parameters.AddWithValue("@sepetid", sepetid);

            // Mevcut miktarı alıyoruz
            object currentQuantityResult = commandCurrentQuantity.ExecuteScalar();
            int mevcutMiktar = (currentQuantityResult != null && currentQuantityResult != DBNull.Value) ? Convert.ToInt32(currentQuantityResult) : 0;

            // Eğer mevcut miktar ile stok adeti eşit veya daha fazla değilse arttırma işlemi yap
            if (mevcutMiktar < stokAdeti)
            {
                // Sadece ürün adedini arttırıyoruz
                SqlCommand commandUpdate = new SqlCommand("UPDATE Sepet_Icerik_Table SET SepetUrunAdet = SepetUrunAdet + 1 WHERE IcerikID = @icerikid AND SepetinID=@sepetid", SqlConnectionClass.connection);
                commandUpdate.Parameters.AddWithValue("@icerikid", icerikID);
                commandUpdate.Parameters.AddWithValue("@sepetid", sepetid);

                int affectedRows = commandUpdate.ExecuteNonQuery();

                if (affectedRows > 0)
                {
                    Sepetteki_Urunler();
                    UpdatePanelsepet.Update();
                    SepetTutari();
                    lblErrorStok.Visible = false;
                }
            }
            else
            {
                lblErrorStok.Text = "Stok yetersiz.";
                lblErrorStok.Visible = true;
            }
        }





        protected void BtnUrunSil_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            LinkButton btn = (LinkButton)sender;
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
                SepetTutari();
                UpdatePanelsepet.Update();
                lblErrorStok.Visible = false;
            }
            else
            {

            }
        }
        protected void RepeaterSepetIcerik_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Ürün Adeti
                int adet = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "SepetUrunAdet"));

                // Butonları al
                Button btnAdetAzalt = (Button)e.Item.FindControl("btnAdetAzalt");
                LinkButton btnSil = (LinkButton)e.Item.FindControl("btnSil");

                if (adet <= 1)
                {
                    // Azalt butonunu gizle ve sil butonunu göster
                    btnAdetAzalt.Visible = false;
                    btnSil.Visible = true;


                }
                else
                {
                    btnAdetAzalt.Visible = true;
                    btnSil.Visible = false;
                }
            }
        }

        private void LoadAdresler()
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
            using (SqlCommand cmd = new SqlCommand("SELECT ID, AdresBaslik FROM Adres_Table WHERE AdresSahibiID=@AdresSahibiID", SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                cmd.Parameters.AddWithValue("@AdresSahibiID", kullaniciID);
                // Verileri oku
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // DataReader ile veri bağlama
                    ddlAdres.DataSource = reader;
                    ddlAdres.DataTextField = "AdresBaslik";
                    ddlAdres.DataValueField = "ID";
                    ddlAdres.DataBind();
                }
            }
        }
    }
}