using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace DVLD_DataAccessLayer
{

    public class clsApplicationsData
    {

        public static DataTable GetAllApplications()
        {
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetAllApplications", connection))
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

        public static int AddNewApplication(int PersonID, DateTime ApplicationDate, int ApplicationTypeID,
                                            byte ApplicationStatus, DateTime LastStatusDate, float PaidFees,
                                            int UserID)
        {
            int ApplicationID = -1;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_AddNewApplication", connection))
                {

                    command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
                    command.Parameters.AddWithValue("@ApplicationDate", ApplicationDate);
                    command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
                    command.Parameters.AddWithValue("@ApplicationStatus", ApplicationStatus);
                    command.Parameters.AddWithValue("@LastStatusDate", LastStatusDate);
                    command.Parameters.AddWithValue("@PaidFees", PaidFees);
                    command.Parameters.AddWithValue("@CreatedByUserID", UserID);

                    var outParam = new SqlParameter("@ApplicationID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(outParam);



                    try
                    {
                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null && int.TryParse(result.ToString(), out int ReturnedID))
                        {
                            ApplicationID = ReturnedID;
                        }


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }



                return ApplicationID;

        }

        public static bool UpdateApplication(int ApplicationID, int PersonID, DateTime ApplicationDate,
                                             int ApplicationTypeID, byte ApplicationStatus,
                                             DateTime LastStatusDate, float PaidFees, int UserID)
        {

            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_UpdateApplication", connection))
                {

                    command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
                    command.Parameters.AddWithValue("@ApplicationDate", ApplicationDate);
                    command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
                    command.Parameters.AddWithValue("@ApplicationStatus", ApplicationStatus);
                    command.Parameters.AddWithValue("@LastStatusDate", LastStatusDate);
                    command.Parameters.AddWithValue("@PaidFees", PaidFees);
                    command.Parameters.AddWithValue("@CreatedByUserID", UserID);
                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }

            return (RowsAffected > 0);

        }
        public static bool DeleteApplication(int ApplicationID)
        {
            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_DeleteApplication", connection))
                {

                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }

                return (RowsAffected > 0);



        }

        public static bool FindApplication(int ApplicationID, ref int PersonID, ref DateTime ApplicationDate,
                                           ref int ApplicationTypeID, ref byte ApplicationStatus,ref DateTime LastStatusDate,
                                           ref float PaidFees, ref int UserID)
        {
            bool IsFound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_FindApplicationByID", connection))
                {

                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                PersonID = (int)reader["ApplicantPersonID"];
                                ApplicationDate = (DateTime)reader["ApplicationDate"];
                                ApplicationTypeID = (int)reader["ApplicationTypeID"];
                                ApplicationStatus = (byte)reader["ApplicationStatus"];
                                LastStatusDate = (DateTime)reader["LastStatusDate"];
                                PaidFees = (float)reader["PaidFees"];
                                UserID = (int)reader["CreatedByUserID"];
                            }
                        }

                        

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        IsFound = false;
                    }
                }

            }
            return IsFound;
        }

        public static bool ISApplicationValidByStatus(int PersonID, int ApplicationTypeID)
        {

            return GetActiveApplicationID(PersonID, ApplicationTypeID) != -1;

        }

        public static int GetActiveApplicationID(int PersonID, int ApplicationTypeID)
        {
            int ActiveApplicationID = -1;

            bool isfound = false;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetActiveApplication", connection))
                {

                    command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
                    command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);

                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int AppID))
                        {
                            ActiveApplicationID = AppID;
                        }

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }


                return ActiveApplicationID;

        }

        public static int GetActiveApplicationIDForLicenseClass(int PersonID, int ApplicationTypeID, int LicenseClassID)
        {
            int ActiveAppApplicationID = -1;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {



                using (SqlCommand command = new SqlCommand("SP_GetActiveApplicationIDForLicenseClass", connection))
                {

                    command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
                    command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
                    command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {

                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int AppID))
                        {
                            ActiveAppApplicationID = AppID;
                        }

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }


                return ActiveAppApplicationID;


        }

        public static bool UpdateStatus(int ApplicationID, short Status)
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_UpdateStatus", connection))
                {

                    command.Parameters.AddWithValue("@ApplicationStatus", Status);
                    command.Parameters.AddWithValue("@LastStatusDate", DateTime.Now);
                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }
            return RowsAffected > 0;

        }

    }
}
