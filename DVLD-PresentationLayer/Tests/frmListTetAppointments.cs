using DVLD_Buisness;
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
            dgvTestAppointment.BorderStyle = BorderStyle.None;
            dgvTestAppointment.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(240, 240, 240);
            dgvTestAppointment.DefaultCellStyle.BackColor = Color.White;
            dgvTestAppointment.DefaultCellStyle.ForeColor = Color.Black;
            dgvTestAppointment.DefaultCellStyle.Font = new Font("Segoe UI", 10);

            // تنسيق راس الاعمدة
            dgvTestAppointment.EnableHeadersVisualStyles = false;
            dgvTestAppointment.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(60, 120, 200);
            dgvTestAppointment.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgvTestAppointment.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI Semibold", 10);
            dgvTestAppointment.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;

            // ضبط ارتفاع الرأس والصفوف
            dgvTestAppointment.ColumnHeadersHeight = 35;
            dgvTestAppointment.RowTemplate.Height = 30;

            // إزالة الحدود الثقيلة
            dgvTestAppointment.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvTestAppointment.GridColor = Color.LightGray;

            // تحسين المظهر العام
            dgvTestAppointment.BackgroundColor = Color.WhiteSmoke;
            dgvTestAppointment.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvTestAppointment.MultiSelect = false;
            dgvTestAppointment.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

            toolStripStatusLabel1.Text = "# Records: 0";



        }

        private void frmListTetAppointments_Load(object sender, EventArgs e)
        {
            ctrlLocalDrivingLicenseApplication1.LoadApplicationINfoByLocalDrivingID(_LocalDrivingLicenseApplicationID);
            _dtLicenseTestAppointments = clsTestAppointment.GetApplicationTestAppointmentPerTestType(_LocalDrivingLicenseApplicationID, _TestType);

            CustomizeForm();

            dgvTestAppointment.DataSource = _dtLicenseTestAppointments;
            toolStripStatusLabel1.Text = "# Records: " + dgvTestAppointment.Rows.Count.ToString();

            if (dgvTestAppointment.Rows.Count > 0)

            {
                dgvTestAppointment.Columns[0].HeaderText = "Appointment ID";
                dgvTestAppointment.Columns[0].Width = 150;

                dgvTestAppointment.Columns[1].HeaderText = "Appointment Date";
                dgvTestAppointment.Columns[1].Width = 200;

                dgvTestAppointment.Columns[2].HeaderText = "Paid Fees";
                dgvTestAppointment.Columns[2].Width = 150;

                dgvTestAppointment.Columns[3].HeaderText = "Is Locked";
                dgvTestAppointment.Columns[3].Width = 100;

            }
        }

        private void btnAddTestAppointment_Click(object sender, EventArgs e)
        {
            ClsLocalDrivingLicenseApplication LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(_LocalDrivingLicenseApplicationID);

            if (LocalDrivingLicenseApplication.IsThereAnActiveScheduledTest(_TestType))
            {
                MessageBox.Show("Person Already Have An Active Appointment for this test", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            clsTest LastTest = LocalDrivingLicenseApplication.GetLastTestPerTestType(_TestType);


            if (LastTest == null)
            {
                frmScheduleTest form = new frmScheduleTest(_LocalDrivingLicenseApplicationID, _TestType);
                form.ShowDialog();

                frmListTetAppointments_Load(null, null);
                return;
            }

            if (LastTest.TestResult == true)
            {
                MessageBox.Show("This person already passed this test before, you can only retake faild test", "Not Allowed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }


            frmScheduleTest form2 = new frmScheduleTest(LastTest.TestAppointmentInfo._LocalDrivingLicenseApplicationID, _TestType);
            form2.ShowDialog();

            frmListTetAppointments_Load(null, null);

        }

        private void cmsEdit_Click(object sender, EventArgs e)
        {
            int TestAppointmentID = (int)dgvTestAppointment.CurrentRow.Cells[0].Value;

            frmScheduleTest form = new frmScheduleTest(_LocalDrivingLicenseApplicationID, _TestType, TestAppointmentID);

            form.ShowDialog();
            frmListTetAppointments_Load(null, null);

        }

        private void cmsTakeTest_Click(object sender, EventArgs e)
        {

            int TestAppointmentID = (int)dgvTestAppointment.CurrentRow.Cells[0].Value;

            frmTakeTest form = new frmTakeTest(TestAppointmentID, _TestType);
            form.ShowDialog();

            frmListTetAppointments_Load(null, null);

        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
