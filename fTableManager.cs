using QuanLyQuanCafe.Bill;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static CoffeeShopManager.fAdmin;

namespace CoffeeShopManager
{
    public partial class fTableManager : Form
    {
        SqlConnection connection;

        public object ListViewSubItems { get; private set; }

        private Account loginAccount;
        public Account LoginAccount
        {
            get { return loginAccount; }
            set {
                loginAccount = value;
                changeAccount(loginAccount.Type);
            }
        }

        public fTableManager(Account inputAccount)
        {
            InitializeComponent();
            connection = DBInstance.generate();
            this.LoginAccount = inputAccount;
            LoadListTable();
            loadListCategoryFoodNameOnComboBox();
        }

        void changeAccount(int type)
        {
        }

        void LoadListTable()
        {
            flpTable.Controls.Clear();

            string query = "SELECT * FROM TableFood";
            SqlCommand command = new SqlCommand(query, connection);
            SqlDataAdapter adapter = new SqlDataAdapter(command);

            DataTable data = new DataTable();
            adapter.Fill(data);

            List<Table> listTable = new List<Table>();
            if(data == null)
            {
                return;
            }
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                listTable.Add(table);
            }
            foreach (Table item in listTable)
            {
                Button btn = new Button();
                btn.Width = 112;
                btn.Height = 112;
                btn.Click += Btn_Click;
                btn.Tag = item;
                switch (item.Status)
                {
                    case "Trống":
                        btn.BackColor = Color.White;
                        break;
                    default:
                        btn.BackColor = Color.Gray;
                        break;
                }
                btn.Text = item.Name + Environment.NewLine + item.Status;
                flpTable.Controls.Add(btn);
            }
            cbChangeTable.DataSource = listTable;
            cbChangeTable.DisplayMember = "Name";
        }

        void loadListCategoryFoodNameOnComboBox()
        {
            string query = "SELECT * FROM CategoryFood";
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
            List<Category> listCategory = new List<Category>();
            foreach (DataRow item in data.Rows)
            {
                Category category = new Category(item);
                listCategory.Add(category);
            }

            cbCategoryFood.DataSource = listCategory;
            cbCategoryFood.DisplayMember = "Name";
        }

        void loadListFoodByCategoryId(int id)
        {
            string query = "SELECT * FROM Food WHERE idCategory = " + id;
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
            List<Food> listFood = new List<Food>();
            if(data.Rows.Count > 0)
            {
                foreach (DataRow item in data.Rows)
                {
                    Food food = new Food(item);
                    listFood.Add(food);
                }
                cbFood.DataSource = listFood;
                cbFood.DisplayMember = "Name";
            }
            else cbFood.DataSource = null;
        }

