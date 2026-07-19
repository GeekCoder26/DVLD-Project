using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DVLD_BusinessLayer;
using DVLD_PresentationLayer.People;


namespace DVLD_PresentationLayer
{
    public partial class frmListPeople : Form
    {

        private static DataTable _dtAllPeople = clsPerson.GetAllPeople();

        private DataTable _dtPeople = _dtAllPeople.DefaultView.ToTable(false, "PersonID", "NationalNo",
                                                       "FirstName", "SecondName", "ThirdName", "LastName",
                                                       "Gender", "DateOfBirth", "Nationality",
                                                       "Phone", "Email");

        public frmListPeople()
        {
            InitializeComponent();

            RefreshList();


        }

        private void pbAddPeople_Click(object sender, EventArgs e)
        {
            Form frm1 = new Add_Edit_Form();
            frm1.ShowDialog();

            RefreshList();
        }
        public  void RefreshList()
        {
            _dtAllPeople = clsPerson.GetAllPeople();

            _dtPeople = _dtAllPeople.DefaultView.ToTable(false, "PersonID", "NationalNo",
                                                       "FirstName", "SecondName", "ThirdName", "LastName",
                                                       "Gender", "DateOfBirth", "Nationality",
                                                       "Phone", "Email");
    
            dgvShowPeople.DataSource = _dtPeople;
            toolStripStatusLabel1.Text = "# Records: " + dgvShowPeople.Rows.Count.ToString();
            
        }

