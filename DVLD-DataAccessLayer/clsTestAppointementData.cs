using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class clsTestAppointementData
    {



        public static bool GetTestappointmentInfoByID(int TestappointmentID, ref int TestTypeID, ref int LocalDrivingLicenseApplicationID, ref DateTime AppointmentDate,
            ref float PaidFees, ref int UserID, ref bool IsLocked, ref int RetakeTestAppointmentID)
        {

            bool Isfound = true;
            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetTestAppointmentInfoByID", Connection))
                {

                    command.Parameters.AddWithValue("@TestAppointmentID", TestappointmentID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        Connection.Open();

                        using (SqlDataReader Reader = command.ExecuteReader())
                        {
                            if (Reader.Read())
                            {

                                TestTypeID = (int)Reader["TestTypeID"];
                                LocalDrivingLicenseApplicationID = (int)Reader["LocalDrivingLicenseApplicationID"];
                                AppointmentDate = (DateTime)Reader["AppointmentDate"];
                                PaidFees = (float)Reader["PaidFees"];
                                UserID = (int)Reader["UserID"];
                                IsLocked = (bool)Reader["IsLocked"];
                                RetakeTestAppointmentID = Reader["RetakeTestApplicationID"] == null ? 0 : (int)Reader["RetakeTestApplicationID"];

                            }
                            else
                            {
                                Isfound = false;
                            }

                        }



                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        Isfound = false;

                    }
                }

            }



                return Isfound;


        }
        public static bool GetLastTestAppointment(int LocalDrivingLicenseApplicationID, int TestTypeID, ref int TestAppointmentID, ref DateTime AppointmentDate,
            ref float PaidFees, ref int UserID, ref bool IsLocked, ref int RetakeTestAppointmentID)
        {

            bool Isfound = true;
            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetLastTestAppointment", Connection))
                {

                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {

                        Connection.Open();

                        using (SqlDataReader Reader = command.ExecuteReader())
                        {
                            if (Reader.Read())
                            {
                                TestAppointmentID = (int)Reader["TestAppointmentID"];
                                AppointmentDate = (DateTime)Reader["AppointmentDate"];
                                PaidFees = (float)Reader["PaidFees"];
                                UserID = (int)Reader["UserID"];
                                IsLocked = (bool)Reader["IsLocked"];
                                RetakeTestAppointmentID = Reader["RetakeTestApplicationID"] == null ? 0 : (int)Reader["RetakeTestApplicationID"];


                            }
                            else
                            {
                                Isfound = false;
                            }
                        }

                        

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        Isfound = false;

                    }
                }

            }


                return Isfound;





        }
        public static DataTable GetAllTestAppointment()
        {

            DataTable dt = new DataTable();

            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetAllTestAppointment", Connection))
                {

                    try
                    {
                        Connection.Open();

                        using (SqlDataReader Reader = command.ExecuteReader())
                        {

                            if (Reader.HasRows)
                            {
                                dt.Load(Reader);
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
        public static DataTable GetApplicationTestAppointmentPerTestType(int TestTypeID, int LocalDrivingLicenseApplicationID)
        {
            DataTable Dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetApplicationTestAppointmentPerTestType", connection))
                {

                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);

                    command.CommandType = CommandType.StoredProcedure;



                    try
                    {
                        connection.Open();

                        using (SqlDataReader Reader = command.ExecuteReader())
                        {

                            if (Reader.HasRows)
                            {
                                Dt.Load(Reader);
                            }
                        }


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }



                return Dt;

        }


        public static int AddNewTestAppointment(int TestTypeID,  int LocalDrivingLicenseApplicationID,  DateTime AppointmentDate,
             float PaidFees,  int UserID,  bool IsLocked,  int RetakeTestAppointmentID)
        {

            int TestAppointmentID = -1;
            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_AddNewTestAppointment", Connection))
                {

                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
                    command.Parameters.AddWithValue("@PaidFees", PaidFees);
                    command.Parameters.AddWithValue("@UserID", UserID);
                    command.Parameters.AddWithValue("@IsLocked", IsLocked);
                    command.Parameters.AddWithValue("@RetakeTestAppointmentID", RetakeTestAppointmentID);

                    var outparam = new SqlParameter("@TestAppointmentID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(outparam);

                    try
                    {
                        Connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int ReturnedID))
                        {
                            TestAppointmentID = ReturnedID;
                        }

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }

                return TestAppointmentID;

        }


        public static bool UpdateTestAppointment(int TestTypeID, int LocalDrivingLicenseApplicationID, DateTime AppointmentDate,
             float PaidFees, int UserID, bool IsLocked, int RetakeTestAppointmentID)
        {
            int EffectedRows = 0;
            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_UpdateTestAppointment", Connection))
                {

                    command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
                    command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
                    command.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
                    command.Parameters.AddWithValue("@PaidFees", PaidFees);
                    command.Parameters.AddWithValue("@CreatedByUserID", UserID);
                    command.Parameters.AddWithValue("@IsLocked", IsLocked);
                    command.Parameters.AddWithValue("@RetakeTestApplicationID", RetakeTestAppointmentID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        Connection.Open();

                        EffectedRows = command.ExecuteNonQuery();


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }

                return (EffectedRows > 0);
        }


        public static int GetTestID(int TestAppointmentID)
        {
            using (SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetTestID", Connection))
                {

                    command.Parameters.AddWithValue("@TestAppointmentID", TestAppointmentID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        Connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int ReturnedID))
                        {
                            TestAppointmentID = ReturnedID;
                        }


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

            }


                return TestAppointmentID;
        }


    }
}
