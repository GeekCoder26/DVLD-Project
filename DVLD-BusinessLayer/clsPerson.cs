using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_BusinessLayer
{
    public class clsPerson
    {

        enum enmode { AddNEw = 1, Update = 2};
        enmode Mode;


        public int _PersonID;
        public string _FirstName {  get; set; }
        public string _SecondName { get; set; }
        public string _ThirdName { get; set; }
        public string _LastName { get; set; }
        public DateTime _DateOfBirth { get; set; }
        public bool _Gendor { get; set; }
        public string _Phone { get; set; }
        public string _Email { get; set; }
        public string _NationalNo { get; set; }

        public string _Country { get; set; }
        public string _Address { get; set; }
        public int _NationalityCountryID { get; set; }
        private string _ImagePath { get; set; }
        public string ImagePath
        {
            get { return _ImagePath;  }
            set { _ImagePath = value; }
        }

        public string FullName
        {
            get { return _FirstName + " " + _SecondName + " " + _ThirdName + " " + _LastName; }
        }

        public clsCountries CountryInfo;

        

        private static DataTable _data = new DataTable();


        private clsPerson( int PersonID, string FirstName, string SecondName, string ThirdName, string LastName,
                             DateTime DateOfBirth, bool Gendor, string Phone, string Email,  string NationalNo, string Address,
                                        int NationalityCountryID, string ImagePath)
        {
            this._PersonID = PersonID;
            this._FirstName = FirstName;
            this._SecondName = SecondName;
            this._ThirdName = ThirdName;
            this._LastName = LastName;
            this._DateOfBirth = DateOfBirth;
            this._Gendor = Gendor;
            this._Phone = Phone;
            this._Email = Email;
            //this._Country = Country;
            this._NationalNo = NationalNo;
            this._Address = Address;
            this._NationalityCountryID = NationalityCountryID;
            this.CountryInfo = clsCountries.Find(_NationalityCountryID);
            this.ImagePath = ImagePath;

            Mode = enmode.Update;

        }

        public clsPerson()
        {

            _PersonID = -1;
            _FirstName = "";
            _SecondName = "";
            _ThirdName = "";
            _LastName = "";
            _DateOfBirth = DateTime.Now;
            _Gendor = false;
            _Phone = "";
            _Email = "";
            _NationalNo = "";
            _Address = "";
            _NationalityCountryID = -1;
            ImagePath = "";

            Mode = enmode.AddNEw;


        }

        public static DataTable GetDataTable()
        {
            return _data;
        }

        public static DataTable GetAllPeople()
        {
            
            _data = clsPersonData.GetAllContacts();

            return _data;

        }

        private bool _AddNEwPerson()
        {
           
            this._PersonID = clsPersonData.AddNewPerson(
            this._FirstName, this._SecondName, this._ThirdName, this._LastName, this._DateOfBirth,
            this._Gendor, this._Phone, this._Email, this._NationalNo, this._Address, 
            this._NationalityCountryID, this.ImagePath);
            return (this._PersonID != -1);
        }
        private bool _UpdatePeson()
        {
            return clsPersonData.UpdatePerson(this._PersonID, this._FirstName, this._SecondName, this._ThirdName, this._LastName, 
                                                                     this._DateOfBirth,  this._Gendor, this._Phone,  this._Email, this._NationalNo,
                                                                     this._Address, this._NationalityCountryID,  this.ImagePath);
        }

        //public static DataTable FindPeson(string ColumnName, string Content)
        //{
        //    return clsPersonData.FindPerson(ColumnName, Content);
        //}

        public int GetPersonID()
        {
            return this._PersonID; 
        }

        public static bool DeletePerson(int PersonID)
        {
            return clsPersonData.DeletePerson(PersonID);
        }

        public static clsPerson FindPerson(int PersonID)
        {
            string FirstName = "", SecondName = "", ThirdName = "", LastName = "", Phone = "", Email = "", NationalNo = "", Address = "",
               ImagePath = "" ;
            DateTime DateOfBirth = DateTime.Now;
            bool Gendor = true;
            int NationalityCountryID = 0;

            if (clsPersonData.FindPerson(PersonID, ref FirstName, ref SecondName, ref ThirdName, ref LastName, ref DateOfBirth,
                ref Gendor, ref Phone, ref Email, ref NationalNo, ref Address, ref NationalityCountryID, ref ImagePath))
            {
                return new clsPerson(PersonID, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Phone, Email, NationalNo,
                                         Address, NationalityCountryID, ImagePath);
            }
            else
            {
                return null;
            }

        }

        public static clsPerson FindPerson(string NationalNo)
        {
            int PersonID = 0;
            string FirstName = "", SecondName = "", ThirdName = "", LastName = "", Phone = "", Email = "",  Address = "",
                ImagePath = "";
            DateTime DateOfBirth = DateTime.Now;
            bool Gendor = true;
            int NationalityCountryID = 0;

            if (clsPersonData.FindPerson(NationalNo, ref PersonID, ref FirstName, ref SecondName, ref ThirdName, ref LastName, ref DateOfBirth,
                ref Gendor, ref Phone, ref Email, ref Address, ref NationalityCountryID, ref ImagePath))
            {
                return new clsPerson(PersonID, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Phone, Email, NationalNo,
                                         Address, NationalityCountryID, ImagePath);
            }
            else
            {
                return null;
            }

        }
        public bool Save()
        {
            

            switch(Mode)
            {
                case enmode.AddNEw:

                    if (_AddNEwPerson())
                    {
                        Mode = enmode.Update;
                        
                        return true;
                    }
                    else
                        return false;
                         
                case enmode.Update:
                   
                   return _UpdatePeson();
                    

            }
            return false;
        }

        public static bool IsPersonExist(int PersonID)
        {
            return clsPersonData.IsPersonExist(PersonID);
        }
        public static bool IsPersonExist(string NationalNo)
        {
            return clsPersonData.IsPersonExist(NationalNo);
        }
      




    }
}
