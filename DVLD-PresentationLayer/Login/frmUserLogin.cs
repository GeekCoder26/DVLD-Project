using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Global_Classes;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace DVLD_PresentationLayer.Login
{
    public partial class frmUserLogin : Form
    {


        clsUsers CurrentUser;

        clsGlobalSettings GlobalCurrentUser = new clsGlobalSettings();
        public frmUserLogin()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();

        }

        private bool IsUserExist()
        {
            CurrentUser = clsUsers.FindUser(txbUsername.Text);

            return (CurrentUser != null);
        }

        private bool CheckPassword()
        {
            if (CurrentUser._Password != txbPassword.Text)
                return false;

            return true;
        }

        private bool IsActive()
        {
            if(CurrentUser._IsActive)
            {
                return true;
            }

            return false;
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(txbUsername.Text) || string.IsNullOrEmpty(txbPassword.Text))
            {
                return;
            }

            if(!IsUserExist())
            {
                MessageBox.Show("This User Does Not Exist, Please Enter a valid user", "User Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if(!CheckPassword())
            {
                MessageBox.Show("Invalid Username/Password ", "Invalid Info", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if(!IsActive())
            {
                MessageBox.Show("your account is deactivated, Please contact your admin", "Account Deactivated", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            
           
            clsGlobalSettings.User = CurrentUser;

            if(ckbRemeberMe.Checked)
            {
                clsUtil.SaveLoginInfoToTXT(txbUsername.Text.Trim(), txbPassword.Text.Trim());
            }
            else
            {
                clsUtil.DeleteOldDataFromTXT();
            }

            this.Hide();

            frmMain frm = new frmMain(this);
            frm.ShowDialog();

            //this.Close();






        }

        private void txbUsername_Validating(object sender, CancelEventArgs e)
        {
            Control Current = (Control)sender;
            if (string.IsNullOrEmpty(txbUsername.Text))
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Field is required");


            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }

        }

        private void txbPassword_Validating(object sender, CancelEventArgs e)
        {
            Control Current = (Control)sender;
            if (string.IsNullOrEmpty(txbPassword.Text))
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Field is required");


            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }
        }

        private void ckbRemeberMe_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void FillLoginInfo()
        {
            txbUsername.Text = clsGlobalSettings.User._UserName;
            txbPassword.Text = clsGlobalSettings.User._Password;

            ckbRemeberMe.Checked = true;
        }
        private void frmUserLogin_Load(object sender, EventArgs e)
        {
            string Username = "", Password = "";
            if (clsUtil.GetLoginDataIfExist(ref Username, ref Password))
            {
                clsGlobalSettings.User._UserName = Username;
                clsGlobalSettings.User._Password = Password;

                FillLoginInfo();
            }
        }

        private void frmUserLogin_FormClosed(object sender, FormClosedEventArgs e)
        {
            
        }
    }
}
