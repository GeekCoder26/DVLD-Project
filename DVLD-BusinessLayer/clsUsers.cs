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
    public class clsUsers
    {

        enum enMode { AddNew, Update};
        enMode Mode;

        public int _UserID { get; set; }
        public string _UserName { get; set; }
        public string _Password { get; set; }
        public bool _IsActive { get; set; }
        int _PersonID { get; set; }

        public clsPerson PersonInfo { get; set; }

        public int PersonID
        {
            get { return _PersonID; }
            set { _PersonID = value; }

        }

        private clsUsers(int UserID, int PersonID, string Username, string Password, bool IsActive)
        {
            _UserID = UserID;
            _UserName = Username;
            _Password = Password;
            _IsActive = IsActive;
            _PersonID = PersonID;

            Mode = enMode.Update;
        }

        public clsUsers()
        {
             _UserID = 0;
            _UserName = "";
            _Password = "";
            _IsActive = false;

            Mode = enMode.AddNew;

        }

        public static DataTable GetAllUsers()
        {
            return clsUsersData.GetAllUsers();
        }
        private bool AddNewUser()
        {
            this._UserID = clsUsersData.AddUser(this._PersonID, _UserName, _Password, _IsActive);

            return (_UserID != -1);
        }
        private bool UpdateUser()
        {
            return clsUsersData.UpdateUSer(this._UserID, this._UserName, this._Password, this._IsActive);
        }
        public static bool DeleteUser(int UserID)
        {
            return clsUsersData.DeleteUser(UserID);
        }


        public static clsUsers FindUser(int UserID)
        {
            string Username = "", Password = "";
            bool isActive = false;
            int PersonID = -1;

            if(clsUsersData.FindUser(UserID, ref PersonID, ref Username, ref Password, ref isActive))
            {
                return new clsUsers(UserID, PersonID,  Username, Password, isActive);
            }
            else
            {
                return null;
            }
        }
        public static clsUsers FindUser(string Username)
        {
            int UserID = -1;
            string  Password = "";
            bool isActive = false;
            int PersonID = -1;

            if (clsUsersData.FindUser(Username, ref PersonID, ref UserID, ref Password, ref isActive))
            {
                return new clsUsers(UserID, PersonID, Username, Password, isActive);
            }
            else
            {
                return null;
            }
        }

        public static bool IsUserExist(int UserID)
        {
            return clsUsersData.IsUserExist(UserID);
        }
        public static bool IsUserExist(string Username)
        {
            return clsUsersData.IsUserExist(Username);
        }

        public static bool IsUSerExistByPersonID(int PersonID)
        {
            return clsUsersData.IsUserExistByPersonID(PersonID);
        }


        public bool Save()
        {
            switch(Mode)
            {
                case enMode.AddNew:

                    if(AddNewUser())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                case enMode.Update:
                    return UpdateUser();
                          
            }
            return false;
        }


    }
}
