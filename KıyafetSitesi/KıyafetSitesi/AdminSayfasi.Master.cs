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
    public partial class AdminSayfasi : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblurunsayisi.Text = toplamurunsayisi().ToString();

            }
        }
        
        private int toplamurunsayisi()
        {
            int toplamsayi;
            string query = "SELECT COUNT(*) FROM Urun_Table";
            using (SqlConnection connection = new SqlConnection(SqlConnectionClass.connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    return toplamsayi = (int)command.ExecuteScalar();
                }
            }
        }
    }
}