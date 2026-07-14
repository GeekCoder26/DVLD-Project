 using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_BusinessLayer
{
    public class clsTestTypes
    {

        public enum enType {VisionTest = 1, WrittenTest = 2, PracticalTest = 3 };

        public int _TestTypeID { get; set; }

        public string _TestTypeTitle { get; set; }
        public string _TestTypeDescription { get; set; }

        public double _TestTypeFees { get; set; }

        public clsTestTypes TestType;
        private clsTestTypes(int TestTypeID, string TestTypeTitle, string TestTypeDescription, double TestTypeFees)
        {

            _TestTypeID = TestTypeID;

            _TestTypeTitle = TestTypeTitle;

            _TestTypeDescription = TestTypeDescription;

            _TestTypeFees = TestTypeFees;

        }

        public clsTestTypes()
        {
            _TestTypeID = -1;
            _TestTypeTitle = "";
            _TestTypeDescription = "";
            _TestTypeFees = 0;

        }


        private bool _UpdateTestTypes()
        {
            return clsTestsTypesData.UpdateTestTypes(this._TestTypeID, this._TestTypeTitle, this._TestTypeDescription, this._TestTypeFees);
        }

        public static DataTable GetAllTestTypes()
        {
            return clsTestsTypesData.GetllAplicationTypes();
        }

        public static clsTestTypes FindApplicationType(clsTestTypes.enType TestTypeID)
        {
            string TestTypeTitle = "", TestTypeDescription = "";
            double TestTypeFees = 0;

            if (clsTestsTypesData.FindTestType((int)TestTypeID, ref TestTypeTitle, ref TestTypeDescription, ref TestTypeFees))
            {
                return new clsTestTypes((int)TestTypeID, TestTypeTitle, TestTypeDescription, TestTypeFees);
            }
            else
            {
                return null;
            }

        }

        public bool Save()
        {
            if(_UpdateTestTypes())
            {
                return true;
            }
            return false;
        }



    }
}
