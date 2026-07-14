using DVLD_BusinessLayer;
using DVLD_PresentationLayer.People;
using DVLD_PresentationLayer.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Default_Controls_For_All_project
{
    public partial class ctrlPersonDetails : UserControl
    {


        private static clsPerson PersonInfo;

        private  int _PersonID = -1;

        public  int PersonID
        {
            get { return _PersonID; }
        }

        public  clsPerson SelectPersonInfo
        {
            get { return PersonInfo; }
        }
        public ctrlPersonDetails()
        {
            InitializeComponent();
        }

    

        public  void LoadPersonInfo(string NationalNo)
        {
            PersonInfo = clsPerson.FindPerson(NationalNo);
            if (PersonInfo == null)
            {
                ResetPersonInfo();
                MessageBox.Show("No Person Exist With National No " + NationalNo, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;

            }

            PersonLoadData();
        }

        public  void LoadPersonInfo(int PersonID)
        {
            PersonInfo = clsPerson.FindPerson(PersonID);
            if (PersonInfo == null)
            {
                ResetPersonInfo();
                MessageBox.Show("No Person Exist With Person ID " + PersonID.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;

            }

            PersonLoadData();
        }

        private  void ResetPersonInfo()
        {
            _PersonID = -1;
            lblPersonID.Text = "N/A";
            lblName.Text = "N/A";
            lblNationalNo.Text = "N/A";
            lblGender.Text = "N/A";
            pbGenderImage.Image = Resources.Man_321;
            lblEmail.Text = "N/A";
            lblAddress.Text = "N/A";
            lblDateOfBirth.Text = "N/A";
            lblPhone.Text = "N/A";
            lblCountry.Text = "N/A";
            pbPersonalPicture.Image = Resources.Male_512;



        }

        private  void SetPersonPicture()
        {


            if (lblGender.Text == "Male")
                pbPersonalPicture.Image = Resources.Male_512;
            else
                pbPersonalPicture.Image = Resources.Female_512;



            if (PersonInfo.ImagePath != null)
            {
                if(File.Exists(PersonInfo.ImagePath))
                {
                    pbPersonalPicture.ImageLocation = PersonInfo.ImagePath;
                }
                else
                {
                    MessageBox.Show("Could Not Find This Image = " +  PersonInfo.ImagePath, "Image Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                }
            }
        }

        public  void PersonLoadData()
        {

            linkEditPerson.Enabled = true;
            _PersonID = PersonInfo.GetPersonID();
            lblPersonID.Text = _PersonID.ToString();
            lblName.Text = PersonInfo.FullName;
            lblNationalNo.Text = PersonInfo._NationalNo;
            if (PersonInfo._Gendor == false)
            { 
                lblGender.Text = "Male";
                pbGenderImage.Image = Resources.Man_321;
            }
            else
            { 
                lblGender.Text = "Female";
                pbGenderImage.Image = Resources.Woman_321;
            }
            lblEmail.Text = PersonInfo._Email;
            lblAddress.Text = PersonInfo._Address;
            lblDateOfBirth.Text = PersonInfo._DateOfBirth.ToString();
            lblPhone.Text = PersonInfo._Phone;
            lblCountry.Text = clsCountries.Find(PersonInfo._NationalityCountryID)._CountryName;

            SetPersonPicture();
        }

        private void linkEditPerson_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Add_Edit_Form frm = new Add_Edit_Form(_PersonID);
            frm.ShowDialog();

            //Refresh
            LoadPersonInfo(_PersonID);
        }
    }
}
