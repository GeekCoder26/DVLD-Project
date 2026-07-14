using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Global_Classes;
using System;
using System.CodeDom;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Users
{
    public partial class frmChangePassword : Form
    {


        clsUsers UserInfo = new clsUsers();
        int _UserID, _PersonID;
        
        public frmChangePassword(int UserID, int PersonID)
        {
            InitializeComponent();

            _UserID = UserID;
            _PersonID = PersonID;

        }

        private void ResetDefaultPassword()
        {
            txbCurrentPassword.Text = "";
            txbNewPassword.Text = "";
            txbConfirmPassword.Text = "";
            txbCurrentPassword.Focus();
        }
        private void txbCurrentPassword_Validating(object sender, CancelEventArgs e)
        {

            Control Current = (Control)sender;

            if(txbCurrentPassword.Text == "")
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "This field is required");
                
            } 
            else if(txbCurrentPassword.Text != UserInfo._Password )
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "Current Password is Not Correct");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }
        }

        private void txbNewPassword_Validating(object sender, CancelEventArgs e)
        {

            Control Current = (Control)sender;
            if(string.IsNullOrEmpty(txbNewPassword.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "This field is required");
            }
            else if(txbNewPassword.Text != txbConfirmPassword.Text)
            {
                //e.Cancel = true;
                errorProvider1.SetError(Current, "Please enter the same password");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }
        }

        private void txbConfirmPassword_Validating(object sender, CancelEventArgs e)
        {
            Control Current = (Control)sender;
            if (string.IsNullOrEmpty(txbConfirmPassword.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "This field is required");
            }
            else if (txbNewPassword.Text != txbConfirmPassword.Text)
            {
                e.Cancel = true;
                
                errorProvider1.SetError(Current, "Please enter the same password");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }

        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if(!this.ValidateChildren())
            {
                MessageBox.Show("there are some empty field", "Error Validation Children", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }


            UserInfo._Password = txbNewPassword.Text;

            if (UserInfo.Save())
            {
                MessageBox.Show("Password Updated Successfully", "Update Password", MessageBoxButtons.OK, MessageBoxIcon.Information);
                ResetDefaultPassword();

            }
            else
            {
                MessageBox.Show("Password Udpate failed", "Update Password", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }


        }

        private void frmChangePassword_Load(object sender, EventArgs e)
        {
            ResetDefaultPassword();

            UserInfo = clsUsers.FindUser(_UserID);

            if (UserInfo == null)
            {
                MessageBox.Show("Could not Find User with id = " + _UserID, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                this.Close();
                return;
            }

            ctrlUserCard1.LoadUserInfo(_UserID, _PersonID);
        }
    }
}
