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
using DVLD_BusinessLayer;
using System.Security.Cryptography;
using DVLD_PresentationLayer.Properties;
using System.IO;
using DVLD_PresentationLayer.Global_Classes;

namespace DVLD_PresentationLayer.People
{
    public partial class Add_Edit_Form : Form
    {

        private enum enMode { AddNew, Update};
        enMode Mode = enMode.AddNew;

        public delegate void DataBackEvenHandler(object sender, int PesonID);

        public event DataBackEvenHandler DataBack;

        private int _PersonID;

        clsPerson NewPerson = new clsPerson();

        public Add_Edit_Form()
        {
            InitializeComponent();
            Mode = enMode.AddNew;

        }
        public Add_Edit_Form(int PersonID)
        {

            InitializeComponent();
            Mode = enMode.Update;
            _PersonID = PersonID;
            

  
        }


        /*-----------------------------------------------------------------------------------------------------------------------------------*/
       
        private void _FillCountriesInComboBox()
        {

            DataTable dtCountries = clsCountries.GetAllCountries();

            foreach (DataRow Row in dtCountries.Rows)
            {
                cbCountry.Items.Add(Row["CountryName"]);
            }


        }
        public void ResetDefaultValues()
        {
            _FillCountriesInComboBox();

            if(Mode == enMode.AddNew)
            {
                lblFormType.Text = "Add New Person";
                NewPerson = new clsPerson();
            }
            else
            {
                lblFormType.Text = "Update Person";

            }


            if (rbMale.Checked)
                pbPersonalImage.Image = Resources.Male_512;
            else
                pbPersonalImage.Image = Resources.Female_512;

            linkRemove.Visible = (pbPersonalImage.ImageLocation != null);

            dtpDateOfBirth.MaxDate = DateTime.Now.AddYears(-18);
            dtpDateOfBirth.Value = dtpDateOfBirth.MaxDate;

            dtpDateOfBirth.MinDate = DateTime.Now.AddYears(-100);

            cbCountry.SelectedIndex = cbCountry.FindString("Algeria");

            txbFirstName.Text = "";
            txbSecondName.Text = "";
            txbThirdName.Text = "";
            txbFourthName.Text = "";
            txbNationalNo.Text = "";
            rbMale.Checked = true;
            txbEmail.Text = "";
            txbPhone.Text = "";
            txbAddress.Text = "";



        }
        private void Add_Edit_Form_Load(object sender, EventArgs e)
        {
            ResetDefaultValues();


            if (Mode == enMode.Update)
            {
                UpdatePerson();
            }


        }
        private void rbMale_CheckedChanged(object sender, EventArgs e)
        {
            if(pbPersonalImage.ImageLocation == null)
            {
                pbPersonalImage.Image = Resources.Male_512;
            }
        }
        private void rbFemale_CheckedChanged(object sender, EventArgs e)
        {
            if (pbPersonalImage.ImageLocation == null)
                pbPersonalImage.Image = Resources.Female_512;
        }
        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
            frmListPeople frm = new frmListPeople();

        }
        public bool IsNationalNoExist(string NationalNo)
        {

            DataTable dt = clsPerson.GetDataTable();

            foreach (DataRow rows in dt.Rows)
            {

                while (rows[1].ToString() == NationalNo)
                {
                    return true;
                }

            }
            return false;

            
        }
        private void txbNationalNo_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrWhiteSpace(txbNationalNo.Text))
            {
                e.Cancel = true;
                txbNationalNo.Focus();
                errorProvider1.SetError(txbNationalNo, "This Field Is Required");
 
            }
            else if (IsNationalNoExist(txbNationalNo.Text) && txbNationalNo.Text != NewPerson._NationalNo)
            {
                e.Cancel = true;
                txbNationalNo.Focus();
                errorProvider1.SetError(txbNationalNo, "National Number Is Used For Another Person");
               
            }
            else
            {
                errorProvider1.SetError(txbNationalNo, "");
              
            }
        }
        private void txbAddress_Validating(object sender, CancelEventArgs e)
        {
            SetErrorProvider((Control)sender, e);
        }
        private void txbEmail_Validating(object sender, CancelEventArgs e)
        {

            if (string.IsNullOrEmpty(txbEmail.Text))
                return;
                
            if(!clsValidation.ValidateEmail(txbEmail.Text))
            {
                e.Cancel = true;
                txbEmail.Focus();
                errorProvider1.SetError(txbEmail, "Please Enter A Valid Email Format");
               
            }
            else
            {
                errorProvider1.SetError(txbEmail, "");
             
            }

                
        }
        private void linkSetImage_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            openFileDialog1.DefaultExt = "txt";
            openFileDialog1.Filter = "Image File|*.jpg;*.jpeg;*.png;*.gif;*.bmp";
            openFileDialog1.FilterIndex = 1;
            openFileDialog1.RestoreDirectory = true;

            if(openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                string SelectedPath = openFileDialog1.FileName;
                pbPersonalImage.Load(SelectedPath);
                linkRemove.Visible = true;
                pbPersonalImage.Enabled = true;
            }


        }
        private void linkRemove_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            if (rbFemale.Checked)
            {
                pbPersonalImage.Image = Resources.Female_512;
            }
            else
            {
                pbPersonalImage.Image = Resources.Male_512;
            }
            linkRemove.Visible = false;
            pbPersonalImage.Enabled = false;

        }
        private void SetErrorProvider(Control Current, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(Current.Text))
            {
                e.Cancel = true;
                Current.Focus();
                errorProvider1.SetError(Current, "This Field Is Required");
    
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(Current, "");
                
            }
        }

        private void txbFirstName_Validating(object sender, CancelEventArgs e)
        {
            SetErrorProvider((Control)sender, e);
        }
        private void txbSecondName_Validating(object sender, CancelEventArgs e)
        {
            SetErrorProvider((Control)sender, e);
        }
        private void txbFourthName_Validating(object sender, CancelEventArgs e)
        {
            SetErrorProvider((Control)sender, e);
        }
        public void UpdatePerson()
        {
            //frmListPeople frm = new frmListPeople();
            

            NewPerson = clsPerson.FindPerson(_PersonID);

            if (NewPerson == null)
            {
                MessageBox.Show("Empty Object, Please try again", "Empty Object", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            txbFirstName.Text = NewPerson._FirstName;
            txbSecondName.Text = NewPerson._SecondName;
            txbThirdName.Text = NewPerson._ThirdName;
            txbFourthName.Text = NewPerson._LastName;
            txbNationalNo.Text = NewPerson._NationalNo;
            dtpDateOfBirth.Value = NewPerson._DateOfBirth;

            if (NewPerson._Gendor == true)
                rbFemale.Checked = true;
            else
                rbMale.Checked = true;

            cbCountry.SelectedIndex = NewPerson._NationalityCountryID;
            txbPhone.Text = NewPerson._Phone;
            txbEmail.Text = NewPerson._Email;
            txbAddress.Text = NewPerson._Address;

            if (NewPerson.ImagePath != "")
                pbPersonalImage.ImageLocation = NewPerson.ImagePath;

            linkRemove.Visible = (NewPerson.ImagePath != "");

            ChangeToUpdateMode(_PersonID);

        }
        public void ChangeToUpdateMode(int PersonID)
        {
            _PersonID = PersonID;
            label2.Text = _PersonID.ToString();
            lblFormType.Text = "Update Person";
        }

        private bool _HandlePersonImage()
        {
            if(NewPerson.ImagePath != pbPersonalImage.ImageLocation)
            {
                if(NewPerson.ImagePath != "")
                {
                    try
                    {
                        File.Delete(NewPerson.ImagePath);
                    }
                    catch(IOException)
                    {
                        // ....
                    }
                }

                if(pbPersonalImage.ImageLocation != null)
                {
                    string SourceImageFile = pbPersonalImage.ImageLocation.ToString();
                    if(clsUtil.CopyImageToProjectImageFolder(ref SourceImageFile))
                    {
                        pbPersonalImage.ImageLocation = SourceImageFile;
                        return true;
                    }
                    else
                    {
                        MessageBox.Show("Error Copying Image File Name", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    }




                }


            }
            return true;
        }
        private void btnSave_Click(object sender, EventArgs e)
        {

            if(!this.ValidateChildren())
            {
                return;
            }

            if (!_HandlePersonImage())
                return;

            int NationalityCountryID = clsCountries.Find(cbCountry.Text)._CountryID;

            NewPerson._FirstName = txbFirstName.Text;
            NewPerson._SecondName = txbSecondName.Text;
            NewPerson._ThirdName = txbThirdName.Text;
            NewPerson._LastName = txbFourthName.Text;
            NewPerson._NationalNo = txbNationalNo.Text;
            NewPerson._DateOfBirth = dtpDateOfBirth.Value;
            if (rbFemale.Checked == true)
            {
               NewPerson._Gendor = true;
            }
            else
            {
              NewPerson._Gendor = false;
            }
            NewPerson._Country = cbCountry.Text;
            NewPerson._Phone = txbPhone.Text;
            NewPerson._Email = txbEmail.Text;
            NewPerson._Address = txbAddress.Text;
            NewPerson._NationalityCountryID = NationalityCountryID;
            if (pbPersonalImage.ImageLocation == null)
            {
                NewPerson.ImagePath = "";
            }
            else
            {
                NewPerson.ImagePath = pbPersonalImage.ImageLocation.ToString();
            }

            //if (OnPersonAdded != null)
            //{
            //    PersonAdded(NewPerson.GetPersonID());
            //}


            if (NewPerson.Save())
            {
                _PersonID = NewPerson.GetPersonID();
                label2.Text = _PersonID.ToString();
                lblFormType.Text = "Update Person";
                Mode = enMode.Update;
                MessageBox.Show("Data Saved Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Data Save Failed", "Save Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            DataBack?.Invoke(this, NewPerson._PersonID);

           // SavePictureToFile();
        }
    }
}
