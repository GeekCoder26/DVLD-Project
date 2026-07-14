using DVLD_BusinessLayer;
using DVLD_PresentationLayer.ApplicationTypes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Tests.Manage_Test_Types
{
    public partial class frmManageTestTypes : Form
    {
        public frmManageTestTypes()
        {
            InitializeComponent();
        }

        private DataTable dtAllTests;

        private void ResetDefaultView()
        {
            dtAllTests = clsTestTypes.GetAllTestTypes();

            dgvTesttypes.DataSource = dtAllTests;
            lblCount.Text = dgvTesttypes.Rows.Count.ToString();


        }

        private void CustomizeForm()
        {
            this.BackColor = Color.FromArgb(240, 245, 255);

            // تنسيق عام لل datagridview 
            dgvTesttypes.BorderStyle = BorderStyle.None;
            dgvTesttypes.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvTesttypes.DefaultCellStyle.BackColor = Color.White;
            dgvTesttypes.DefaultCellStyle.ForeColor = Color.Black;
            dgvTesttypes.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvTesttypes.EnableHeadersVisualStyles = false;
            dgvTesttypes.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvTesttypes.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvTesttypes.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvTesttypes.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvTesttypes.ColumnHeadersHeight = 35;
            dgvTesttypes.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvTesttypes.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvTesttypes.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvTesttypes.BackgroundColor = Color.WhiteSmoke;
            dgvTesttypes.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvTesttypes.MultiSelect = false;
            dgvTesttypes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;


        }

        private void frmManageTestTypes_Load(object sender, EventArgs e)
        {
            ResetDefaultView();
            CustomizeForm();

            if (dgvTesttypes.Rows.Count > 0)
            {
                dgvTesttypes.Columns[0].HeaderText = "Test ID";
                dgvTesttypes.Columns[0].Width = 110;

                dgvTesttypes.Columns[0].HeaderText = "Test Title";
                dgvTesttypes.Columns[0].Width = 110;

                dgvTesttypes.Columns[0].HeaderText = "Test Description";
                dgvTesttypes.Columns[0].Width = 110;

                dgvTesttypes.Columns[0].HeaderText = "Test Fees";
                dgvTesttypes.Columns[0].Width = 110;
            }

        }

        private void editApplicationTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form frm = new frmEditTestTypes((clsTestTypes.enType)dgvTesttypes.CurrentRow.Cells[0].Value);
            frm.ShowDialog();

            ResetDefaultView();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {

            this.Close();
         
        }
    }
}
