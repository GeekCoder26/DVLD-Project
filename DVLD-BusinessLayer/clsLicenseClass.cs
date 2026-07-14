using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
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
        public short _MinimumAllowedAge { get; set; }
        public short _DefaultValidityLength { get; set; }
        public float _ClassFees { get; set; }


        private clsLicenseClass(int LicenseClassID, string ClassName, string ClassDescription, short MinimumAllowedAge, short DefaultValidityLength, float ClassFees)
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
            short MinimumAllowedAge = 0, DefaultValidityLength = 0;
            float ClassFees = 0;

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
            short MinimumAllowedAge = 0, DefaultValidityLength = 0;
            float ClassFees = 0;

            if (clsLicenseClassesData.Find(ClassName, ref LicenseClassID, ref ClassDescription, ref MinimumAllowedAge, ref DefaultValidityLength, ref ClassFees))
            {
                return new clsLicenseClass(LicenseClassID, ClassName, ClassDescription, MinimumAllowedAge, DefaultValidityLength, ClassFees);
            }
            else
            {
                return null;
            }


        }


    }
}
