using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Adres_Ekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] == null)
            {
                Response.Redirect("AnaSayfa.aspx");

            }
            if (!IsPostBack)
            {
                LoadSehirler();
            }
        }

        private void LoadSehirler()
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            using (SqlCommand cmd = new SqlCommand("SELECT TOP 81 ID, SehirIlceMahalleAdi FROM YeniAdresTablosu", SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                // Verileri oku
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // DataReader ile veri bağlama
                    ddlSehir.DataSource = reader;
                    ddlSehir.DataTextField = "SehirIlceMahalleAdi";
                    ddlSehir.DataValueField = "ID";
                    ddlSehir.DataBind();
                }
            }
        }


        protected void ddlSehir_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            ddlIlce.Items.Clear();
            ddlMahalle.Items.Clear();
            int sehirID = Convert.ToInt32(ddlSehir.SelectedValue);
            LoadIlceler(sehirID);
            ddlMahalle.Items.Clear(); // İlçe değiştiğinde mahalle dropdown'ı temizlenir
        }

        private void LoadIlceler(int sehirID)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }

            using (SqlCommand cmd = new SqlCommand("SELECT ID, SehirIlceMahalleAdi, UstID FROM YeniAdresTablosu WHERE UstID=@SehirID", SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                // Parametre ekle
                cmd.Parameters.AddWithValue("@SehirID", sehirID);

                // Verileri oku
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // DataReader ile veri bağlama
                    ddlIlce.DataSource = reader;
                    ddlIlce.DataTextField = "SehirIlceMahalleAdi"; // "Adi" yerine "SehirIlceMahalleAdi"
                    ddlIlce.DataValueField = "ID";
                    ddlIlce.DataBind();
                }
            }
        }


        protected void ddlIlce_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            ddlMahalle.Items.Clear();
            int ilceID = Convert.ToInt32(ddlIlce.SelectedValue);
            LoadMahalleler(ilceID);
        }

        private void LoadMahalleler(int ilceID)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            using (SqlCommand cmd = new SqlCommand("SELECT ID, SehirIlceMahalleAdi, UstID FROM YeniAdresTablosu WHERE UstID = @IlceID", SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                // Parametre ekle
                cmd.Parameters.AddWithValue("@IlceID", ilceID);

                // Verileri oku
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // DataReader ile veri bağlama
                    ddlMahalle.DataSource = reader;
                    ddlMahalle.DataTextField = "SehirIlceMahalleAdi"; // "Adi" yerine "SehirIlceMahalleAdi"
                    ddlMahalle.DataValueField = "ID";
                    ddlMahalle.DataBind();
                }
            }
        }

        protected void BtnKaydet_Click(object sender, EventArgs e)
        {
            if (Session["KullaniciID"] != null)
            {

            }
            else
            {
                // Kullanıcı giriş yapmamışsa bir yönlendirme veya uyarı gösterebilirsiniz.
                Response.Redirect("AnaSayfa.aspx");
            }
            int kullaniciid = (int)Session["KullaniciID"];
            // Formdan veri al
            string ad = txtAd.Text;
            string soyad = txtSoyad.Text;
            string telefonNo = TextTelefonNo.Text;
            string sehirAdi = ddlSehir.SelectedItem.Text;
            string ilceAdi = ddlIlce.SelectedItem.Text;
            string mahalleAdi = ddlMahalle.SelectedItem.Text;
            string adres = txtAdres.Text;
            string adresBasligi = txtAdresBasligi.Text;



            string query = "INSERT INTO Adres_Table (Adi, Soyadi, Telefon_no, Sehir, Ilce, Mahalle, Adres, AdresBaslik, AdresSahibiID) VALUES (@Ad, @Soyad, @TelefonNo, @SehirAdi, @IlceAdi, @MahalleAdi, @Adres, @AdresBasligi, @AdresSahibiID)";

            using (SqlCommand command = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                command.Parameters.AddWithValue("@Ad", ad);
                command.Parameters.AddWithValue("@Soyad", soyad);
                command.Parameters.AddWithValue("@TelefonNo", telefonNo);
                command.Parameters.AddWithValue("@SehirAdi", sehirAdi);
                command.Parameters.AddWithValue("@IlceAdi", ilceAdi);
                command.Parameters.AddWithValue("@MahalleAdi", mahalleAdi);
                command.Parameters.AddWithValue("@Adres", adres);
                command.Parameters.AddWithValue("@AdresBasligi", adresBasligi);
                command.Parameters.AddWithValue("@AdresSahibiID", kullaniciid);
                command.ExecuteNonQuery();
            }


            // Kullanıcıya başarılı olduğunu bildirin
            // Örneğin: Response.Write("Adres başarıyla kaydedildi.");
        }

    }
}