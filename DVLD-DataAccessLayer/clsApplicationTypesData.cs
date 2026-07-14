using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Configuration;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class clsApplicationTypesData
    {


        public static DataTable GetllAplicationTypes()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from ApplicationTypes;";

            SqlCommand command = new SqlCommand(Query, connection);

            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    dt.Load(reader);
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

            return dt;

        }
        public static bool UpdateAplicationTypes(int ApplicationID, string ApplicationTitle, double ApplicationFees)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Update ApplicationTypes
                              Set ApplicationTypeTitle = @ApplicationTitle,
                                  ApplicationFees = @ApplicationFees
                              Where ApplicationTypeID = @ApplicationID ;";

            SqlCommand cmd = new SqlCommand(Query, connection);

            cmd.Parameters.AddWithValue("@ApplicationTitle", ApplicationTitle);
            cmd.Parameters.AddWithValue("@ApplicationFees", ApplicationFees);
            cmd.Parameters.AddWithValue("@ApplicationID", ApplicationID);

            int RowsAffected = 0;

            try
            {

                connection.Open();

                RowsAffected = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }
            return (RowsAffected > 0);



        }

        public static bool FindApplicationType(int ApplicationTypeID, ref string ApplicationTitle, ref float ApplicationFees)
        {
            SqlConnection connection = new SqlConnection( DataAccessSettings.connectionString);

            string Query = "select * from ApplicationTypes Where ApplicationTypeID = @ApplicationTypeID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicationID", ApplicationTypeID);

            bool isfound = true ;
            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    ApplicationTitle = (string)reader["ApplicationTypeTitle"];
                    ApplicationFees = Convert.ToSingle(reader["ApplicationFees"]);

                }
                reader.Close();

            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                connection.Close();
            }
            return isfound;
        }



    }
}
