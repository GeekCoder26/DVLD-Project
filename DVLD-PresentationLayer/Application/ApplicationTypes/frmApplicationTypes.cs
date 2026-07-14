using DVLD_BusinessLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.ApplicationTypes
{
    public partial class frmApplicationTypes : Form
    {
        public frmApplicationTypes()
        {
            InitializeComponent();
        }

        private DataTable AllApplication;

        private void ResetDefaultView()
        {
            AllApplication = clsApplicationTypes.GetAllApplication();

            dgvApplicationtypes.DataSource = AllApplication;
            lblCount.Text = dgvApplicationtypes.Rows.Count.ToString();


        }

        private void CustomizeForm()
        {
            this.BackColor = Color.FromArgb(240, 245, 255);

            // تنسيق عام لل datagridview 
            dgvApplicationtypes.BorderStyle = BorderStyle.None;
            dgvApplicationtypes.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvApplicationtypes.DefaultCellStyle.BackColor = Color.White;
            dgvApplicationtypes.DefaultCellStyle.ForeColor = Color.Black;
            dgvApplicationtypes.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvApplicationtypes.EnableHeadersVisualStyles = false;
            dgvApplicationtypes.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvApplicationtypes.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvApplicationtypes.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvApplicationtypes.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvApplicationtypes.ColumnHeadersHeight = 35;
            dgvApplicationtypes.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvApplicationtypes.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvApplicationtypes.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvApplicationtypes.BackgroundColor = Color.WhiteSmoke;
            dgvApplicationtypes.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvApplicationtypes.MultiSelect = false;
            dgvApplicationtypes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            
        }

        private void frmApplicationTypes_Load(object sender, EventArgs e)
        {
            ResetDefaultView();
            CustomizeForm();

            if(dgvApplicationtypes.Rows.Count > 0)
            {
                dgvApplicationtypes.Columns[0].HeaderText = "Application ID";
                dgvApplicationtypes.Columns[0].Width = 110;

                dgvApplicationtypes.Columns[0].HeaderText = "Application Title";
                dgvApplicationtypes.Columns[0].Width = 110;

                dgvApplicationtypes.Columns[0].HeaderText = "Application Fees";
                dgvApplicationtypes.Columns[0].Width = 110;
            }



        }

        private void editApplicationTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form frm = new frmEditApplicationTypes((int)dgvApplicationtypes.CurrentRow.Cells[0].Value);
            frm.ShowDialog();

            ResetDefaultView();


        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
