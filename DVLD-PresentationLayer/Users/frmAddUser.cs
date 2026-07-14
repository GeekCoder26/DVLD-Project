using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Default_Controls_For_All_project;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.VisualStyles;

namespace DVLD_PresentationLayer.Users
{
    public partial class frmAddUser : Form
    {

        enum enMode { AddNew, Update};
        enMode Mode;

        int _UserID;
        int _PersonID;

        bool IsPersonExist = false;

        clsUsers NewUser;
        public frmAddUser(int UserID, int PersonID)
        {
            InitializeComponent();
            _PersonID = PersonID;
            _UserID = UserID;
            Mode = enMode.Update;
        }

        public frmAddUser()
        {
            InitializeComponent();
            Mode = enMode.AddNew;
        }

        private void ResetDefaultValue()
        {
            if (Mode == enMode.AddNew)
            {
                lblAddNew.Text = "Add New User";
                NewUser = new clsUsers();
            }
            else
            {
                lblAddNew.Text = "Update User";
            }

            lblUserID.Text = "????";
            txbUsername.Text = "";
            txbPassword.Text = "";
            txbConfirmPassword.Text = "";
            btnSave.Enabled = false;
            tabPage2.Enabled = false;

        }

        private void ChangetoUpdateMode(int UserID)
        {
            Mode = enMode.Update;
            lblAddNew.Text = "Update User";
            _UserID = UserID;
            lblUserID.Text = _UserID.ToString();

        }
        private void UpdateUser()
        {
            NewUser = clsUsers.FindUser(_UserID);

            if (NewUser == null)
            {
                this.Close();
                return;
            }

            ctrlPersonDetailsWithFilter1.LoadPersonInfo(_PersonID);
            lblUserID.Text = NewUser.PersonID.ToString();
            txbUsername.Text = NewUser._UserName;
            txbPassword.Text = NewUser._Password;
            txbConfirmPassword.Text = NewUser._Password;
            ckbIsActive.Checked = NewUser._IsActive;

            ChangetoUpdateMode(_UserID);
        }

        private void frmAddUser_Load(object sender, EventArgs e)
        {
            ResetDefaultValue();

            if(Mode == enMode.Update)
            {
                ctrlPersonDetailsWithFilter1.EnableFilter = false;
                UpdateUser();
            }

        }

        private void btnNext_Click(object sender, EventArgs e)
        {
           if(ctrlPersonDetailsWithFilter1.SelectedPersonInfo == null)
            {
                MessageBox.Show("Please select A Person", "Select Person", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (IsPersonExist == true)
            {
                MessageBox.Show("Selected Person Already Has A User, choose Another one", "Select Another Person", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                IsPersonExist = false;
                return;
            }

            tabPage2.Enabled = true;
            tabControl1.SelectedTab = tabPage2;
            btnSave.Enabled = true; 

            

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if(!this.ValidateChildren())
            {
                return;
            }
            NewUser.PersonID = ctrlPersonDetailsWithFilter1.PersonID;
            NewUser._UserName = txbUsername.Text;
            NewUser._Password = txbPassword.Text;
            NewUser._IsActive = ckbIsActive.Checked;

            if(NewUser.Save())
            {
                MessageBox.Show("User Saved Successfully", "Save", MessageBoxButtons.OK, MessageBoxIcon.Information);
                ChangetoUpdateMode(NewUser._UserID);
            }
            else
            {
                MessageBox.Show("User Save Failed, Please Try again", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void ctrlPersonDetailsWithFilter1_OnPesonSelected(int obj)
        {
            if(clsUsers.IsUSerExistByPersonID(obj))
            {
                IsPersonExist = true;
            }
           
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
            
        }

    

        private void txbUsername_KeyPress(object sender, KeyPressEventArgs e)
        {
            
        }

        private void txbUsername_Validating(object sender, CancelEventArgs e)
        {
            Control Current = (Control)sender;
            if (string.IsNullOrEmpty(txbUsername.Text))
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Field Is required");
                return;
            }
            else if (clsUsers.IsUserExist(txbUsername.Text) && txbUsername.Text != NewUser._UserName)
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Username is Used for another user");

                
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
                errorProvider1.SetError(Current, "This Field Is required");
               
            }
            else if(!txbPassword.Text.Equals(txbConfirmPassword.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "Please Enter a Same Password");

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
            if (string.IsNullOrEmpty(txbPassword.Text))
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Field Is required");

            }
            else if (!txbConfirmPassword.Text.Equals(txbPassword.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(Current, "Please Enter a Same Password");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
            }
        }
    }
}
