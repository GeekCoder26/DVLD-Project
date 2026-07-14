using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Global_Classes;
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
    public partial class frmAddNewLocalLicenseApp : Form
    {

        enum enMode { AddNew = 1, Update = 2};
        enMode Mode;

        int _ApplicationID;
        int _LocalDrivingLicenseApplicationID = -1;
        int _SelectedPersonID = -1;

        clsApplication Application;
        ClsLocalDrivingLicenseApplication _LocalDrivingLicenseApplication;
         
        public frmAddNewLocalLicenseApp()
        {
            InitializeComponent();
            Mode = enMode.AddNew;
        }

        public frmAddNewLocalLicenseApp(int LocalDrivingLicenseApplicationID)
        {
            InitializeComponent();

            _LocalDrivingLicenseApplicationID = LocalDrivingLicenseApplicationID;
            Mode = enMode.Update;
        }


        private void UpdateApplication()
        {

            ctrlPersonDetailsWithFilter1.EnableFilter = false;

            _LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(_LocalDrivingLicenseApplicationID);

            if(_LocalDrivingLicenseApplication == null)
            {
                MessageBox.Show("Application Was Not Found, Please Try Again", " Data Read Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            ctrlPersonDetailsWithFilter1.LoadPersonInfo(_LocalDrivingLicenseApplication._PersonID);
            lblApplicationID.Text = _LocalDrivingLicenseApplication.LocalDrivingLicenseApplicationID.ToString();
            lblApplicationDate.Text = _LocalDrivingLicenseApplication._ApplicationDate.ToString();
            cmbLicenseClass.SelectedIndex = cmbLicenseClass.FindString(clsLicenseClass.Find(_LocalDrivingLicenseApplication.LicenseClassID)._ClassName);
            lblApplicationFees.Text = _LocalDrivingLicenseApplication._PaidFees.ToString();
            lblUserID.Text = clsUsers.FindUser(_LocalDrivingLicenseApplication._UserID)._UserName;
            




        }

        private void ResetDefaultValue()
        {

            if(Mode == enMode.AddNew)
            {
               
                lblFormMode.Text = "New Local Driving License Application";
                this.Text = "New Local Driving License Application";
                _LocalDrivingLicenseApplication = new ClsLocalDrivingLicenseApplication();
                ctrlPersonDetailsWithFilter1.FilterFocus();
                tpApplicationInfo.Enabled = false;
                cmbLicenseClass.SelectedIndex = 2;
                lblApplicationFees.Text = clsApplicationTypes.FindApplicationType((int)clsApplication.enApplicationType.NewDrivingLicense)._ApplicationFees.ToString();
                lblApplicationDate.Text = DateTime.Now.ToString();
                lblUserID.Text = clsGlobalSettings.User._UserID.ToString();



            }
            else
            {
                lblFormMode.Text = "Update Local Driving License Application";
                this.Text = "Update Local Driving License Application";
                tpApplicationInfo.Enabled = true;
                btnSave.Enabled = true;
                
            }

        }
        private void frmAddNewLocalLicenseApp_Load(object sender, EventArgs e)
        {

            ResetDefaultValue();
            if (Mode == enMode.Update)
            {
                lblFormMode.Text = "Update Local Driving License Application";            
                UpdateApplication();
            }


        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            if(ctrlPersonDetailsWithFilter1.SelectedPersonInfo == null)
            {
                MessageBox.Show("Please Select a Person", "Select Person", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            tpApplicationInfo.Enabled = true;
            tabControl1.SelectedIndex = 1;
            btnSave.Enabled = true;


        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {

            int LicenseClassID = clsLicenseClass.Find(cmbLicenseClass.Text)._LicenseClassID;

            int ActiveApplicationID = clsApplication.GetActiveApplicationIDForLicenseClass(_SelectedPersonID, clsApplication.enApplicationType.NewDrivingLicense, LicenseClassID);

            if (ActiveApplicationID != -1)
            {
                MessageBox.Show("Choose Another License Class, The Selected Person Already Exist","Person Already Exist", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return;
            }

      


            /* Don't Forget To Add This Function
             
                if(clsLicense.IsLicenseExistByPersonID()
                 {
                    
                    bla bla bla bla
                 }
             
             */

            _LocalDrivingLicenseApplication._PersonID = ctrlPersonDetailsWithFilter1.PersonID;
            _LocalDrivingLicenseApplication._ApplicationDate = DateTime.Now;
            _LocalDrivingLicenseApplication._ApplicationTypeID = 1;
            _LocalDrivingLicenseApplication.applicationStatus = clsApplication.enApplicationStatus.New;
            _LocalDrivingLicenseApplication._LastStatusDate = DateTime.Now;
            Application._PaidFees = Convert.ToSingle(lblApplicationFees.Text);
            Application._UserID = clsGlobalSettings.User._UserID;
            _LocalDrivingLicenseApplication.LicenseClassID = LicenseClassID;

            
            
            if(_LocalDrivingLicenseApplication.Save())
            {

                lblApplicationID.Text = _LocalDrivingLicenseApplication.LocalDrivingLicenseApplicationID.ToString();
                lblFormMode.Text = "Update Local Driving License Application";
                Mode = enMode.Update;
                MessageBox.Show("Application Saved Successfully", "Application", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Application Save Failed", "Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                ResetDefaultValue();
            }



        }

        private void ctrlPersonDetailsWithFilter1_OnPesonSelected(int obj)
        {
            _SelectedPersonID = obj;
        }

        private void frmAddNewLocalLicenseApp_Activated(object sender, EventArgs e)
        {
            ctrlPersonDetailsWithFilter1.FilterFocus();
        }
    }
}
