using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVLD_DataAccessLayer;

namespace DVLD_BusinessLayer
{
    public class clsCountries
    {

        public int _CountryID { get; set; }
        public string _CountryName { get; set; }


        private clsCountries() 
        {
            _CountryID = 0;
            _CountryName = "";
        }

        private clsCountries(int CountryID, string CountryName)
        {

            _CountryID = CountryID;
            _CountryName = CountryName;

        }

        public static clsCountries Find(string CountryName)
        {

            int ID = -1;

            if(clsCountriesData.GetCountryByName(CountryName, ref ID))
            {
                return new clsCountries(ID, CountryName);
            }
            else
            {
                return null;
            }

        }

        public static clsCountries Find(int CountryID)
        {

            string CountryName = "";

            if (clsCountriesData.GetCountryByID(ref CountryName, CountryID))
            {
                return new clsCountries(CountryID, CountryName);
            }
            else
            {
                return null;
            }

        }

        public static DataTable GetAllCountries()
        {
            return clsCountriesData.GetAllCountries();
        }


    }
}
