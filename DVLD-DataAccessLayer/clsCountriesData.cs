using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class clsCountriesData
    {

        public static DataTable GetAllCountries()
        {

            DataTable CountriesDataTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_getallcountries", connection))
                {

                    try
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                CountriesDataTable.Load(reader);

                            }
                        }

                       
                       
                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }



                return CountriesDataTable;


        }

        public static bool GetCountryByName(string CountryName, ref int ID)
        {
            bool isfound = false;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetCountryByName", connection))
                {

                    command.Parameters.AddWithValue("@CountryName", CountryName);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ID = (int)reader["CountryID"];
                                isfound = true;
                            }
                            else
                            {
                                isfound = false;
                            }
                        }

                       


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isfound = false;
                    }
                }


            }




            return isfound;

        }

        public static bool GetCountryByID(ref string CountryName, int ID)
        {

            bool isfound = false;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetCountryByID", connection))
                {

                    command.Parameters.AddWithValue("@CountryID", ID);
                    command.CommandType = CommandType.StoredProcedure;



                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {
                                CountryName = (string)reader["CountryName"];
                                isfound = true;
                            }
                            else
                            {
                                isfound = false;
                            }
                        }



                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isfound = false;
                    }
                }

            }
            return isfound;


        }


    }
}
