﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace KıyafetSitesi.Classlar
{
    public class SqlConnectionClass
    {
        public static SqlConnection connection = new SqlConnection("your connection string");
        public static string connectionString = "your connection string";

        public static void CheckConnection()
        {
            if (connection.State == System.Data.ConnectionState.Closed)
            {
                connection.Open();
            }
            else
            {

            }
        }

    }
}