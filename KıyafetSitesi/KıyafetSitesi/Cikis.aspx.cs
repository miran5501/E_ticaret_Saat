﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KıyafetSitesi
{
    public partial class Cikis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Oturum bilgilerini temizle
            Session.Clear();
            Session.Abandon();

            // Giriş sayfasına yönlendir
            Response.Redirect("~/AnaSayfa.aspx");
        }
    }
}