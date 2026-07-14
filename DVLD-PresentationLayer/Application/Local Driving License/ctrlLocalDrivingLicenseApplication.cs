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
    public partial class ctrlLocalDrivingLicenseApplication : UserControl
    {

        private ClsLocalDrivingLicenseApplication _LocalDrivingLicenseApplication;

        private int _LocalDrivingLicenseApplicationID = -1;

        private int LicenseID = -1;

        public int LocalDrivingLicenseApplicationID
        {
            get { return _LocalDrivingLicenseApplicationID; }
        }

        public ctrlLocalDrivingLicenseApplication()
        {
            InitializeComponent();
        }


        public void ResetLocalDrivingLicenseInfo()
        {
            lblDrivingLicenseAppID.Text = "N/A";
            lblAppliedForLicense.Text = "N/A";
            lblPassedTests.Text = "0";

            ctrlApplicationBaseInfo1.ResetApplicationInfo();
        }
        public void LoadApplicationINfoByLocalDrivingID(int LocalDrivingLicenseID)
        {
            _LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(LocalDrivingLicenseID);

            if( _LocalDrivingLicenseApplication == null )
            {
                ResetLocalDrivingLicenseInfo();

                MessageBox.Show("Application with AppID: " + LocalDrivingLicenseApplicationID + "Does Not Found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillLocalDrivingLicenseApplicationInfo();


        }

        public void LoadApplicationINfoByApplicationID(int ApplicationID)
        {
            _LocalDrivingLicenseApplication = ClsLocalDrivingLicenseApplication.FindByLocalDrivingApplication(ApplicationID);

            if (_LocalDrivingLicenseApplication == null)
            {
                ResetLocalDrivingLicenseInfo();

                MessageBox.Show("Application with AppID: " + LocalDrivingLicenseApplicationID + "Does Not Found", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillLocalDrivingLicenseApplicationInfo();


        }


        private void _FillLocalDrivingLicenseApplicationInfo()
        {
            LicenseID = _LocalDrivingLicenseApplication.GetActiveLicenseID();

            linkLicenseInfo.Enabled = (LicenseID != -1);

            lblDrivingLicenseAppID.Text = _LocalDrivingLicenseApplication.LocalDrivingLicenseApplicationID.ToString();

            lblAppliedForLicense.Text = clsLicenseClass.Find(_LocalDrivingLicenseApplication.LicenseClassID).ToString();

            lblPassedTests.Text = "0";

            ctrlApplicationBaseInfo1.LoadApplicationInfo(_LocalDrivingLicenseApplication._ApplicationID);


        }


    }
}
