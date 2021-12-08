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
    public partial class fLogin : Form
    {
        private SqlConnection connection;

        public fLogin()
        {
            InitializeComponent();
            this.txtPassWord.Text = "12345678";
            this.txtUserName.Text = "phat";

            connection = DBInstance.generate();
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
            char[] arr = pass.ToCharArray();
            return new string(arr);
        }

        public Account getAccountByUserName(string username)
        {
            string query = "select * from Account where UserName = N'" + username + "'";
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

        bool Login(string username, string password)
        {
            string query = "SELECT * FROM Account WHERE UserName = N'" + username + "'AND  Password=N'" + password + "'";
            SqlCommand command = new SqlCommand(query, connection);

            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);

            adapter.Fill(data);

            return data.Rows.Count > 0;
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Login_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("Bạn có thật sự muốn thoát không?", "Thông báo!", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;
            string password = EncodingPassword(txtPassWord.Text);
            // txtUserName.Text = password;
            if (Login(username, password))
            {
                Account loginAccount = getAccountByUserName(username);
                fTableManager f = new fTableManager(loginAccount);
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
            else
            {
                MessageBox.Show("Đăng nhập không thành công \nBạn vui lòng kiểm tra Tên đăng nhập/Mật khẩu.", "Thông báo lỗi!", MessageBoxButtons.OK);
            }   
        }            
    }
}
