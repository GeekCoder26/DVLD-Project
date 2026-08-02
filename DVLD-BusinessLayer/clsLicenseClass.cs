using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_BusinessLayer
{
    public class clsLicenseClass
    {
        public int _LicenseClassID {  get; set; }
        public string _ClassName { get; set; }
        public string _ClassDescription { get; set; }
        public byte _MinimumAllowedAge { get; set; }
        public byte _DefaultValidityLength { get; set; }
        public decimal _ClassFees { get; set; }

        enum enMode { AddNew, Update};
        enMode Mode = enMode.AddNew;
        private clsLicenseClass(int LicenseClassID, string ClassName, string ClassDescription, byte MinimumAllowedAge, byte DefaultValidityLength, decimal ClassFees)
        {

            _LicenseClassID = LicenseClassID;

            _ClassName = ClassName;

            _ClassDescription = ClassDescription;

            _MinimumAllowedAge = MinimumAllowedAge;

            _DefaultValidityLength = DefaultValidityLength;

            _ClassFees = ClassFees;

        }

        public static clsLicenseClass Find(int LicenseID)
        {
            string ClassName = "", ClassDescription = "";
            byte MinimumAllowedAge = 0, DefaultValidityLength = 0;
            decimal ClassFees = 0;

            if(clsLicenseClassesData.Find(LicenseID, ref ClassName, ref ClassDescription, ref MinimumAllowedAge, ref DefaultValidityLength, ref ClassFees))
            {
                return new clsLicenseClass(LicenseID, ClassName, ClassDescription, MinimumAllowedAge, DefaultValidityLength, ClassFees);
            }
            else
            {
                return null;
            }


        }

        public static clsLicenseClass Find(string ClassName)
        {
            int LicenseClassID = -1;
            string ClassDescription = "";
            byte MinimumAllowedAge = 0, DefaultValidityLength = 0;
            decimal ClassFees = 0;

            if (clsLicenseClassesData.Find(ClassName, ref LicenseClassID, ref ClassDescription, ref MinimumAllowedAge, ref DefaultValidityLength, ref ClassFees))
            {
                return new clsLicenseClass(LicenseClassID, ClassName, ClassDescription, MinimumAllowedAge, DefaultValidityLength, ClassFees);
            }
            else
            {
                return null;
            }


        }

        private bool _AddNewLicenseClass()
        {
            //call DataAccess Layer 

            this._LicenseClassID = clsLicenseClassesData.AddNewLicenseClass(this._ClassName, this._ClassDescription,
                this._MinimumAllowedAge, this._DefaultValidityLength, this._ClassFees);


            return (this._LicenseClassID != -1);
        }

        private bool _UpdateLicenseClass()
        {
            //call DataAccess Layer 

            return clsLicenseClassesData.UpdateLicenseClass(this._LicenseClassID, this._ClassName, this._ClassDescription,
                this._MinimumAllowedAge, this._DefaultValidityLength, this._ClassFees);
        }
        public static DataTable GetAllLicenseClasses()
        {
            return clsLicenseClassesData.GetAllLicenseClasses();

        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.AddNew:
                    if (_AddNewLicenseClass())
                    {

                        Mode = enMode.Update;
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                case enMode.Update:

                    return _UpdateLicenseClass();

            }

            return false;
        }



    }
}
