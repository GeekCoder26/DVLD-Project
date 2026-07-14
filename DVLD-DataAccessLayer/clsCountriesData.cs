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
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"select * from Countries order by Countries.CountryName";

            SqlCommand command = new SqlCommand(Query, connection);

            try
            {
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    CountriesDataTable.Load(reader);

                }
                reader.Close();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return CountriesDataTable;


        }

        public static bool GetCountryByName(string CountryName, ref int ID)
        {
            SqlConnection connection = new SqlConnection( DataAccessSettings.connectionString);

            string Query = @"Select * from Countries 
                                Where CountryName = @CountryName";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@CountryName", CountryName);

            bool isfound = false;

            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    ID = (int)reader["CountryID"];
                    isfound = true;
                }
                else
                {
                    isfound = false;
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }


            return isfound;

        }

        public static bool GetCountryByID(ref string CountryName, int ID)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Select * from Countries 
                                Where CountryID = @CountryID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@CountryID", ID);

            bool isfound = false;

            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    CountryName = (string)reader["CountryName"];
                    isfound = true;
                }
                else
                {
                    isfound = false;
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }


            return isfound;


        }


    }
}
