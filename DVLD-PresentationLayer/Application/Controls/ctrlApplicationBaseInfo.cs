using DVLD_BusinessLayer;
using DVLD_PresentationLayer.People;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Application.Controls
{
    public partial class ctrlApplicationBaseInfo : UserControl
    {

        private int _ApplicationID = -1;

        private clsApplication _Application;

        public int ApplicationID
        {
            get { return _ApplicationID; }
        }

        public ctrlApplicationBaseInfo()
        {
            InitializeComponent();
        }

        public void LoadApplicationInfo(int ApplicationID)
        {
            _Application = clsApplication.FindApplication(ApplicationID);

            if (_Application == null)
            {
                ResetApplicationInfo();
                MessageBox.Show("No Application with ApplicationID = " + ApplicationID.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            _FillApplicationInfo();


        }

        public void _FillApplicationInfo()
        {
            _ApplicationID = _Application._ApplicationID;
            lblApplicationID.Text = _ApplicationID.ToString();
            lblStatus.Text = _Application.StatusText;
            lblApplicationFees.Text = _Application._PaidFees.ToString();
            lblType.Text = _Application.ApplicationTypeInfo._ApplicationTitle;
            lblApplicant.Text = _Application.ApplicantFullName;
            lblDate.Text = _Application._ApplicationDate.ToString("dd/MM/yyyy");
            lblStatusDate.Text = _Application._LastStatusDate.ToString("dd/MM/yyyy");
            lblUser.Text = _Application.UserInfo._UserName;
        }

        public void ResetApplicationInfo()
        {
            _ApplicationID = -1;

            lblApplicationID.Text = "[???]";
            lblStatus.Text = "[???]";
            lblApplicationFees.Text = "[$$$]";
            lblType.Text = "[???]";
            lblApplicant.Text = "[???]";
            lblDate.Text = "[??/??/????]";
            lblStatusDate.Text = "[??/??/????]";
            lblUser.Text = "[???]";

        }

        private void linkPersonInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Form frm = new frmShowPersonDetails(_Application._PersonID);

            frm.ShowDialog();

            LoadApplicationInfo(_ApplicationID);
        }





    }

}
