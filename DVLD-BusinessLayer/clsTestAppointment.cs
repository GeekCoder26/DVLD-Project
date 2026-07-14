using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace DVLD_BusinessLayer
{
    public class clsTestAppointment
    {


        public enum enMode { AddNew = 1, Update = 2}
        enMode Mode;

        public int _TestAppointmentID {  get; set; }
        public clsTestTypes.enType _TestTypeID { get; set; }
        public int _LocalDrivingLicenseApplicationID { get; set; }
        public DateTime _AppointmentDate { get; set; }
        public float _PaidFees { get; set; }
        public int _UserID { get; set; }
        public bool _IsLocked { get; set; }
        public int _RetakeTestAppID { get; set; }
        public clsApplication RetakeTestAppInfo { get; set; }

        public int TestID
        {
            get { return GetTestID(); }
        }

        public clsTestAppointment()
        {
            _TestAppointmentID = -1;
            _TestTypeID = clsTestTypes.enType.VisionTest;
            _AppointmentDate = DateTime.Now;
            _PaidFees = 0;
            _UserID = -1;
            _RetakeTestAppID = -1;
            Mode = enMode.AddNew;

        }

        private clsTestAppointment(int TestAppointmentID, clsTestTypes.enType TestTypeID, int LocalDrivingLicenseApplicationID, DateTime AppointmentDate,
            float PaidFees, int UserID, bool IsLocked, int RetakeTestAppID)
        {
            this._TestAppointmentID = TestAppointmentID;
            this._TestTypeID = TestTypeID;
            this._LocalDrivingLicenseApplicationID = LocalDrivingLicenseApplicationID;
            this._AppointmentDate = AppointmentDate;
            this._PaidFees = PaidFees;
            this._UserID = UserID;
            this._IsLocked = IsLocked;
            this._RetakeTestAppID = RetakeTestAppID;
            this.RetakeTestAppInfo = clsApplication.FindApplication(_RetakeTestAppID);
            Mode = enMode.Update;

        }

        private bool _AppNewTestAppointment()
        {
            this._TestAppointmentID = clsTestAppointementData.AddNewTestAppointment((int)this._TestTypeID, _LocalDrivingLicenseApplicationID,
                this._AppointmentDate, this._PaidFees, this._UserID, this._IsLocked, this._RetakeTestAppID);

            return (this._TestAppointmentID != -1);
        }

        private bool _UpdateTestAppointment()
        {
            return clsTestAppointementData.UpdateTestAppointment((int)this._TestTypeID, this._LocalDrivingLicenseApplicationID, this._AppointmentDate
                , this._PaidFees, this._UserID, this._IsLocked, this._RetakeTestAppID);
        }

        public static clsTestAppointment Find(int TestAppointmentID)
        {
            int TestTypeID = -1, LocalDrivingLicenseApplicationID = -1;
            DateTime AppointmentDate = DateTime.Now;
            float PaidFee = 0;
            int UserID = -1;
            bool IsLocked = false;
            int RetakeTestAppID = -1;

            if(clsTestAppointementData.GetTestappointmentInfoByID(TestAppointmentID, ref TestTypeID, ref LocalDrivingLicenseApplicationID, ref AppointmentDate, ref PaidFee,
                ref UserID, ref IsLocked, ref RetakeTestAppID))
            {
                return new clsTestAppointment(TestAppointmentID, (clsTestTypes.enType)TestTypeID, LocalDrivingLicenseApplicationID, AppointmentDate, PaidFee,
                    UserID, IsLocked, RetakeTestAppID);
            }
            else
            {
                return null;
            }


        }

        public static clsTestAppointment GetLastTestAppointment(int LocalDrivingLicenseApplicationID, int TestTypeID)
        {
            int TestAppointmentID = -1;
            DateTime AppointmentDate = DateTime.Now;
            float PaidFee = 0;
            int UserID = -1;
            bool IsLocked = false;
            int RetakeTestAppID = -1;

            if (clsTestAppointementData.GetLastTestAppointment(LocalDrivingLicenseApplicationID, TestTypeID, ref TestAppointmentID,  ref AppointmentDate, ref PaidFee,
                ref UserID, ref IsLocked, ref RetakeTestAppID))
            {
                return new clsTestAppointment(TestAppointmentID, (clsTestTypes.enType)TestTypeID, LocalDrivingLicenseApplicationID, AppointmentDate, PaidFee,
                    UserID, IsLocked, RetakeTestAppID);
            }
            else
            {
                return null;
            }


        }

        public static DataTable GetAllTestAppointments()
        {
            return clsTestAppointementData.GetAllTestAppointment();
        }

        public DataTable GetApplicationTestAppointmentPerTestType(clsTestTypes.enType TestTypeID)
        {
            return clsTestAppointementData.GetApplicationTestAppointmentPerTestType((int)TestTypeID, this._TestAppointmentID);
        }
        public static DataTable GetApplicationTestAppointmentPerTestType(int LocalDrivingLicenseApplicationID, clsTestTypes.enType TestTypeID)
        {
            return clsTestAppointementData.GetApplicationTestAppointmentPerTestType((int)TestTypeID, LocalDrivingLicenseApplicationID);
        }


        public bool Save()
        {
            switch(Mode)
            {
                case enMode.AddNew:

                    if(_AppNewTestAppointment())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                case enMode.Update:

                    return _UpdateTestAppointment();
            }
            return false;
        }

        private int GetTestID()
        {
            return clsTestAppointementData.GetTestID(this._TestAppointmentID);
        }



    }
}
