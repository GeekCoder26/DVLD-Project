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
using DVLD_PresentationLayer;
using DVLD_BusinessLayer;

namespace DVLD_PresentationLayer
{
    public partial class DefaultUserControl1 : UserControl
    {


        public event Action<int> OnPersonAdded;

        protected virtual void PersonAdded(int PersonID)
        {
            Action<int> handler = OnPersonAdded;
            if(handler != null)
            {
                handler(PersonID);
            }
        }

        public DefaultUserControl1()
        {
            InitializeComponent();
        }


        public int PersonID = 0;
        public string FirstName;
        public string SecondName;
        public string ThirdName;
        public string LastName;
        public string NationalNo;
        public DateTime DateOfBirth;
        public bool Gender; // true -->> female , false -->> male
        public string Country;
        public string Phone;
        public string Email;
        public string Address;
        public int NationalCountryID;
        public string ImagePath;



        private void DefaultUserControl1_Load(object sender, EventArgs e)
        {
            cbCountry.SelectedItem = "Algeria";
            
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            clsPerson NewPerson = new clsPerson();

            
            NewPerson._FirstName = txbFirstName.Text;
            NewPerson._SecondName = txbSecondName.Text;
            NewPerson._ThirdName = txbThirdName.Text;
            NewPerson._LastName = txbFourthName.Text;
            NewPerson._NationalNo = txbNationalNo.Text;
            NewPerson._DateOfBirth = dtpDateOfBirth.Value;
            if(rbFemale.Checked == true)
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
            NewPerson._NationalityCountryID = cbCountry.SelectedIndex;
            NewPerson.ImagePath = "";


            //Form frm = new Add_Edit_Form(ref PersonID, FirstName, SecondName, ThirdName, LastName, NationalNo, DateOfBirth, Gender,
            //        Phone, Email, Country, Address, NationalCountryID, ImagePath);
            
            
            if(OnPersonAdded != null)
            {
                PersonAdded(PersonID);
            }


        }
    }
}
