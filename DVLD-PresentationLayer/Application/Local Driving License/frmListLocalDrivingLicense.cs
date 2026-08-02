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

namespace DVLD_PresentationLayer.Application.Local_Driving_License
{
    public partial class frmListLocalDrivingLicense : Form
    {
        private DataTable _dtAllLocalDrivingLicenseApplications;
        public frmListLocalDrivingLicense()
        {
            InitializeComponent();
        }

        private void frmListLocalDrivingLicense_Load(object sender, EventArgs e)
        {
            _dtAllLocalDrivingLicenseApplications = ClsLocalDrivingLicenseApplication.GetAllLocalDrivingLicenseApplication();
            dgvShowLDLA.DataSource = _dtAllLocalDrivingLicenseApplications;

            CustomizeForm();

            Records.Text = $"# Records: {dgvShowLDLA.Rows.Count}";
            if (dgvShowLDLA.Rows.Count > 0)
            {

                dgvShowLDLA.Columns[0].HeaderText = "L.D.L.AppID";
                dgvShowLDLA.Columns[0].Width = 120;

                dgvShowLDLA.Columns[1].HeaderText = "Driving Class";
                dgvShowLDLA.Columns[1].Width = 300;

                dgvShowLDLA.Columns[2].HeaderText = "National No.";
                dgvShowLDLA.Columns[2].Width = 200;

                dgvShowLDLA.Columns[3].HeaderText = "Full Name";
                dgvShowLDLA.Columns[3].Width = 300;

                dgvShowLDLA.Columns[4].HeaderText = "Application Date";
                dgvShowLDLA.Columns[4].Width = 170;

                dgvShowLDLA.Columns[5].HeaderText = "Passed Tests";
                dgvShowLDLA.Columns[5].Width = 150;

                dgvShowLDLA.Columns[6].HeaderText = "Status";
                dgvShowLDLA.Columns[6].Width = 150;
            }

            cmbFilterApplications.SelectedIndex = 0;
        }

        private void CustomizeForm()
        {
            this.BackColor = Color.FromArgb(240, 245, 255);

            // تنسيق عام لل datagridview 
            dgvShowLDLA.BorderStyle = BorderStyle.None;
            dgvShowLDLA.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvShowLDLA.DefaultCellStyle.BackColor = Color.White;
            dgvShowLDLA.DefaultCellStyle.ForeColor = Color.Black;
            dgvShowLDLA.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvShowLDLA.EnableHeadersVisualStyles = false;
            dgvShowLDLA.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvShowLDLA.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvShowLDLA.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvShowLDLA.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvShowLDLA.ColumnHeadersHeight = 35;
            dgvShowLDLA.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvShowLDLA.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvShowLDLA.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvShowLDLA.BackgroundColor = Color.WhiteSmoke;
            dgvShowLDLA.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvShowLDLA.MultiSelect = false;
            dgvShowLDLA.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            Records.Text = "# Records: 0";



        }

        private void cmbFilterApplications_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbFilterBy.Visible = (cmbFilterApplications.SelectedIndex != 0);

            if (tbFilterBy.Visible)
            {
                tbFilterBy.Text = "";
                tbFilterBy.Focus();
            }

            _dtAllLocalDrivingLicenseApplications.DefaultView.RowFilter = "";
            Records.Text = $"# Records: {dgvShowLDLA.Rows.Count}";




        }

        private void tbFilterBy_TextChanged(object sender, EventArgs e)
        {
            string FilterColumn = "";
            //Map Selected Filter to real Column name 
            switch (cmbFilterApplications.Text)
            {

                case "L.D.L.AppID":
                    FilterColumn = "LocalDrivingLicenseApplicationID";
                    break;

                case "Nationalno":
                    FilterColumn = "NationalNo";
                    break;


                case "Fullname":
                    FilterColumn = "FullName";
                    break;

                case "Status":
                    FilterColumn = "Status";
                    break;


                default:
                    FilterColumn = "None";
                    break;

            }

            //Reset the filters in case nothing selected or filter value conains nothing.
            if (tbFilterBy.Text.Trim() == "" || FilterColumn == "None")
            {
                _dtAllLocalDrivingLicenseApplications.DefaultView.RowFilter = "";
                Records.Text = dgvShowLDLA.Rows.Count.ToString();
                return;
            }


            if (FilterColumn == "LocalDrivingLicenseApplicationID")
                //in this case we deal with integer not string.
                _dtAllLocalDrivingLicenseApplications.DefaultView.RowFilter = string.Format("[{0}] = {1}", FilterColumn, tbFilterBy.Text.Trim());
            else
                _dtAllLocalDrivingLicenseApplications.DefaultView.RowFilter = string.Format("[{0}] LIKE '{1}%'", FilterColumn, tbFilterBy.Text.Trim());

            Records.Text = dgvShowLDLA.Rows.Count.ToString();
        }

