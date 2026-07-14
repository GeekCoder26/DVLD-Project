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

namespace DVLD_PresentationLayer.Tests
{
    public partial class frmListTetAppointments : Form
    {


        private DataTable _dtLicenseTestAppointments = new DataTable();

        private int _LocalDrivingLicenseApplicationID;

        private clsTestTypes.enType _TestType = clsTestTypes.enType.VisionTest;




        public frmListTetAppointments(int LocalDrivingLicenseAppID, clsTestTypes.enType TestTypes)
        {

            InitializeComponent();
            _LocalDrivingLicenseApplicationID = LocalDrivingLicenseAppID;
            _TestType = TestTypes;

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

        private void frmListTetAppointments_Load(object sender, EventArgs e)
        {
            ctrlLocalDrivingLicenseApplication1.LoadApplicationINfoByLocalDrivingID(_LocalDrivingLicenseApplicationID);
            _dtLicenseTestAppointments = clsTestAppointment.GetApplicationTestAppointmentPerTestType(_LocalDrivingLicenseApplicationID, _TestType);

            CustomizeForm();

            dgvShowPeople.DataSource = _dtLicenseTestAppointments;
            toolStripStatusLabel1.Text = "# Records: " + dgvShowPeople.Rows.Count.ToString();

            if (dgvShowPeople.Rows.Count > 0)

            {
                dgvShowPeople.Columns[0].HeaderText = "Appointment ID";
                dgvShowPeople.Columns[0].Width = 150;

                dgvShowPeople.Columns[1].HeaderText = "Appointment Date";
                dgvShowPeople.Columns[1].Width = 200;

                dgvShowPeople.Columns[2].HeaderText = "Paid Fees";
                dgvShowPeople.Columns[2].Width = 150;

                dgvShowPeople.Columns[3].HeaderText = "Is Locked";
                dgvShowPeople.Columns[3].Width = 100;

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ClsLocalDrivingLicenseApplication LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(_LocalDrivingLicenseApplicationID);

            if(LocalDrivingLicenseApplication.IsThereAnActiveScheduledTest(_TestType))
            {
                MessageBox.Show("Person Already Have An Active Appointment for this test", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }







        }
    }
}
