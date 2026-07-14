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
    public partial class frmLocalDrivingLicenseApplication : Form
    {

        private int _ApplicationID = -1;
        public frmLocalDrivingLicenseApplication(int ApplicationID)
        {
            InitializeComponent();

            _ApplicationID = ApplicationID;
        }

        private void frmLocalDrivingLicenseApplication_Load(object sender, EventArgs e)
        {
            ctrlLocalDrivingLicenseApplication1.LoadApplicationINfoByLocalDrivingID(_ApplicationID);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
