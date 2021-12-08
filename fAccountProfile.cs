using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CoffeeShopManager
{
    public partial class fAccountProfile : Form
    {
        private Account loginAccount;

        SqlConnection connection;

        public Account LoginAccount
        {
            get { return loginAccount; }
            set
            {
                loginAccount = value;
            }
        }

        public fAccountProfile(Account acc)
        {
            InitializeComponent();
            connection = DBInstance.generate();
            LoginAccount = acc;
            LoadAccount();
        }
       
        Account getAccount(string username)
        {
            string query = "SELECT * FROM Account WHERE UserName = N'" + username + "'";
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }
            return null;
        }

        public bool UpdateAccount(string username, string displayName, string password, string newpass)
        {
            string query = "";

            if (newpass.Equals(""))
            {
                query += "UPDATE Account SET DisplayName = N'" + displayName + "' WHERE UserName = N'" + username + "'";
            }

            else
            {
                newpass = EncodingPassword(newpass);
                query = "UPDATE Account SET DisplayName = N'" + displayName + "', PassWord = N'" + newpass + "' WHERE UserName = N'" + username + "' AND PassWord = N'" + password + "'";
            }


            SqlCommand command = new SqlCommand(query, connection);
            int result = 0;

            result = (int)command.ExecuteNonQuery();

            return result > 0;
        }

        void LoadAccount()
        {
            txtUserName.Text = LoginAccount.UserName;
            txtDisplayName.Text = LoginAccount.DisplayName;
        }

        public string EncodingPassword(string pass_input)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(pass_input);
            byte[] hasData = new MD5CryptoServiceProvider().ComputeHash(temp);
            String pass = "";
            foreach (byte item in hasData)
            {
                pass += item;
            }
            char[] arr = pass.ToCharArray(); // chuỗi thành mảng ký tự
            return new string(arr);
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdateAccount_Click(object sender, EventArgs e)
        {
            string display_name = txtDisplayName.Text;
            string current_password = EncodingPassword(txtPassword.Text);
            string new_password = txtNewPass.Text;
            string reTypingPassword = txtRetypeNewPass.Text;
            string username = txtUserName.Text;

            if (!reTypingPassword.Equals(new_password))
            {
                new_password = reTypingPassword = null;
                MessageBox.Show("Nhập lại mật khẩu không chính xác", "Thông báo!");
                return;
            }

            if (UpdateAccount(username, display_name, current_password, new_password))
            {
                MessageBox.Show("Cập nhật thành công!", "Thông báo!");
            }
            else
            {
                MessageBox.Show("Sai mật khẩu hiện tại!", "Thông báo!");
            }
        }

    }
}
