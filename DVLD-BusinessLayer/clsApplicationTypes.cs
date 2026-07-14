using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_BusinessLayer
{
    public class clsApplicationTypes
    {

        public int _ApplicationID { get; set; }

        public string _ApplicationTitle { get; set; }

        public float _ApplicationFees { get; set;}

        public clsApplicationTypes Types;

        private clsApplicationTypes(int ApplicationID, string ApplicationTitle, float ApplicationFees)
        {
            _ApplicationID = ApplicationID;
            _ApplicationTitle = ApplicationTitle;
            _ApplicationFees = ApplicationFees;

        }

        public clsApplicationTypes()
        {
            _ApplicationID = -1;
            _ApplicationTitle = "";
            _ApplicationFees = 0;
        }
        private bool _UpdateApplicationTypes()
        {

            return clsApplicationTypesData.UpdateAplicationTypes(this._ApplicationID, this._ApplicationTitle, this._ApplicationFees);

        }

        public static DataTable GetAllApplication()
        {
            return clsApplicationTypesData.GetllAplicationTypes();
        }

        public static clsApplicationTypes FindApplicationType(int ApplicationTypeID)
        {
            string ApplicationTitle = "";
            float ApplicationFees = 0;

            if(clsApplicationTypesData.FindApplicationType(ApplicationTypeID, ref ApplicationTitle, ref ApplicationFees))
            {
                return new clsApplicationTypes(ApplicationTypeID, ApplicationTitle, ApplicationFees);
            }
            else
            {
                return null;
            }

        }
        public bool Save()
        {
            if(_UpdateApplicationTypes())
            {
                return true;
            }
            return false;

        }


    }
}