        private void CustomizeForm()
        {
            this.BackColor = Color.FromArgb(240, 245, 255);

            // تنسيق عام لل datagridview 
            dgvShowPeople.BorderStyle = BorderStyle.None;
            dgvShowPeople.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvShowPeople.DefaultCellStyle.BackColor = Color.White;
            dgvShowPeople.DefaultCellStyle.ForeColor = Color.Black;
            dgvShowPeople.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvShowPeople.EnableHeadersVisualStyles = false;
            dgvShowPeople.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvShowPeople.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvShowPeople.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvShowPeople.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvShowPeople.ColumnHeadersHeight = 35;
            dgvShowPeople.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvShowPeople.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvShowPeople.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvShowPeople.BackgroundColor = Color.WhiteSmoke;
            dgvShowPeople.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvShowPeople.MultiSelect = false;
            dgvShowPeople.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            toolStripStatusLabel1.Text = "# Records: 0";



        }
        private void Form1_Load(object sender, EventArgs e)
        {

            CustomizeForm();
            RefreshList();
            cmbFilterPeople.SelectedIndex = 0;
            tbFilterBy.Visible = false;

            if(dgvShowPeople.Rows.Count > 0)

            {
                dgvShowPeople.Columns[0].HeaderText = "Person ID";
                dgvShowPeople.Columns[0].Width = 110;

                dgvShowPeople.Columns[1].HeaderText = "National No";
                dgvShowPeople.Columns[1].Width = 120;

                dgvShowPeople.Columns[2].HeaderText = "FirstName";
                dgvShowPeople.Columns[2].Width = 120;

                dgvShowPeople.Columns[3].HeaderText = "SecondName";
                dgvShowPeople.Columns[3].Width = 140;

                dgvShowPeople.Columns[4].HeaderText = "ThirdName";
                dgvShowPeople.Columns[4].Width = 120;

                dgvShowPeople.Columns[5].HeaderText = "LastName";
                dgvShowPeople.Columns[5].Width = 120;

                dgvShowPeople.Columns[6].HeaderText = "Gender";
                dgvShowPeople.Columns[6].Width = 120;

                dgvShowPeople.Columns[7].HeaderText = "DateOfBirth";
                dgvShowPeople.Columns[7].Width = 140;

                dgvShowPeople.Columns[8].HeaderText = "Nationality";
                dgvShowPeople.Columns[8].Width = 120;

                dgvShowPeople.Columns[9].HeaderText = "Phone";
                dgvShowPeople.Columns[9].Width = 120;

                dgvShowPeople.Columns[10].HeaderText = "Email";
                dgvShowPeople.Columns[10].Width = 170;
            }


        }
        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            RefreshList();
        }
        private void dgvShowPeople_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            contextMenuStrip1.Show();
        }
        public void DeletePersonFromSystem()
        {

            int PersonID = (int)dgvShowPeople.CurrentRow.Cells[0].Value;
            
            if(MessageBox.Show($"Are You Sure You Want To Delete PersonID [{PersonID}]", "Confirm Delete",
    MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.OK)
            { 
                if (clsPerson.DeletePerson(PersonID))
                {
                    MessageBox.Show("Person Deleted Successfully", "Successful", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);

                }
                else
                {
                    MessageBox.Show("Person Was Not Deleted Because It Has Data Linked To It", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1);
                }

            }
        }
        private void CmsDelete_Click(object sender, EventArgs e)
        {

            DeletePersonFromSystem();
            RefreshList();
        }
        
        private void tbFilterBy_TextChanged(object sender, EventArgs e)
        {
            string FilterColumn = cmbFilterPeople.SelectedItem.ToString();

            switch (cmbFilterPeople.Text)
            {

                case "PersonID":
                    FilterColumn = "PersonID";
                    break;

                case "NationalNo":
                    FilterColumn = "NationalNo";
                    break;

                case "Firstname":
                    FilterColumn = "Firstname";
                    break;

                case "Secondname":
                    FilterColumn = "Secondname";
                    break;

                case "Thirdname":
                    FilterColumn = "Thirdname";
                    break;

                case "Lastname":
                    FilterColumn = "Lastname";
                    break;

                case "gender":
                    FilterColumn = "gender";
                    break;

                case "DateOfBirth":
                    FilterColumn = "DateOfBirth";
                    break;

                case "Address":
                    FilterColumn = "Address";
                    break;

                case "Phone":
                    FilterColumn = "Phone";
                    break;

                case "Email":
                    FilterColumn = "Email";
                    break;

                default:
                    FilterColumn = "None";
                    break;


            }

            if (tbFilterBy.Text.Trim() == "" || FilterColumn == "None")
            {
                _dtPeople.DefaultView.RowFilter = string.Empty;
                statusStrip1.Text = $"# Records: {dgvShowPeople.Rows.Count}";
                return;
            }

            if(FilterColumn == "PersonID")
            {
                _dtPeople.DefaultView.RowFilter = string.Format("[{0}] = {1}", FilterColumn, tbFilterBy.Text.Trim());
            }
            else
            {
                _dtPeople.DefaultView.RowFilter = string.Format("[{0}] Like '{1}%'", FilterColumn, tbFilterBy.Text.Trim());
            }
            statusStrip1.Text = $"# Records: {dgvShowPeople.Rows.Count}";


        }

        private void cmbFilterPeople_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbFilterBy.Visible = (cmbFilterPeople.Text != "None");

            if(tbFilterBy.Visible)
            {
                tbFilterBy.Text = "";
                tbFilterBy.Focus();
            }
            
        }
        private void CmsAddNewPerson_Click(object sender, EventArgs e)
        {
            Form frm1 = new Add_Edit_Form();
            frm1.ShowDialog();

            RefreshList();
        }
        private void CmsEdit_Click(object sender, EventArgs e)
        {

            Add_Edit_Form frm1 = new Add_Edit_Form((int)dgvShowPeople.CurrentRow.Cells[0].Value);
            frm1.ShowDialog();

            RefreshList();

        }
        private void tbFilterBy_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(cmbFilterPeople.SelectedItem.ToString() == "PersonID")
                e.Handled = !char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar); // منع الكتابة




        }

        private void CmsShowDetails_Click(object sender, EventArgs e)
        {
            int PersonID = (int)dgvShowPeople.CurrentRow.Cells[0].Value;

            frmShowPersonDetails frm = new frmShowPersonDetails(PersonID);
            frm.ShowDialog();
        }
    }
}
