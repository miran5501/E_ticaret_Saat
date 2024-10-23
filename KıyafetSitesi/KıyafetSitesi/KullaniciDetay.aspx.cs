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
    public partial class KullaniciDetay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int kullaniciid = 0;

                if (!string.IsNullOrEmpty(Request.QueryString["KullaniciID"]))
                {
                    kullaniciid = int.Parse(Request.QueryString["KullaniciID"]);
                    KullanıcıBilgileri(kullaniciid);
                }
                else
                {
                    Response.Redirect("Kullanicilar.aspx");
                }
            }
        }

        private void KullanıcıBilgileri(int kullaniciid)
        {
            string query = @"
                            SELECT k.*, y.YetkiDurumu
                            FROM Kullanici_Table k
                            LEFT JOIN Yetki_Table y ON k.KullaniciYetkiID = y.YetkiID";

            using (SqlCommand commandSiparis = new SqlCommand(query, SqlConnectionClass.connection))
            {
                commandSiparis.Parameters.AddWithValue("@kullaniciid", kullaniciid);
                SqlConnectionClass.CheckConnection();

                using (SqlDataReader dr = commandSiparis.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblKullaniciAdi.Text = dr["KullaniciAdi"].ToString();
                        lblKullaniciIsim.Text = dr["KullaniciIsim"].ToString();
                        lblKullaniciSoyisim.Text = dr["KullaniciSoyisim"].ToString();
                        lblKullaniciEmail.Text = dr["KullaniciE_mail"].ToString();
                        lblKullaniciTelefon.Text = dr["KullaniciTelefon_No"].ToString();
                        lblKullaniciYetki.Text = dr["YetkiDurumu"].ToString();
                        lblKullaniciPasifDurumu.Text = "Aktif";
                        lblKullaniciOlusturmaTarihi.Text = dr["KullaniciOlusturmaTarihi"].ToString();
                        lblkullaniciid.Text = dr["KullaniciID"].ToString();
                    }
                }
            }
        }
    }
}