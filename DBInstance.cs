using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeeShopManager
{
    class DBInstance
    {
        public static SqlConnection generate()
        {
            string connectSTR = @"Data Source=PHATNFQ-PC;Initial Catalog=B1805708_NTPhat;Integrated Security=True";

            SqlConnection connection = new SqlConnection(connectSTR);

            connection.Open();

            return connection;
        }
    }
}