        int getIdBillUnCheckOutByIdTable(int idTable)
        {
            string query = "SELECT * FROM Bill WHERE status = 0 AND idTable = " + idTable;
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.Id;
            }
            return -1;
        }
        
        public bool InsertBill(int idTable)
        {
            string query = "INSERT Bill (idTable) VALUES (" + idTable +")";
            SqlCommand command = new SqlCommand(query, connection);
            int result = (int)command.ExecuteNonQuery();

            return result > 0;
        }

        public bool InsertBillInfo(int idBill, int idFood, int count)
        {
            string query = "EXEC USP_InsertBillInfo " + idBill + "," + idFood + "," + count;
            SqlCommand command = new SqlCommand(query, connection);
            int result = (int)command.ExecuteNonQuery();

            return result > 0;
        }

        public void ShowBill(int idTable)
        {
            lsvBill.Items.Clear();
            string query = "EXEC USP_GetBillInfoByIdTable " + idTable;
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
            if(data == null)
            {
                return;
            }
            List<Menu> listMenu = new List<Menu>();
            foreach (DataRow item in data.Rows)
            {
                Menu menu_item = new Menu(item);
                listMenu.Add(menu_item);
            }
            float totalPrice = 0;
            foreach (Menu item in listMenu)
            {
                totalPrice += item.Price * item.Count;
                ListViewItem lsvitem = new ListViewItem(item.FoodName.ToString());
                lsvitem.SubItems.Add(item.Count.ToString());
                lsvitem.SubItems.Add(item.Price.ToString());
                lsvitem.SubItems.Add(item.TotalPrice.ToString());
                lsvBill.Items.Add(lsvitem);
            }
            CultureInfo culture = new CultureInfo("vi-VN");
            int discount = (int)nmDiscount.Value;
            txtTotalPrice.Text = (totalPrice - totalPrice * discount / 100).ToString("c", culture);
        }

        public void CheckOutBill(int idTable, float discount, float finalTotalPrice)
        {
            string query = "EXEC USP_CheckOutBillForTable " + idTable + ", " + discount + ", " + finalTotalPrice;
            SqlCommand command = new SqlCommand(query, connection);
            DataTable data = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(data);
        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAdmin f = new fAdmin();
            f.InsertCategoryFooodEvent += f_InsertCategoryFooodEvent;
            f.UpdateCategoryFoodEvent += f_UpdateCategoryFoodEvent;
            f.DeleteCategoryFoodEvent += f_DeleteCategoryFoodEvent;
            f.InsertTableFoodEvent += f_InsertTableFoodEvent;
            f.UpdateTableFoodEvent += f_UpdateTableFoodEvent;
            f.DeleteTableFoodEvent += f_DeleteTableFoodEvent;
            f.InsertFoodEvent += f_InsertFoodEvent;
            f.UpdateFoodEvent += f_UpdateFoodEvent;
            f.DeleteFoodEvent += f_DeleteFoodEvent;
            f.loginAccount = LoginAccount;
            f.ShowDialog();
        }

        private void f_DeleteCategoryFoodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_DeleteTableFoodEvent(object sender, EventArgs e)
        {
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_DeleteFoodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_UpdateFoodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_InsertFoodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_UpdateTableFoodEvent(object sender, EventArgs e)
        {
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_InsertTableFoodEvent(object sender, EventArgs e)
        {
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_UpdateCategoryFoodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void f_InsertCategoryFooodEvent(object sender, EventArgs e)
        {
            loadListCategoryFoodNameOnComboBox();
            if (lsvBill.Tag != null)
                ShowBill((lsvBill.Tag as Table).ID);
            LoadListTable();
        }

        private void logoutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void showInformationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile(LoginAccount);

            f.ShowDialog();
            this.Show();
        }

        private void cbCategoryFood_SelectedIndexChanged(object sender, EventArgs e)
        {
            ComboBox cb = sender as ComboBox;
            if (cb.SelectedItem == null)
            {
                return;
            }
            Category category_selected = cb.SelectedItem as Category;
            int idCategory = category_selected.ID;
            loadListFoodByCategoryId(idCategory);
        }

        private void Btn_Click(object sender, EventArgs e)
        {
            int tableId = ((sender as Button).Tag as Table).ID;
            lsvBill.Tag = (sender as Button).Tag;
            nmDiscount.Value = 0;
            ShowBill(tableId);
        }

        private void btnAddFood_Click(object sender, EventArgs e)
        {
            Table tableClicked = lsvBill.Tag as Table;
            if (tableClicked == null)
            {
                MessageBox.Show("Vui lòng chọn bàn trước khi thêm món", "Thông báo!");
                return;
            }
            
            if(cbFood.SelectedItem as Food != null)
            {
                int idFood = (cbFood.SelectedItem as Food).Id;
                string categoryFoodName = cbCategoryFood.Text;
                int count = (int)nmCount.Value;
                int idBill = getIdBillUnCheckOutByIdTable(tableClicked.ID);
                if (idBill == -1)
                {
                    //tao bill moi
                    InsertBill(tableClicked.ID);
                    //them bill info
                    int idBillMax = getIdBillUnCheckOutByIdTable(tableClicked.ID);
                    InsertBillInfo(idBillMax, idFood, count);
                }
                else
                {
                    InsertBillInfo(idBill, idFood, count);
                }
            }
            else
            {
                MessageBox.Show("Thêm món vào bàn " + tableClicked.Name + " không thành công !!!", "Cảnh báo!");
            }

            ShowBill(tableClicked.ID);
            LoadListTable();
        }

        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            Table tableClicked = lsvBill.Tag as Table;
            int discount = (int)nmDiscount.Value;

            double finalTotalPrice = Convert.ToDouble(txtTotalPrice.Text.Split(',')[0].Replace(".", ""));
            if (tableClicked == null)
            {
                MessageBox.Show("Vui lòng chọn bàn muốn thanh toán", "Thông báo!");
                return;
            }
            if (MessageBox.Show("CHI TIẾT THANH TOÁN CHO " + tableClicked.Name +
                  String.Format("\nGIẢM GIÁ:   {0}\nTỔNG THANH TOÁN:    {1}", discount, finalTotalPrice)
                  , "Thông báo !!!", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
            {
                CheckOutBill(tableClicked.ID, discount, (float)finalTotalPrice);
                ShowBill(tableClicked.ID);
                LoadListTable();
            }
            
        }

        private void nmDiscount_ValueChanged(object sender, EventArgs e)
        {
            Table tableClicked = lsvBill.Tag as Table;
            if (tableClicked != null)
            {
                ShowBill(tableClicked.ID);
            }
            
        }

        private void btnChangeTable_Click(object sender, EventArgs e)
        {
            Table table1 = lsvBill.Tag as Table;
            Table table2 = cbChangeTable.SelectedItem as Table;
            if (table1 == null)
            {
                MessageBox.Show("Vui lòng chọn bàn trước!", "Thông báo!");
                return;
            }
            fChangeTable f = new fChangeTable(table1, table2);
            f.SwitchTableEvent += f_SwitchTableEvent;
            f.MergeTableEvent += f_MergeTableEvent;
            f.Show();
        }

        private void f_MergeTableEvent(object sender, EventArgs e)
        {
            LoadListTable();
        }

        private void f_SwitchTableEvent(object sender, EventArgs e)
        {
            LoadListTable();
        }

        private void cậpNhậtThôngTinToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile(LoginAccount);

            f.ShowDialog();
            this.Show();
        }

        private void cậpNhậtDanhMụcToolStripMenuItem_Click(object sender, EventArgs e)
        {

            fAdmin f = new fAdmin();
            f.loginAccount = LoginAccount;

            f.ShowDialog();
        }
    }
}
