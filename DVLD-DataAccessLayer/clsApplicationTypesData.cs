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

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetAllApplicationTypes", connection))
                {

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                dt.Load(reader);
                            }
                        }

                  


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }


                return dt;

        }
        public static bool UpdateAplicationTypes(int ApplicationTypeID, string ApplicationTitle, decimal ApplicationFees)
        {

            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand cmd = new SqlCommand("SP_UpdateApplicationTypes", connection))
                {
                    cmd.Parameters.AddWithValue("@ApplicationTypeTitle", ApplicationTitle);
                    cmd.Parameters.AddWithValue("@ApplicationFees", ApplicationFees);
                    cmd.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);

                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        connection.Open();

                        RowsAffected = cmd.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

                
            }


                return (RowsAffected > 0);



        }

        public static bool FindApplicationType(int ApplicationTypeID, ref string ApplicationTitle, ref decimal ApplicationFees)
        {
            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_FindApplicationType", connection))
                {

                    command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {
                                ApplicationTitle = (string)reader["ApplicationTypeTitle"];
                                ApplicationFees = Convert.ToDecimal(reader["ApplicationFees"]);

                            }

                        }


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

            }


                return isfound;
        }



    }
}
