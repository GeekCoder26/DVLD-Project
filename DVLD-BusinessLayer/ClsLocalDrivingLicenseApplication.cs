using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_BusinessLayer
{
    public class ClsLocalDrivingLicenseApplication : clsApplication
    {

        public enum enMode { AddNew = 1, Update = 2 };
        enMode Mode = enMode.AddNew;
        public int LocalDrivingLicenseApplicationID {  get; set; }
        public int LicenseClassID { get; set; }

        public clsLicenseClass LicenseInfo;

        public string FullName
        {
            get
            {
                return base.PersonInfo.FullName;
            }
        }

        public ClsLocalDrivingLicenseApplication()
        {
            this.LocalDrivingLicenseApplicationID = -1;
            this.LicenseClassID = -1;

            Mode = enMode.AddNew;
        }

        public ClsLocalDrivingLicenseApplication(int LocalDrivingLicenseApplicationID, int ApplicationID, int PersonID, DateTime ApplicationDate,
           int ApplicationTypeID, enApplicationStatus ApplicationStatus, DateTime LastStatusDate, float PaidFees, int UserID, int LicenseClassID )
        {
           this.LocalDrivingLicenseApplicationID = LocalDrivingLicenseApplicationID;
            this._ApplicationID = ApplicationID;
            this._PersonID = PersonID;
            this._ApplicationDate = ApplicationDate;
            this._ApplicationTypeID = ApplicationTypeID;
            this.applicationStatus = ApplicationStatus;
            this._LastStatusDate = LastStatusDate;
            this._PaidFees = PaidFees;
            this._UserID = UserID;
            this.LicenseClassID = LicenseClassID;
            LicenseInfo = clsLicenseClass.Find(LicenseClassID);





            Mode = enMode.Update;
        }



        private bool _AddNewLocalDrivingLiceneApplication()
        {
            this.LocalDrivingLicenseApplicationID = ClsLocalDrivingLicenseApplicationData.AddNewApplication(this._ApplicationID, this.LicenseClassID);

            return (this.LocalDrivingLicenseApplicationID != -1);
        }

        private bool _UpdateLocalDrivingLicenseApplication()
        {
            return ClsLocalDrivingLicenseApplicationData.UpdateApplication(this.LocalDrivingLicenseApplicationID, this._ApplicationID, this.LicenseClassID);
        }

        public static ClsLocalDrivingLicenseApplication FindByLocalDrivingApplication(int LocalDrivingLicenseApplicationID)
        {
            int ApplicationID = -1, LicenseClassID = -1;

            bool isfound = ClsLocalDrivingLicenseApplicationData.GetLocalDrivingLicenseINfoByID(LocalDrivingLicenseApplicationID, ref ApplicationID, ref LicenseClassID);

            if(isfound)
            {
                clsApplication Application = clsApplication.FindApplication(ApplicationID);

                return new ClsLocalDrivingLicenseApplication(LocalDrivingLicenseApplicationID, Application._ApplicationID, Application._PersonID,
                    Application._ApplicationDate, Application._ApplicationTypeID, Application.applicationStatus, Application._LastStatusDate, Application._PaidFees
                    , Application._UserID, LicenseClassID);
            }
            else
            {
                return null;
            }

        }

        public static ClsLocalDrivingLicenseApplication FindByApplication(int ApplicationID)
        {
            int LocalDrivingLicenseApplicationID  = -1, LicenseClassID = -1;

            bool isfound = ClsLocalDrivingLicenseApplicationData.GetLocalDrivingLicenseINfoByApplicationID(ApplicationID, ref LocalDrivingLicenseApplicationID, ref LicenseClassID);

            if (isfound)
            {
                clsApplication Application = clsApplication.FindApplication(ApplicationID);

                return new ClsLocalDrivingLicenseApplication(LocalDrivingLicenseApplicationID, Application._ApplicationID, Application._PersonID,
                    Application._ApplicationDate, Application._ApplicationTypeID, Application.applicationStatus, Application._LastStatusDate, Application._PaidFees
                    , Application._UserID, LicenseClassID);
            }
            else
            {
                return null;
            }

        }

        public bool Save()
        {

            base.Mode = (clsApplication.enMode) Mode;

            if(!base.Save())
            {
                return false;
            }

            switch (Mode)
            {
                case enMode.AddNew:
                    if (_AddNewLocalDrivingLiceneApplication())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                case enMode.Update:

                    return _UpdateLocalDrivingLicenseApplication();

            }
            return false;

        }

        public static DataTable GetAllDrivingLicenseApplication()
        {

            return clsApplicationsData.GetAllApplications();

        }

        public bool Delete()
        {
            return clsApplicationsData.DeleteApplication(this._ApplicationID);
        }


        public int GetActiveLicenseID()
        {
            return -1;
        }


        public bool DoesPassTestType(clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.DoesPassTestType(this.LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public bool DoesPassPreviousTest(clsTestTypes.enType CurrentTestType)
        {

            switch (CurrentTestType)
            {
                case clsTestTypes.enType.VisionTest:
                    //in this case no required prvious test to pass.
                    return true;

                case clsTestTypes.enType.WrittenTest:
                    //Written Test, you cannot sechdule it before person passes the vision test.
                    //we check if pass visiontest 1.

                    return this.DoesPassTestType(clsTestTypes.enType.VisionTest);


                case clsTestTypes.enType.PracticalTest:

                    //Street Test, you cannot sechdule it before person passes the written test.
                    //we check if pass Written 2.
                    return this.DoesPassTestType(clsTestTypes.enType.WrittenTest);

                default:
                    return false;
            }
        }

        public static bool DoesPassTestType(int LocalDrivingLicenseApplicationID, clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.DoesPassTestType(LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public bool DoesAttendTestType(clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.DoesAttendTestType(this.LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public byte TotalTrialsPerTest(clsTestTypes.enType TestTypeID)
        {
            return ClsLocalDrivingLicenseApplicationData.TotalTrialPerTest(this.LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public static byte TotalTrialsPerTest(int LocalDrivingLicenseApplicationID, clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.TotalTrialPerTest(LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public static bool AttendedTest(int LocalDrivingLicenseApplicationID, clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.TotalTrialPerTest(LocalDrivingLicenseApplicationID, (int)TestTypeID) > 0;
        }

        public bool AttendedTest(clsTestTypes.enType TestTypeID)

        {
            return ClsLocalDrivingLicenseApplicationData.TotalTrialPerTest(this.LocalDrivingLicenseApplicationID, (int)TestTypeID) > 0;
        }

        public static bool IsThereAnActiveScheduledTest(int LocalDrivingLicenseApplicationID, clsTestTypes.enType TestTypeID)

        {

            return ClsLocalDrivingLicenseApplicationData.IsThereAnActiveScheduledTest(LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }

        public bool IsThereAnActiveScheduledTest(clsTestTypes.enType TestTypeID)

        {

            return ClsLocalDrivingLicenseApplicationData.IsThereAnActiveScheduledTest(this.LocalDrivingLicenseApplicationID, (int)TestTypeID);
        }
       
        //public clsTest GetLastTestPerTestType(clsTestTypes.enType TestTypeID)
        //{
        //    return clsTest.FindLastTestPerPersonAndLicenseClass(this.ApplicantPersonID, this.LicenseClassID, TestTypeID);
        //}

        //public byte GetPassedTestCount()
        //{
        //    return clsTest.GetPassedTestCount(this.LocalDrivingLicenseApplicationID);
        //}

        //public static byte GetPassedTestCount(int LocalDrivingLicenseApplicationID)
        //{
        //    return clsTest.GetPassedTestCount(LocalDrivingLicenseApplicationID);
        //}

        //public bool PassedAllTests()
        //{
        //    return clsTest.PassedAllTests(this.LocalDrivingLicenseApplicationID);
        //}

        //public static bool PassedAllTests(int LocalDrivingLicenseApplicationID)
        //{
        //    //if total passed test less than 3 it will return false otherwise will return true
        //    return clsTest.PassedAllTests(LocalDrivingLicenseApplicationID);
        //}

        //public int IssueLicenseForTheFirtTime(string Notes, int CreatedByUserID)
        //{
        //    int DriverID = -1;

        //    clsDriver Driver = clsDriver.FindByPersonID(this.ApplicantPersonID);

        //    if (Driver == null)
        //    {
        //        //we check if the driver already there for this person.
        //        Driver = new clsDriver();

        //        Driver.PersonID = this.ApplicantPersonID;
        //        Driver.CreatedByUserID = CreatedByUserID;
        //        if (Driver.Save())
        //        {
        //            DriverID = Driver.DriverID;
        //        }
        //        else
        //        {
        //            return -1;
        //        }
        //    }
        //    else
        //    {
        //        DriverID = Driver.DriverID;
        //    }
        //    //now we diver is there, so we add new licesnse

        //    clsLicense License = new clsLicense();
        //    License.ApplicationID = this.ApplicationID;
        //    License.DriverID = DriverID;
        //    License.LicenseClass = this.LicenseClassID;
        //    License.IssueDate = DateTime.Now;
        //    License.ExpirationDate = DateTime.Now.AddYears(this.LicenseClassInfo.DefaultValidityLength);
        //    License.Notes = Notes;
        //    License.PaidFees = this.LicenseClassInfo.ClassFees;
        //    License.IsActive = true;
        //    License.IssueReason = clsLicense.enIssueReason.FirstTime;
        //    License.CreatedByUserID = CreatedByUserID;

        //    if (License.Save())
        //    {
        //        //now we should set the application status to complete.
        //        this.SetComplete();

        //        return License.LicenseID;
        //    }

        //    else
        //        return -1;
        //}

        public bool IsLicenseIssued()
        {
            return (GetActiveLicenseID() != -1);
        }

    }
}