        private void tbFilterBy_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cmbFilterApplications.Text == "L.D.L.AppID")
                e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnAddNew_Click(object sender, EventArgs e)
        {
            frmAddNewLocalLicenseApp Form = new frmAddNewLocalLicenseApp();
            Form.ShowDialog();
        }

        private void cmsEditApplication_Click(object sender, EventArgs e)
        {
            int LocalDrivingLicenseApplicationID = (int)dgvShowLDLA.CurrentRow.Cells[0].Value;
            frmAddNewLocalLicenseApp Form = new frmAddNewLocalLicenseApp(LocalDrivingLicenseApplicationID);

            Form.ShowDialog();

            frmListLocalDrivingLicense_Load(null, null);
        }

        private void CmsShowDetails_Click(object sender, EventArgs e)
        {

            frmLocalDrivingLicenseApplication form = new frmLocalDrivingLicenseApplication((int)dgvShowLDLA.CurrentRow.Cells[0].Value);

            form.ShowDialog();

            frmListLocalDrivingLicense_Load(null, null);
        }

        private void cmsDeleteApplication_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to delete this application", "Delete Application", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                return;
            }
            int LcoalDrivingLicenseID = (int)dgvShowLDLA.CurrentRow.Cells[0].Value;

            ClsLocalDrivingLicenseApplication LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(LcoalDrivingLicenseID);

            if(LocalDrivingLicenseApplication != null)
            {
                if (LocalDrivingLicenseApplication.Delete())
                {
                    MessageBox.Show("Application Deleted Successfully", "Delete Application", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    frmListLocalDrivingLicense_Load(null, null);
                }
                else
                {
                    MessageBox.Show("Application Delete Failed", "Delete Application", MessageBoxButtons.OK, MessageBoxIcon.Stop);

                }
            }
            else
            {
                MessageBox.Show("Application Not Found", "Invalid Application", MessageBoxButtons.OK, MessageBoxIcon.Stop);

            }

        }

        private void cmsCancelApplication_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to Cancel this application", "Cancel Application", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                return;
            }

            int LcoalDrivingLicenseID = (int)dgvShowLDLA.CurrentRow.Cells[0].Value;

            ClsLocalDrivingLicenseApplication LocalDrivingApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(LcoalDrivingLicenseID);

            if(LocalDrivingApplication != null)
            {
                if(LocalDrivingApplication.Cancel())
                {
                    MessageBox.Show("Application Cancelled Successfully", "Cancel Application", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    frmListLocalDrivingLicense_Load(null, null);
                }
                else
                {
                    MessageBox.Show("Application Cancelled Failed", "Cancel Application", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                }
            }
            else
            {

                MessageBox.Show("Application Not Found", "invalid Application", MessageBoxButtons.OK, MessageBoxIcon.Stop);

            }

        }

        private void cmsScheduleTest_Click(object sender, EventArgs e)
        {
            MessageBox.Show("This functionality is not ready", "", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void cmsIssueDrivingLicense_Click(object sender, EventArgs e)
        {
            MessageBox.Show("This functionality is not ready", "", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void cmsShowLicense_Click(object sender, EventArgs e)
        {
            MessageBox.Show("This functionality is not ready", "", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void cmsLicenseHistory_Click(object sender, EventArgs e)
        {
            MessageBox.Show("This functionality is not ready", "", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void cmsApplications_Opening(object sender, CancelEventArgs e)
        {
            int LocalDrivingLicenseApplicationID = (int)dgvShowLDLA.CurrentRow.Cells[0].Value;

            ClsLocalDrivingLicenseApplication LocalDrivingApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(LocalDrivingLicenseApplicationID);

            if (LocalDrivingApplication == null)
            {
                MessageBox.Show("Application Not Found", "Invalid Application", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return;

            }


            int TotalPassedTest = (int)dgvShowLDLA.CurrentRow.Cells[5].Value;

            bool isLicenseExists = LocalDrivingApplication.IsLicenseIssued();

            cmsIssueDrivingLicense.Enabled = (TotalPassedTest == 3) && (isLicenseExists == false);

            cmsShowLicense.Enabled = isLicenseExists;

            cmsEditApplication.Enabled = !isLicenseExists && (LocalDrivingApplication.applicationStatus == clsApplication.enApplicationStatus.New);

            cmsScheduleTest.Enabled = !isLicenseExists;

            cmsCancelApplication.Enabled = (LocalDrivingApplication.applicationStatus == clsApplication.enApplicationStatus.New);

            cmsDeleteApplication.Enabled = (LocalDrivingApplication.applicationStatus == clsApplication.enApplicationStatus.New);

            bool PassedVisionTest = LocalDrivingApplication.DoesPassTestType(clsTestTypes.enType.VisionTest);
            bool PassedWrittenTest = LocalDrivingApplication.DoesPassTestType(clsTestTypes.enType.WrittenTest);
            bool PassedStreetTest = LocalDrivingApplication.DoesPassTestType(clsTestTypes.enType.PracticalTest);

            cmsScheduleTest.Enabled = (!PassedVisionTest || !PassedWrittenTest || !PassedStreetTest) && (LocalDrivingApplication.applicationStatus == clsApplication.enApplicationStatus.New);


            if(cmsScheduleTest.Enabled)
            {
                cmsVisionTest.Enabled = !PassedVisionTest;

                cmsWrittenTest.Enabled = PassedVisionTest && !PassedWrittenTest;

                cmsStreetTest.Enabled = PassedVisionTest && PassedWrittenTest && !PassedStreetTest;
            }


        }
    }
}
