using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Application.Local_Driving_License;
using DVLD_PresentationLayer.ApplicationTypes;
using DVLD_PresentationLayer.Global_Classes;
using DVLD_PresentationLayer.Login;
using DVLD_PresentationLayer.Tests.Manage_Test_Types;
using DVLD_PresentationLayer.Users;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer
{
    public partial class frmMain : Form
    {

        clsUsers CurrentUser = new clsUsers();
        frmUserLogin _login;
       // clsGlobalSettings globalUser = new clsGlobalSettings();
        public frmMain(frmUserLogin login)
        {
            InitializeComponent();
            _login = login;
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            msItems.BackColor = Color.FromArgb(240, 245, 255);
        }

        private void peopleMenu_Click(object sender, EventArgs e)
        {
            Form frm = new frmListPeople();
            frm.ShowDialog();
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void usersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form frm = new frmManageUsers();
            frm.ShowDialog();
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            CurrentUser = clsUsers.FindUser(clsGlobalSettings.User._UserName);

            Form frm = new frmShowDetails(CurrentUser._UserID, CurrentUser.PersonID);
            frm.ShowDialog();
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            CurrentUser = clsUsers.FindUser(clsGlobalSettings.User._UserName);

            Form frm = new frmChangePassword(CurrentUser._UserID, CurrentUser.PersonID);
            frm.ShowDialog();
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {

            _login.Show();
            this.Close();

        }


        private void frmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
        }

        private void applicationTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void toolStripMenuItem4_Click(object sender, EventArgs e)
        {
            Form frm = new frmApplicationTypes();
            frm.ShowDialog();
        }

        private void manageTestTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form frm = new frmManageTestTypes();
            frm.ShowDialog();
        }

        private void msItems_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void localLicenseToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form frm = new frmAddNewLocalLicenseApp();
            frm.ShowDialog();
        }
    }
}
