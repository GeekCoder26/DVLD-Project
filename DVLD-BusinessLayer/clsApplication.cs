using DVLD_DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace DVLD_BusinessLayer
{
    public class clsApplication
    {

        public enum enApplicationType { NewDrivingLicense = 1, RenewDrivingLicense = 2, ReplaceLostDrivingLicense = 3,
                                      ReplaceDamageDrivingLicense = 4, ReleaseDetainedDrivingLicense = 5,
                                      NewInternationalDrivingLicense = 6, RetakeTest = 7};

        public enum enApplicationStatus { New = 1, Canceled = 2, Completed = 3};
        public enum enMode { AddNew = 1, Update = 2};
        public enMode Mode;
        public int _ApplicationID { get; set; }

        public clsPerson PersonInfo { get; set; }
        public int _PersonID { get; set; }

        public string ApplicantFullName
        {
            get
            {
                return clsPerson.FindPerson(_PersonID).FullName;
            }
        }
        public DateTime _ApplicationDate { get; set; }
        public int _ApplicationTypeID { get; set; }
        public clsApplicationTypes ApplicationTypeInfo { get; set; }
        public enApplicationStatus applicationStatus { get; set; }
        public string StatusText
        {
            get
            {
                switch(applicationStatus)
                {
                    case enApplicationStatus.New:
                        return "New";
                    case enApplicationStatus.Canceled:
                        return "Canceled";
                    case enApplicationStatus.Completed:
                        return "Completed";
                    default:
                       return "Unknown";
                }
            }
        }
        public DateTime _LastStatusDate { get; set; }
        public float _PaidFees { get; set; }
        public int _UserID { get; set; }
        public clsUsers UserInfo { get; set; }

        clsApplicationTypes ApplicationTypes;

        private clsApplication(int ApplicationID, int PersonID, DateTime ApplicationDate, int ApplicationTypeID, enApplicationStatus ApplicationStatus, DateTime LastStatusDate, 
                               float PaidFees, int UserID)
        {
            _ApplicationID = ApplicationID;

            _PersonID = PersonID;

            PersonInfo = clsPerson.FindPerson(PersonID);

            _ApplicationDate = ApplicationDate;

            _ApplicationTypeID = ApplicationTypeID;

            ApplicationTypeInfo = clsApplicationTypes.FindApplicationType(ApplicationTypeID);

            applicationStatus = ApplicationStatus;

            _LastStatusDate = LastStatusDate;

            _PaidFees = PaidFees;

            _UserID = UserID;

            UserInfo = clsUsers.FindUser(UserID);

            Mode = enMode.Update;
        }

        public clsApplication()
        {
            _ApplicationID = -1;

            _PersonID = -1;

            _ApplicationDate = DateTime.Now;

            _ApplicationTypeID = -1;

            applicationStatus = enApplicationStatus.New;

            _LastStatusDate = DateTime.Now;

            _PaidFees = 0;

            _UserID = -1;

            Mode = enMode.AddNew;
        }


        public static DataTable GetAllApplication()
        {
            return clsApplicationsData.GetAllApplications();
        }
        private bool AddNewApplication()
        {
            this._ApplicationID = clsApplicationsData.AddNewApplication(this._PersonID, this._ApplicationDate, this._ApplicationTypeID, (byte)this.applicationStatus,
            this._LastStatusDate, this._PaidFees, this._UserID);

            return (_ApplicationID != -1);


        }
        private bool UpdateApplication()
        {
            return clsApplicationsData.UpdateApplication(this._ApplicationID, this._PersonID, this._ApplicationDate, this._ApplicationTypeID,
                (byte)this.applicationStatus, this._LastStatusDate, this._PaidFees, this._UserID);
        }

        public static bool DeleteApplication(int ApplicationID)
        {
            return clsApplicationsData.DeleteApplication(ApplicationID);
        }

        public static clsApplication FindApplication(int ApplicationID)
        {
            int PersonID = -1, ApplicationTypeID = -1, UserID = -1;
            DateTime ApplicationDate = DateTime.Now, LastStatusDate = DateTime.Now;
            byte ApplicationStatus = 0;
            float PaidFees = 0;

            if(clsApplicationsData.FindApplication(ApplicationID, ref PersonID, ref ApplicationDate, ref ApplicationTypeID, ref ApplicationStatus,
                ref LastStatusDate, ref PaidFees, ref UserID))
            {
                return new clsApplication(ApplicationID, PersonID, ApplicationDate, ApplicationTypeID, (enApplicationStatus)ApplicationStatus, LastStatusDate, PaidFees, UserID);
            }
            else
            {
                return null; 
            }



        }

        public  bool Cancel()
        {
            return clsApplicationsData.UpdateStatus(_ApplicationID, 2);
        }

        public bool SetComplete()
        {
            return clsApplicationsData.UpdateStatus(_ApplicationID, 3);
        }

        public bool Save()
        {

            switch (Mode)
            {
                case enMode.AddNew:

                    if (AddNewApplication())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else
                    {
                        return false;
                    }

                case enMode.Update:

                    return UpdateApplication();

            }
            return false;

        }

        public static bool DoesPersonHaveActiveApplication(int PersonID, int ApplicationTypeID)
        {
            return clsApplicationsData.ISApplicationValidByStatus(PersonID, ApplicationTypeID);
        }
        public  bool DoesPersonHaveActiveApplication(int ApplicationTypeID)
        {
            return clsApplicationsData.ISApplicationValidByStatus(this._PersonID, ApplicationTypeID);
        }

        public static int GetActiveApplicationID(int PersonID, clsApplication.enApplicationType ApplicationType)
        {
            return clsApplicationsData.GetActiveApplicationID(PersonID, (int)ApplicationType);
        }

        public static int GetActiveApplicationIDForLicenseClass(int PersonID, clsApplication.enApplicationType ApplicationType, int LicenseClassID)
        {
            return clsApplicationsData.GetActiveApplicationIDForLicenseClass(PersonID, (int)ApplicationType, LicenseClassID);
        }

        public int GetActiveApplicationID(clsApplication.enApplicationType ApplicationType)
        {
            return clsApplicationsData.GetActiveApplicationID(this._PersonID,  (int)ApplicationType);
        }



    }
}
