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

namespace DVLD_PresentationLayer.Default_Controls_For_All_project
{
    public partial class ctrlUserCard : UserControl
    {

        private clsUsers UserInfo;
        private clsPerson PersonInfo;

        private int _UserID = -1;

        public int UserdID
        {
            get { return _UserID; }
        }

        public clsUsers SelectUserInfo
        {
            get { return UserInfo; }
        }

        public ctrlUserCard()
        {
            InitializeComponent();
        }

        private void ctrlPersonDetails1_Load(object sender, EventArgs e)
        {

        }

        private void ResetUserInfo()
        {
            lblUserID.Text = "-1";
            lblUsername.Text = "";
            lblIsActive.Text = "";
        }
        public void LoadUserInfo(string Username, string NationalNo)
        {
            UserInfo = clsUsers.FindUser(Username);

           
            if (UserInfo == null)
            {
                ResetUserInfo();
                MessageBox.Show($"User With Username {Username} Does Not Exist." , "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            LoadUserData();

        }

        public void LoadUserInfo(int PersonID)
        {
            UserInfo = clsUsers.FindUserByPersonID(PersonID);

            if(PersonID != -1)
            {
                 ctrlPersonDetails1.LoadPersonInfo(PersonID);
            }

            if (UserInfo == null)
            {
                ResetUserInfo();
                MessageBox.Show($"User With Username {UserInfo._UserName} Does Not Exist.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            LoadUserData();
        }

        private void LoadUserData()
        {
            lblUserID.Text = UserInfo._UserID.ToString();
            lblUsername.Text = UserInfo._UserName;

            if (UserInfo._IsActive == true)
                lblIsActive.Text = "Yes";
            else
                lblIsActive.Text = "No";
        }
    }
}
