using DVLD_BusinessLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Users
{
    public partial class frmManageUsers : Form
    {

        enum enMode { AddNew, Update};
        enMode Mode;

         private static DataTable _dtUsersList = clsUsers.GetAllUsers();

        DataTable _dtUsers = _dtUsersList.DefaultView.ToTable(false, "UserID", "PersonID", "Username", "IsActive");



        public frmManageUsers()
        {
            InitializeComponent();

            RefreshList();
        }


        private void RefreshList()
        {
            DataTable dt = clsUsers.GetAllUsers();

            _dtUsers = dt.DefaultView.ToTable(false, "UserID", "PersonID", "Username", "IsActive");

            dgvUsersList.DataSource = _dtUsers;
            toolStripStatusLabel1.Text = "# Records: " + dgvUsersList.Rows.Count.ToString();

        }

        private void CustomizeForm()
        {
            this.BackColor = Color.FromArgb(240, 245, 255);

            // تنسيق عام لل datagridview 
            dgvUsersList.BorderStyle = BorderStyle.None;
            dgvUsersList.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvUsersList.DefaultCellStyle.BackColor = Color.White;
            dgvUsersList.DefaultCellStyle.ForeColor = Color.Black;
            dgvUsersList.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvUsersList.EnableHeadersVisualStyles = false;
            dgvUsersList.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvUsersList.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvUsersList.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvUsersList.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvUsersList.ColumnHeadersHeight = 35;
            dgvUsersList.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvUsersList.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvUsersList.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvUsersList.BackgroundColor = Color.WhiteSmoke;
            dgvUsersList.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvUsersList.MultiSelect = false;
            dgvUsersList.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            toolStripStatusLabel1.Text = "# Records: 0";
        }
        private void frmManageUsers_Load(object sender, EventArgs e)
        {
            CustomizeForm();
            RefreshList();

            cmbFilterby.SelectedIndex = 0;
            txbFilter.Visible = false;
            cmbIsActive.Visible = false;

            if(dgvUsersList.Rows.Count > 0)
            {
                dgvUsersList.Columns[0].HeaderText = "UserID";
                dgvUsersList.Columns[0].Width = 110;

                dgvUsersList.Columns[1].HeaderText = "PersonID";
                dgvUsersList.Columns[1].Width = 120;

                dgvUsersList.Columns[2].HeaderText = "Username";
                dgvUsersList.Columns[2].Width = 140;

                dgvUsersList.Columns[3].HeaderText = "IsActive";
                dgvUsersList.Columns[3].Width = 110;                
            }


        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnAddUser_Click(object sender, EventArgs e)
        {
            frmAddUser frm = new frmAddUser();
            frm.ShowDialog();

            RefreshList();
        }

        private void tsmAddNewUser_Click(object sender, EventArgs e)
        {
            frmAddUser frm = new frmAddUser();
            frm.ShowDialog();

            RefreshList();
        }

        private void tsmEdit_Click(object sender, EventArgs e)
        {
            frmAddUser frm = new frmAddUser((int)dgvUsersList.CurrentRow.Cells[0].Value, (int)dgvUsersList.CurrentRow.Cells[1].Value);
            frm.ShowDialog();

            RefreshList();
        }

        private void DeleteUser()
        {

            int UserID = (int)dgvUsersList.CurrentRow.Cells[0].Value;

            if(MessageBox.Show($"Are You Sure You Want To Delete PersonID [{UserID}]", "Confirm Delete",
            MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.OK)
            {

                if(clsUsers.DeleteUser(UserID))
                {
                    MessageBox.Show("User Deleted Successfully", "Delete User", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("User Was Not Deleted Because it has data linked to it ", "Delete Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

            }

        }
        private void tsmDelete_Click(object sender, EventArgs e)
        {
            DeleteUser();
            RefreshList();
        }

        private void tsmshowDetails_Click(object sender, EventArgs e)
        {
            Form frm = new frmShowDetails((int)dgvUsersList.CurrentRow.Cells[0].Value, (int)dgvUsersList.CurrentRow.Cells[1].Value);
            frm.ShowDialog();


        }

        private void txbFilter_TextChanged(object sender, EventArgs e)
        {

            string filtercolumn = "";

            switch(cmbFilterby.Text)
            {

                case "User ID":
                    filtercolumn = "UserID";
                    break;
                case "Person ID":
                    filtercolumn = "PersonID";
                    break;
                case "username":
                    filtercolumn = "username";
                    break;
                case "IsActive":
                    filtercolumn = "IsActive";
                    break;
                default:
                    filtercolumn = "None";
                    break;
            }

            if ( filtercolumn == "None" || txbFilter.Text == "")
            {
                _dtUsers.DefaultView.RowFilter = "";
                toolStripStatusLabel1.Text = dgvUsersList.Rows.Count.ToString();
                return;
            }

            if( filtercolumn == "UserID" || filtercolumn == "PersonID")
            {
                _dtUsers.DefaultView.RowFilter = string.Format("[{0}] = {1}", filtercolumn, txbFilter.Text);
            }
            else if (filtercolumn == "IsActive")
            {
                txbFilter.Visible = false;
            }
            else
            {
                _dtUsers.DefaultView.RowFilter = string.Format("[{0}] LIKE '{1}%'", filtercolumn, txbFilter.Text.Trim());
                toolStripStatusLabel1.Text = dgvUsersList.Rows.Count.ToString();
            }



        }

        private void cmbFilterby_SelectedIndexChanged(object sender, EventArgs e)
        {
            txbFilter.Visible = (cmbFilterby.Text != "None" && cmbFilterby.Text != "IsActive");
            cmbIsActive.Visible = (cmbFilterby.Text == "IsActive");

            if(cmbFilterby.Text == "IsActive")
            {
                txbFilter.Visible = false;
                cmbIsActive.Visible = true;
            }

            if(txbFilter.Visible)
            {
                txbFilter.Text = "";
                txbFilter.Focus();
            }
        }

        private void txbFilter_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(cmbFilterby.Text == "User ID" || cmbFilterby.Text == "Person ID")
            {
                e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);
            }
        }

        private void cmbIsActive_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbFilterby.Text == "IsActive" && cmbIsActive.Text == "All")
            {
                _dtUsers.DefaultView.RowFilter = "";
                toolStripStatusLabel1.Text = dgvUsersList.Rows.Count.ToString();
                return;
            }

            

            if(cmbIsActive.Text == "Yes")
            {
                _dtUsers.DefaultView.RowFilter = string.Format("[{0}] = {1}", "IsActive", true);
            }
            else
            {
                _dtUsers.DefaultView.RowFilter = string.Format("[{0}] = {1}", "IsActive", false);
            }

        }

        private void tsmChangePassword_Click(object sender, EventArgs e)
        {
            Form frm = new frmChangePassword((int)dgvUsersList.CurrentRow.Cells[0].Value, (int)dgvUsersList.CurrentRow.Cells[1].Value);
            frm.ShowDialog();
        }

        private void dgvUsersList_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            Form frm = new frmShowDetails((int)dgvUsersList.CurrentRow.Cells[0].Value, (int)dgvUsersList.CurrentRow.Cells[1].Value);
            frm.ShowDialog();
        }

        private void dgvUsersList_MouseDown(object sender, MouseEventArgs e)
        {
            // التحقق إن كان الزر الأيمن للفأرة هو المستخدم
            if (e.Button == MouseButtons.Right)
            {
                // تحديد الصف الذي تم النقر عليه
                var hitTestInfo = dgvUsersList.HitTest(e.X, e.Y);
                if (hitTestInfo.RowIndex >= 0)
                {
                    // تحديد الصف
                    dgvUsersList.ClearSelection();
                    dgvUsersList.Rows[hitTestInfo.RowIndex].Selected = true;

                    // عرض القائمة عند مكان النقر
                    contextMenuStrip1.Show(dgvUsersList, e.Location);
                }
            }
        }
    }
}
