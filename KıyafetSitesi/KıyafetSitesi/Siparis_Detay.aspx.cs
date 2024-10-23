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
    public partial class Siparis_Detay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int siparisID = 0;

                if (!string.IsNullOrEmpty(Request.QueryString["SiparisID"]))
                {
                    siparisID = int.Parse(Request.QueryString["SiparisID"]);
                    SiparistekiUrunler(siparisID);
                    SiparisBilgileri(siparisID);
                }
                else
                {
                    Response.Redirect("Siparisler.aspx");
                }
                
            }
        }

        private void SiparistekiUrunler(int siparisid)
        {
            string query = @"
                SELECT su.*, u.*
                FROM Siparis_Icerik_Table su
                INNER JOIN Urun_Table u ON su.SiparisUrunID = u.UrunID
                WHERE su.SiparisinID = @SiparisID";

            using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
            {
                commandList.Parameters.AddWithValue("@SiparisID", siparisid);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandList.ExecuteReader())
                {
                    RepeaterSiparisUrunleri.DataSource = dr;
                    RepeaterSiparisUrunleri.DataBind();
                }
            }
        }

        private void SiparisBilgileri(int siparisid)
        {
            int siparisVerenID = 0;

            // 1. Adım: SiparisID'ye göre SiparisVerenID'yi alıyoruz
            string querySiparis = @"
                                    SELECT s.*, a.*
                                    FROM Siparis_Table s
                                    JOIN Adres_Table a ON s.SiparisAdresiID = a.ID
                                    WHERE s.SiparisID = @SiparisID";

            using (SqlCommand commandSiparis = new SqlCommand(querySiparis, SqlConnectionClass.connection))
            {
                commandSiparis.Parameters.AddWithValue("@SiparisID", siparisid);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandSiparis.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        siparisVerenID = Convert.ToInt32(dr["SiparisVerenID"]);
                        lblSiparisTarihi.Text = dr["SiparisOlusturmaTarihi"].ToString();
                        lblSiparisDurumu.Text= dr["SiparisDurumu"].ToString();
                        lblSiparisAdresi.Text= dr["Adres"].ToString();
                        lblFaturaAdresi.Text= dr["Adres"].ToString();
                        lblToplamTutar.Text = string.Format("₺{0:F2}", Convert.ToSingle(dr["SiparisTutari"]));
                    }
                }
            }

            // 2. Adım: SiparisVerenID'ye göre Kullanici_Table'dan kullanıcı bilgilerini alıyoruz
            if (siparisVerenID > 0)
            {
                string queryKullanici = "SELECT KullaniciSoyisim, KullaniciIsim, KullaniciE_mail, KullaniciTelefon_No FROM Kullanici_Table WHERE KullaniciID = @KullaniciID";

                using (SqlCommand commandKullanici = new SqlCommand(queryKullanici, SqlConnectionClass.connection))
                {
                    commandKullanici.Parameters.AddWithValue("@KullaniciID", siparisVerenID);
                    SqlConnectionClass.CheckConnection();

                    using (SqlDataReader dr = commandKullanici.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string kullaniciAdi = dr["KullaniciIsim"].ToString() + " " +dr["KullaniciSoyisim"].ToString();
                            string email = dr["KullaniciE_mail"].ToString();
                            string telefon = dr["KullaniciTelefon_No"].ToString();

                            // Bu bilgileri kullanarak sayfanızdaki label'ları güncelliyoruz
                            lblSiparisVerenAdi.Text = kullaniciAdi;
                            lblSiparisVerenEmail.Text = email;
                            lblSiparisVerenTelefon.Text = telefon;
                        }
                    }
                }
            }
        }

    }
}