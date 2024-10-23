using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace KıyafetSitesi
{
    public partial class AnaSayfaMaster : System.Web.UI.MasterPage
    {
        Sepetim sepetim = new Sepetim();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NavbarKategori();
                NavbarKategoriResponsive();
                if (Session["KullaniciID"] != null)
                {
                    SignInLink.Visible = false;
                    ProfileDropdown.Visible = true;
                    GetFavoriteCount();
                    string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

                    profilimLink.Attributes["class"] = currentPage == "Profilim.aspx" ? "dropdown-item active" : "dropdown-item";
                    sepetimLink.Attributes["class"] = currentPage == "Sepetim.aspx" ? "dropdown-item active" : "dropdown-item";
                    favorilerimLink.Attributes["class"] = currentPage == "Favorilerim.aspx" ? "dropdown-item active" : "dropdown-item";
                    siparislerimLink.Attributes["class"] = currentPage == "Siparislerim.aspx" ? "dropdown-item active" : "dropdown-item";
                }
                else
                {
                    SignInLink.Visible = true;
                    ProfileDropdown.Visible = false;

                }

            }

        }
        private void NavbarKategori()
        {
            string query = "SELECT Kategori FROM Kategori_Table";
            using (SqlCommand command = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                using (SqlDataReader dr = command.ExecuteReader())
                {
                    RepeaterKategori.DataSource = dr;
                    RepeaterKategori.DataBind(); // Repeater kontrolünü verilerle bağlar
                }
            }
        }
        private void NavbarKategoriResponsive()
        {
            string query = "SELECT Kategori FROM Kategori_Table";
            using (SqlCommand command = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                using (SqlDataReader dr = command.ExecuteReader())
                {
                    RepeaterKategoriResponsive.DataSource = dr;
                    RepeaterKategoriResponsive.DataBind(); // Repeater kontrolünü verilerle bağlar
                }
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                // Urunler sayfasına yönlendirme ve arama terimini QueryString ile gönderme
                Response.Redirect("~/Urunler.aspx?search=" + Server.UrlEncode(searchTerm));
            }
        }

        public void UpdateMasterPanel()
        {
            upMasterPanel.Update(); // UpdatePanel'i günceller
        }
        protected void signUpButton_Click(object sender, EventArgs e)
        {
            // Kullanıcıdan alınan veriler
            string isim = txtIsim.Text.Trim();
            string soyisim = txtSoyisim.Text.Trim();
            string kullaniciAdi = txtKullaniciadi.Text.Trim();
            string email = txtEmail.Text.Trim();
            string telefonNumarası = txttelefonnum.Text.Trim();
            string sifre = txtsifre.Text.Trim();
            string KullaniciOlusturulmaTarihi = DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss", new System.Globalization.CultureInfo("tr-TR"));

            // Basit doğrulama (email, telefon, şifre format kontrolü)
            if (string.IsNullOrEmpty(isim) || string.IsNullOrEmpty(soyisim) ||
                string.IsNullOrEmpty(kullaniciAdi) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(telefonNumarası) || string.IsNullOrEmpty(sifre))
            {

                lblErrorsignup.Text = "Lütfen tüm alanları doldurunuz.";
                lblErrorsignup.Visible = true;
                return;
            }

            // Email formatını kontrol et
            if (!IsValidEmail(email))
            {
                lblErrorsignup.Text = "Geçerli bir email adresi giriniz.";
                lblErrorsignup.Visible = true;
                return;
            }

            // Telefon numarasını sadece rakamlardan oluşup oluşmadığını kontrol et
            if (!telefonNumarası.All(char.IsDigit))
            {
                lblErrorsignup.Text = "Geçerli bir telefon numarası giriniz.";
                lblErrorsignup.Visible = true;
                return;
            }

            // Şifre karmaşıklığını kontrol et
            if (sifre.Length < 8 || !sifre.Any(char.IsDigit))
            {
                lblErrorsignup.Text = "Şifre en az 8 karakter ve bir rakam içermelidir.";
                lblErrorsignup.Visible = true;
                return;
            }

            // Şifreyi hash'leme
            string hashedPassword = HashPassword(sifre);

            // SQL sorgusu
            string query = "INSERT INTO Kullanici_Table (KullaniciIsim, KullaniciSoyisim, KullaniciAdi, KullaniciE_mail, KullaniciTelefon_No, KullaniciSifre, KullaniciOlusturmaTarihi, KullaniciYetkiID) " +
                           "VALUES (@Isim, @Soyisim, @KullaniciAdi, @Email, @Telefon, @Sifre, @olusturmatarihi, 2)";

            using (SqlCommand cmd = new SqlCommand(query, SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();
                cmd.Parameters.AddWithValue("@Isim", isim);
                cmd.Parameters.AddWithValue("@Soyisim", soyisim);
                cmd.Parameters.AddWithValue("@KullaniciAdi", kullaniciAdi);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Telefon", telefonNumarası);
                cmd.Parameters.AddWithValue("@Sifre", hashedPassword); // Şifreyi hash'lenmiş olarak kaydediyoruz.
                cmd.Parameters.AddWithValue("@olusturmatarihi", KullaniciOlusturulmaTarihi);

                try
                {
                    cmd.ExecuteNonQuery();
                    lblErrorsignup.Visible = false;
                    lblBasarilisignup.Text = "Kayıt başarıyla tamamlandı.";
                    lblBasarilisignup.Visible = true;
                }
                catch (Exception ex)
                {
                    lblError.Text = "Bir hata oluştu: " + ex.Message;
                    lblError.Visible = true;
                }
            }
        }

        // Email doğrulama fonksiyonu
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        // Şifre hash'leme fonksiyonu
        private string HashPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public int GetFavoriteCount()
        {
            int favoriteCount = 0;
            if (Session["KullaniciID"] != null)
            {

                string query = "SELECT COUNT(*) FROM Favoriler_Table WHERE KullaniciID=@Kullaniciid";
                int kullaniciıd = (int)Session["KullaniciID"];

                using (SqlCommand commandList = new SqlCommand(query, SqlConnectionClass.connection))
                {
                    SqlConnectionClass.CheckConnection();
                    commandList.Parameters.AddWithValue("@Kullaniciid", kullaniciıd);

                    object result = commandList.ExecuteScalar();
                    if (result != null)
                    {
                        favoriteCount = Convert.ToInt32(result);
                    }
                }


            }
            lblFavoriteCount.Text = favoriteCount.ToString();
            return favoriteCount;
        }



        protected void GirisYap_Click(object sender, EventArgs e)
        {
            string _username = username.Text.Trim();
            string _password = password.Text.Trim();

            int Admin = 1;
            int Musteri = 2;

            // Kullanıcı adı boş mu?
            if (string.IsNullOrEmpty(_username))
            {
                lblError.Text = "Lütfen kullanıcı adınızı giriniz.";
                lblError.Visible = true;
                return;
            }

            // Şifre boş mu?
            if (string.IsNullOrEmpty(_password))
            {
                lblError.Text = "Lütfen şifrenizi giriniz.";
                lblError.Visible = true;
                return;
            }

            // Kullanıcı adı ile şifre hash'ini kontrol eden sorgu
            using (SqlCommand commandLogin = new SqlCommand("SELECT * FROM Kullanici_Table WHERE KullaniciAdi=@pkullaniciadi OR KullaniciE_mail=@email", SqlConnectionClass.connection))
            {
                SqlConnectionClass.CheckConnection();

                commandLogin.Parameters.AddWithValue("@pkullaniciadi", _username);
                commandLogin.Parameters.AddWithValue("@email", _username);

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(commandLogin);
                da.Fill(dt);

                // Kullanıcı adı veritabanında mevcut mu?
                if (dt.Rows.Count > 0)
                {
                    // Veritabanından hash'lenmiş şifreyi al
                    string hashedPasswordFromDB = dt.Rows[0]["KullaniciSifre"].ToString();

                    // Kullanıcının girdiği şifreyi hash'le
                    string hashedPasswordInput = HashPassword(_password);

                    // Şifreler uyuşuyor mu?
                    if (hashedPasswordFromDB == hashedPasswordInput)
                    {
                        int kullaniciID = (int)dt.Rows[0]["KullaniciID"];
                        Session["KullaniciYetkiID"] = dt.Rows[0]["KullaniciYetkiID"];
                        int kullaniciYetki = (int)Session["KullaniciYetkiID"];

                        Session["KullaniciID"] = kullaniciID;

                        if (kullaniciYetki == Musteri)
                        {
                            // Müşteri sayfasına yönlendir
                            Response.Redirect(Request.RawUrl);
                        }
                        else if (kullaniciYetki == Admin)
                        {
                            // Admin sayfasına yönlendir
                            Response.Redirect(Request.RawUrl);
                        }
                    }
                    else
                    {
                        // Hatalı şifre
                        lblError.Text = "Hatalı şifre. Lütfen tekrar deneyin.";
                        lblError.Visible = true;
                    }
                }
                else
                {
                    // Kullanıcı adı bulunamadı
                    lblError.Text = "Kullanıcı adı veya E_mail bulunamadı.";
                    lblError.Visible = true;
                }
            }
        }



    }
}