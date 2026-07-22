using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class ClsLocalDrivingLicenseApplicationData 
    {
        public static bool GetLocalDrivingLicenseINfoByID(int LocalDrivingLicenseID, ref int ApplicationID, ref int LicenseClassID)
        {

            bool Result = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetLocalDrivingLicesneInfoByID", connection))
                {
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseID);

                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {


                            if (reader.Read())
                            {
                                ApplicationID = (int)reader["ApplicationID"];
                                LicenseClassID = (int)reader["LicenseClassID"];
                            }
                            

                        }




                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        Result = false;
                    }
                }

                
            }

                return Result;
        }

        public static bool GetLocalDrivingLicenseINfoByApplicationID(int ApplicationID, ref int LocalDrivingLicenseID, ref int LicenseClassID)
        {

            bool Result = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetLocalDrivingLicesneInfoByApplicationID", connection))
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
                                LocalDrivingLicenseID = (int)reader["LocalDrivingLicenseID"];
                                LicenseClassID = (int)reader["LicenseClassID"];
                            }
                            

                        }

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        Result = false;
                    }
                }

            }


                return Result;
        }

        public static DataTable GetAllLocalDrivingLicenseApplications()
        {
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetAllLocalDrivingLicenseApplication", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

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

        public static int AddNewApplication(int ApplicationID, int LisenceClassID)
        {
            int LocalApplicationID = -1;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_AddNewLocalDriving", connection))
                {
                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);
                    command.Parameters.AddWithValue("@LisenceClassID", LisenceClassID);

                    var outParam = new SqlParameter("@LocaDrivingLicenseApplicationID", SqlDbType.Int)
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
                            LocalApplicationID = ReturnedID;
                        }


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

                
            }
            return LocalApplicationID;

        }

        public static bool UpdateApplication(int LocalDrivingLicenseApplicationID, int ApplicationID, int LicenseClassID)
        {
            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_UpdateLocalDriving", connection))
                {

                    command.Parameters.AddWithValue("@ApplicationID", ApplicationID);
                    command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
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

        public static bool DeleteApplication(int LocalDrivingLicenseApplicationID)
        {
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_DeleteLocalDriving", connection))
                {
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.CommandType = CommandType.StoredProcedure;


                    int RowsAffected = 0;
                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);

                    }

                    return (RowsAffected > 0);
                }

                
            }

            



        }


        static public bool DoesPassTestType(int LocalDrivingLicenseApplicationID, int TestTypeID)
        {
            bool Result = false;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand cmd = new SqlCommand("SP_DoesTestPassed", connection))
                {

                    cmd.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    cmd.Parameters.AddWithValue("@TestTypeID", TestTypeID);

                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();

                        object result = cmd.ExecuteScalar();

                        if (result != null && bool.TryParse(result.ToString(), out bool returnedResult))
                        {
                            Result = returnedResult;
                        }
                    }

                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);

                    }
                }

            }
        
                return Result;

        }

        static public bool DoesAttendTestType(int LocalDrivingLicenseApplicationID, int TestTypeID)
        {
            bool IsFound = false;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {


                using (SqlCommand command = new SqlCommand("SP_DoesAttendTestType", connection))
                {
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null)
                        {
                            IsFound = true;
                        }
                    }

                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);

                    }
                }

                

            }



            return IsFound;
        }


        static public byte TotalTrialPerTest(int LocalDrivingLicenseApplicationID, int TestTypeID)
        {


            byte TotalTrialsPerTest = 0;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_TotalTrialPerTest", connection))
                {

                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null && byte.TryParse(result.ToString(), out byte Trials))
                        {
                            TotalTrialsPerTest = Trials;
                        }
                    }

                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }


            }


            return TotalTrialsPerTest;
        }


        static public bool IsThereAnActiveScheduledTest(int LocalDrivingLicenseApplicationID, int TestTypeID)
        {

            bool Result = false;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsThereAnActiveScheduledTest", connection))
                {

                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        object result = command.ExecuteScalar();
                       

                        if (result != null)
                        {
                            Result = true;
                        }

                    }

                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }
                return Result;



        }
    }
}
