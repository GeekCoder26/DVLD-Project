using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Global_Classes;
using DVLD_PresentationLayer.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Tests.Controls
{
    public partial class ctrlScheduleTest : UserControl
    {

        public enum enMode { AddNew, Update}
        private enMode Mode = enMode.AddNew;

        public enum enCreationMode { FirstTimeSchedult, RetakeTestSchedule };
        private enCreationMode CreationMode = enCreationMode.FirstTimeSchedult;

        private clsTestTypes.enType _TestTypeID = clsTestTypes.enType.VisionTest;
        public clsTestTypes.enType TestTypeID
        {
            get { return _TestTypeID; }

            set
            {
                _TestTypeID = value;

                switch(_TestTypeID)
                {
                    case clsTestTypes.enType.VisionTest:
                        gbTestType.Text = "Vision Test";
                        PbTypePicture.Image = Resources.Vision_512;
                        break;

                    case clsTestTypes.enType.WrittenTest:
                        gbTestType.Text = "Written Test";
                        PbTypePicture.Image = Resources.Written_Test_512;
                        break;

                    case clsTestTypes.enType.PracticalTest:
                        gbTestType.Text = "Practical Test";
                        PbTypePicture.Image = Resources.driving_test_512;
                        break;
                }
            }
        }

        private ClsLocalDrivingLicenseApplication _LocalDrivingLicenseApplication;

        private int _LocalDrivingLicenseApplicationID = -1;

        private clsTestAppointment _TestAppointment;

        private int _TestAppointmentID = -1;

        public ctrlScheduleTest()
        {
            InitializeComponent();
        }

        private bool _LoadTestAppointments()
        {
            _TestAppointment = clsTestAppointment.Find(_TestAppointmentID);

            if (_TestAppointment == null)
            {

                MessageBox.Show("Error: No Appointment With ID = " + _TestAppointmentID, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btnSave.Enabled = false;
                return false;

            }
            lblFees.Text = _TestAppointment._PaidFees.ToString();

            //we compare the current date with the appointment date to set the min date.
            if (DateTime.Compare(DateTime.Now, _TestAppointment._AppointmentDate) < 0)
                dtpDate.MinDate = DateTime.Now;
            else
                dtpDate.MinDate = _TestAppointment._AppointmentDate;

            dtpDate.Value = _TestAppointment._AppointmentDate;

            if (_TestAppointment._RetakeTestAppID == -1)
            {
                lblRetakeTestAppID.Text = "0";
                lblRetakeTestAppID.Text = "N/A";
            }
            else
            {
                lblReakeAppFees.Text = _TestAppointment.RetakeTestAppInfo._PaidFees.ToString();
                gbRetakeTestInfo.Enabled = true;
                lblTitle.Text = "Schedule Retake Test";
                lblRetakeTestAppID.Text = _TestAppointment._RetakeTestAppID.ToString();

            }
            return true;



        }

        public void LoadInfo(int LocalDrivingLicenseApplicationID, int TestAppointmentID = -1)
        {

            if (TestAppointmentID == -1)
            {
                Mode = enMode.AddNew;
            }
            else
            {
                Mode = enMode.Update;

            }


            _LocalDrivingLicenseApplicationID = LocalDrivingLicenseApplicationID;
            _TestAppointmentID = TestAppointmentID;

            _LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(_LocalDrivingLicenseApplicationID);

            if(_LocalDrivingLicenseApplication == null )
            {
                MessageBox.Show("Error : No Local Driving License Application Exist", "Error ", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btnSave.Enabled = false;
                return;
            }

            if(_LocalDrivingLicenseApplication.DoesAttendTestType(_TestTypeID))
            {
                CreationMode = enCreationMode.RetakeTestSchedule;
            }
            else
            {
                CreationMode = enCreationMode.FirstTimeSchedult;
            }

            if(CreationMode == enCreationMode.RetakeTestSchedule)
            {
                lblReakeAppFees.Text = clsApplicationTypes.FindApplicationType((int)clsApplication.enApplicationType.RetakeTest)._ApplicationFees.ToString();
                gbRetakeTestInfo.Enabled = true;
                lblTitle.Text = "Schedule Retake Test";
                lblRetakeTestAppID.Text = "0";
            }
            else
            {
                gbRetakeTestInfo.Enabled = false;
                lblTitle.Text = "Schedult Test";
                lblReakeAppFees.Text = "0";
                lblRetakeTestAppID.Text = "N/A";


            }
            lblDrivingLicenseAppID.Text = _LocalDrivingLicenseApplication.LocalDrivingLicenseApplicationID.ToString();
            lblDriverclass.Text = _LocalDrivingLicenseApplication.LicenseInfo._ClassName;
            lblTrial.Text = _LocalDrivingLicenseApplication.TotalTrialsPerTest(TestTypeID).ToString();

            if (Mode == enMode.AddNew)
            {
                
                lblFees.Text = clsTestTypes.FindApplicationType(TestTypeID)._TestTypeFees.ToString();
                dtpDate.MinDate = DateTime.Now;
                lblRetakeTestAppID.Text = "N/A";

                _TestAppointment = new clsTestAppointment();

            }
            else
            
            {
                if (!_LoadTestAppointments())
                    return;

            }

            lblTotalFees.Text = Convert.ToSingle(lblFees.Text) + Convert.ToSingle(lblReakeAppFees).ToString();

            if (!_HandleActiveTestAppointmentConstraint())
                return;

            if (!_HandleAppointmentLockedConstraint())
                return;

            if (!_HandlePrviousTestConstraint())
                return;


        }

        private bool _HandleActiveTestAppointmentConstraint()
        {
            if (Mode == enMode.AddNew && ClsLocalDrivingLicenseApplication.IsThereAnActiveScheduledTest(_LocalDrivingLicenseApplicationID, _TestTypeID))
            {
                lblUserMassage.Text = "Person Already have an active appointment for this test";
                btnSave.Enabled = false;
                dtpDate.Enabled = false;
                return false;
            }

            return true;

        }

        private bool _HandleAppointmentLockedConstraint()
        {
            //if appointment is locked that means the person already sat for this test
            //we cannot update locked appointment
            if (_TestAppointment._IsLocked)
            {
                lblUserMassage.Visible = true;
                lblUserMassage.Text = "Person already sat for the test, appointment loacked.";
                dtpDate.Enabled = false;
                btnSave.Enabled = false;
                return false;

            }
            else
                lblUserMassage.Visible = false;

            return true;
        }

        private bool _HandlePrviousTestConstraint()
        {
            //we need to make sure that this person passed the prvious required test before apply to the new test.
            //person cannno apply for written test unless s/he passes the vision test.
            //person cannot apply for street test unless s/he passes the written test.

            switch (TestTypeID)
            {
                case clsTestTypes.enType.VisionTest:
                    //in this case no required prvious test to pass.
                    lblUserMassage.Visible = false;

                    return true;

                case clsTestTypes.enType.WrittenTest:
                    //Written Test, you cannot sechdule it before person passes the vision test.
                    //we check if pass visiontest 1.
                    if (!_LocalDrivingLicenseApplication.DoesPassTestType(clsTestTypes.enType.VisionTest))
                    {
                        lblUserMassage.Text = "Cannot Sechule, Vision Test should be passed first";
                        lblUserMassage.Visible = true;
                        btnSave.Enabled = false;
                        dtpDate.Enabled = false;
                        return false;
                    }
                    else
                    {
                        lblUserMassage.Visible = false;
                        btnSave.Enabled = true;
                        dtpDate.Enabled = true;
                    }


                    return true;

                case clsTestTypes.enType.PracticalTest:

                    //Street Test, you cannot sechdule it before person passes the written test.
                    //we check if pass Written 2.
                    if (!_LocalDrivingLicenseApplication.DoesPassTestType(clsTestTypes.enType.WrittenTest))
                    {
                        lblUserMassage.Text = "Cannot Sechule, Written Test should be passed first";
                        lblUserMassage.Enabled = false;
                        return false;
                    }
                    else
                    {
                        lblUserMassage.Visible = false;
                        btnSave.Enabled = true;
                        dtpDate.Enabled = true;
                    }


                    return true;

            }
            return true;
        }

        private bool _HandleRetakeApplication()
        {
            //this will decide to create a seperate application for retake test or not.
            // and will create it if needed , then it will linkit to the appoinment.
            if (Mode == enMode.AddNew && CreationMode == enCreationMode.RetakeTestSchedule)
            {
                //incase the mode is add new and creation mode is retake test we should create a seperate application for it.
                //then we linke it with the appointment.

                //First Create Applicaiton 
                clsApplication Application = new clsApplication();

                Application._PersonID = _LocalDrivingLicenseApplication._PersonID;
                Application._ApplicationDate = DateTime.Now;
                Application._ApplicationTypeID = (int)clsApplication.enApplicationType.RetakeTest;
                Application.applicationStatus = clsApplication.enApplicationStatus.Completed;
                Application._LastStatusDate = DateTime.Now;
                Application._PaidFees = clsApplicationTypes.FindApplicationType((int)clsApplication.enApplicationType.RetakeTest)._ApplicationFees;
                Application._UserID = clsGlobalSettings.User._UserID;

                if (!Application.Save())
                {
                    _TestAppointment._RetakeTestAppID = -1;
                    MessageBox.Show("Faild to Create application", "Faild", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }

                _TestAppointment._RetakeTestAppID = Application._ApplicationID;

            }
            return true;
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!_HandleRetakeApplication())
                return;

            _TestAppointment._TestTypeID = _TestTypeID;
            _TestAppointment._LocalDrivingLicenseApplicationID = _LocalDrivingLicenseApplication.LocalDrivingLicenseApplicationID;
            _TestAppointment._AppointmentDate = dtpDate.Value;
            _TestAppointment._PaidFees = Convert.ToSingle(lblFees.Text);
            _TestAppointment._UserID = clsGlobalSettings.User._UserID;

            if (_TestAppointment.Save())
            {
                Mode = enMode.Update;
                MessageBox.Show("Data Saved Successfully.", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
                MessageBox.Show("Error: Data Is not Saved Successfully.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

        }
    }
}
