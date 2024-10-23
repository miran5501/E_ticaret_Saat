using KıyafetSitesi.Classlar;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;

namespace KıyafetSitesi
{
    public partial class GenelBilgiler : System.Web.UI.Page
    {
        protected int dailyVisitCount = 0; // Günlük ziyaretçi sayısını tutacak değişken
        protected int dailyOrderCount = 0; // Günlük sipariş sayısını tutacak değişken
        protected int dailyYeniKullanici = 0; // Günlük sipariş sayısını tutacak değişken
        protected float dailyOrderTotal = 0;
        protected int wholePart = 0;
        protected int decimalPart = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dailyVisitCount = GetDailyVisitCount(); // Ziyaretçi sayısını al
                dailyOrderCount = GetDailyOrderCount(); // Sipariş sayısını al
                dailyOrderTotal = GetDailyOrderTotal();
                dailyYeniKullanici=GetDailyUserCount();
                LoadOrderStatistics();

                // Tam kısım (virgülden önce)
                wholePart = (int)Math.Floor(dailyOrderTotal);

                // Ondalık kısım (virgülden sonra)
                decimalPart = (int)((dailyOrderTotal - wholePart) * 100); // Ondalık kısmı yüzde cinsine çevir
            }
        }

        private int GetDailyVisitCount()
        {
            int count = 0;
            string query = "SELECT ZiyaretSayisi FROM GunlukZiyaretler WHERE ZiyaretTarihi = CAST(GETDATE() AS DATE);";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar(); // Sorgunun sonucunu al
                    if (result != null)
                    {
                        count = Convert.ToInt32(result); // Ziyaretçi sayısını sayıya dönüştür
                    }
                }
            }

            return count; // Günlük ziyaretçi sayısını döndür
        }

        private int GetDailyOrderCount()
        {
            int count = 0;
            string query = "SELECT COUNT(*) FROM Siparis_Table WHERE SiparisOlusturmaTarihi = CAST(GETDATE() AS DATE);";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        count = Convert.ToInt32(result);
                    }
                }
            }

            return count;
        }
        private int GetDailyUserCount()
        {
            int count = 0;
            // Kullanıcı oluşturulma tarihine göre günlük kullanıcı sayısını alır
            string query = "SELECT COUNT(*) FROM Kullanici_Table WHERE TRY_CONVERT(DATE, KullaniciOlusturmaTarihi, 104) = CAST(GETDATE() AS DATE);";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        count = Convert.ToInt32(result);
                    }
                }
            }

            return count;
        }



        private float GetDailyOrderTotal()
        {
            float total = 0;
            string query = "SELECT SUM(SiparisTutari) FROM Siparis_Table WHERE CAST(SiparisOlusturmaTarihi AS DATE) = CAST(GETDATE() AS DATE);";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    object result = command.ExecuteScalar();
                    if (result != DBNull.Value && result != null)
                    {
                        total = Convert.ToSingle(result);
                    }
                }
            }

            return total;
        }

        protected List<int> DailyOrders { get; set; }
        protected List<int> WeeklyOrders { get; set; }
        protected List<int> MonthlyOrders { get; set; }

        private void LoadOrderStatistics()
        {
            DailyOrders = GetDailyOrders();
            WeeklyOrders = GetWeeklyOrders();
            MonthlyOrders = GetMonthlyOrders();
        }

        private List<int> GetDailyOrders()
        {
            var orders = new List<int>(new int[7]); // Son 7 gün için

            string query = @"
                SELECT 
                    CAST(SiparisOlusturmaTarihi AS DATE) AS SiparisTarihi, 
                    COUNT(*) AS SiparisSayisi 
                FROM 
                    Siparis_Table 
                WHERE 
                    SiparisOlusturmaTarihi >= DATEADD(DAY, -7, GETDATE()) 
                GROUP BY 
                    CAST(SiparisOlusturmaTarihi AS DATE) 
                ORDER BY 
                    SiparisTarihi";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int index = (DateTime.Now.Date - (DateTime)reader["SiparisTarihi"]).Days;
                            if (index >= 0 && index < 7)
                            {
                                orders[index] = (int)reader["SiparisSayisi"];
                            }
                        }
                    }
                }
            }

            return orders;
        }

        private List<int> GetWeeklyOrders()
        {
            var orders = new List<int>(new int[7]); // Son 7 hafta için

            string query = @"
                SELECT 
                    DATEPART(YEAR, SiparisOlusturmaTarihi) AS SiparisYili,
                    DATEPART(WEEK, SiparisOlusturmaTarihi) AS SiparisHaftasi, 
                    COUNT(*) AS SiparisSayisi 
                FROM 
                    Siparis_Table 
                WHERE 
                    SiparisOlusturmaTarihi >= DATEADD(WEEK, -7, GETDATE()) 
                GROUP BY 
                    DATEPART(YEAR, SiparisOlusturmaTarihi), DATEPART(WEEK, SiparisOlusturmaTarihi) 
                ORDER BY 
                    SiparisYili, SiparisHaftasi";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int weekIndex = (int)reader["SiparisHaftasi"] % 7; // Haftaları sıralamak için mod alıyoruz
                            orders[weekIndex] = (int)reader["SiparisSayisi"];
                        }
                    }
                }
            }

            return orders;
        }

        private List<int> GetMonthlyOrders()
        {
            var orders = new List<int>(new int[12]); // Son 12 ay için

            string query = @"
                SELECT 
                    DATEPART(YEAR, SiparisOlusturmaTarihi) AS SiparisYili,
                    DATEPART(MONTH, SiparisOlusturmaTarihi) AS SiparisAyi, 
                    COUNT(*) AS SiparisSayisi 
                FROM 
                    Siparis_Table 
                WHERE 
                    SiparisOlusturmaTarihi >= DATEADD(MONTH, -12, GETDATE()) 
                GROUP BY 
                    DATEPART(YEAR, SiparisOlusturmaTarihi), DATEPART(MONTH, SiparisOlusturmaTarihi) 
                ORDER BY 
                    SiparisYili, SiparisAyi";

            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int monthIndex = (int)reader["SiparisAyi"] - 1; // Ayları 0 tabanlı hale getiriyoruz
                            orders[monthIndex] = (int)reader["SiparisSayisi"];
                        }
                    }
                }
            }

            return orders;
        }
    }
}
