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

            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from TestAppointments where TestAppointmentID = @TestAppointmentID";

            SqlCommand command = new SqlCommand(Query, Connection);

            command.Parameters.AddWithValue("@TestAppointmentID", TestappointmentID);

            bool Isfound = true;
            try
            {

                Connection.Open();

                SqlDataReader Reader = command.ExecuteReader();

                if(Reader.Read())
                {

                    TestTypeID = (int)Reader["TestTypeID"];
                    LocalDrivingLicenseApplicationID = (int)Reader["LocalDrivingLicenseApplicationID"];
                    AppointmentDate = (DateTime)Reader["AppointmentDate"];
                    PaidFees = (float)Reader["PaidFees"];
                    UserID = (int)Reader["UserID"];
                    IsLocked = (bool)Reader["IsLocked"];
                    if (Reader["RetakeTestAppointmentID"] != null)
                    {
                        RetakeTestAppointmentID = (int)Reader["RetakeTestAppointmentID"];
                    }
                    else
                    {
                        RetakeTestAppointmentID = 0;
                    }

                }
                else
                {
                    Isfound = false;
                }
                    Reader.Close();


            }
            catch (Exception ex)
            {
                Isfound = false;

            }
            finally
            {
                Connection.Close();
            }
            return Isfound;


        }
        public static bool GetLastTestAppointment(int LocalDrivingLicenseApplicationID, int TestTypeID, ref int TestAppointmentID, ref DateTime AppointmentDate,
            ref float PaidFees, ref int UserID, ref bool IsLocked, ref int RetakeTestAppointmentID)
        {

            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"SELECT TOP 1 * FROM TestAppointments 
                             where TestTypeID = @TestTypeID
                             and LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID
                             order by TestAppointmentID desc";

            SqlCommand command = new SqlCommand(Query, Connection);

            command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
            command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);

            bool Isfound = true;
            try
            {

                Connection.Open();

                SqlDataReader Reader = command.ExecuteReader();

                if (Reader.Read())
                {
                    TestAppointmentID = (int)Reader["TestAppointmentID"];
                    AppointmentDate = (DateTime)Reader["AppointmentDate"];
                    PaidFees = (float)Reader["PaidFees"];
                    UserID = (int)Reader["UserID"];
                    IsLocked = (bool)Reader["IsLocked"];
                    if (Reader["RetakeTestAppointmentID"] != null)
                    {
                        RetakeTestAppointmentID = (int)Reader["RetakeTestAppointmentID"];
                    }
                    else
                    {
                        RetakeTestAppointmentID = 0;
                    }

                }
                else
                {
                    Isfound = false;
                }
                Reader.Close();


            }
            catch (Exception ex)
            {
                Isfound = false;

            }
            finally
            {
                Connection.Close();
            }
            return Isfound;





        }
        public static DataTable GetAllTestAppointment()
        {

            DataTable dt = new DataTable();

            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from TestAppointments_View";

            SqlCommand command = new SqlCommand(Query, Connection);

            try
            {
                Connection.Open();

                SqlDataReader Reader = command.ExecuteReader();

                if(Reader.HasRows)
                {
                    dt.Load(Reader);
                }
               
                Reader.Close();


            }
            catch(Exception ex) 

            {
             
            }
            finally
            {
                Connection.Close();

            }
            return dt;
        }
        public static DataTable GetApplicationTestAppointmentPerTestType(int TestTypeID, int LocalDrivingLicenseApplicationID)
        {
            DataTable Dt = new DataTable();

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Select TestAppointments.TestAppointmentID, TestAppointments.AppointmentDate, TestAppointments.PaidFees, TestAppointments.IsLocked
                              from TestAppointments 
                              Where (TestTypeID = @TestTypeID) and (LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID)
                              Order by TestAppointmentID Desc";
            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
            command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);

            try
            {
                connection.Open();

                SqlDataReader Reader = command.ExecuteReader();

                if (Reader.HasRows)
                {
                    Dt.Load(Reader);
                }

                Reader.Close();


            }
            catch (Exception ex)

            {

            }
            finally
            {
                connection.Close();

            }
            return Dt;

        }


        public static int AddNewTestAppointment(int TestTypeID,  int LocalDrivingLicenseApplicationID,  DateTime AppointmentDate,
             float PaidFees,  int UserID,  bool IsLocked,  int RetakeTestAppointmentID)
        {

            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"insert into TestAppointment (TestTypeID, LocalDrivingLicenseApplicationID, AppointmentDate, PaidFees, UserID, IsLocked, RetakeTestAppointmentID)
                                         Values (@TestTypeID, @LocalDrivingLicenseApplicationID, @AppointmentDate, @PaidFees, @UserID, @IsLocked, @RetakeTestAppointmentID)
                                         Select Scope_Identity();";

            SqlCommand command = new SqlCommand(Query, Connection);

            command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
            command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
            command.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
            command.Parameters.AddWithValue("@PaidFees", PaidFees);
            command.Parameters.AddWithValue("@UserID", UserID);
            command.Parameters.AddWithValue("@IsLocked", IsLocked);
            command.Parameters.AddWithValue("@RetakeTestAppointmentID", RetakeTestAppointmentID);

            int TestAppointmentID = -1;
            try
            {
                Connection.Open();

                object Result = command.ExecuteScalar();

                if(Result != null && int.TryParse(Result.ToString(), out int ReturnedID))
                {
                    TestAppointmentID = ReturnedID;
                }

            }
            catch (Exception ex)
            {

            }
            finally
            {
                Connection.Close();
            }
            return TestAppointmentID;

        }


        public static bool UpdateTestAppointment(int TestTypeID, int LocalDrivingLicenseApplicationID, DateTime AppointmentDate,
             float PaidFees, int UserID, bool IsLocked, int RetakeTestAppointmentID)
        {
            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Update TestAppointments 
                             Set 
                             TestTypeID = @TestTypeID,
                             LocalDrivingLicenseApplicationID = @LocalDrivingLicenseApplicationID,
                             AppointmentDate = @AppointmentDate,
                             PaidFees = @PaidFees,
                             UserID = @UserID,
                             IsLocked = @IsLocked,
                             RetakeTestAppointmentID = @RetakeTestAppointmentID
                             Where TestAppointmentID = @TestAppointmentID;";

            SqlCommand command = new SqlCommand(Query, Connection);

            command.Parameters.AddWithValue("@TestTypeID", TestTypeID);
            command.Parameters.AddWithValue("@LocalDrivingLicenseApplicationID", LocalDrivingLicenseApplicationID);
            command.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
            command.Parameters.AddWithValue("@PaidFees", PaidFees);
            command.Parameters.AddWithValue("@UserID", UserID);
            command.Parameters.AddWithValue("@IsLocked", IsLocked);
            command.Parameters.AddWithValue("@RetakeTestAppointmentID", RetakeTestAppointmentID);

            int EffectedRows = 0;
            try
            {
                Connection.Open();

                EffectedRows = command.ExecuteNonQuery();

          
            }
            catch (Exception ex)
            {

            }
            finally
            {
                Connection.Close();
            }
            return (EffectedRows > 0);
        }


        public static int GetTestID(int TestAppointmentID)
        {
            SqlConnection Connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Select TestID from Tests Where TestAppointmentID = @TestAppointmentID";

            SqlCommand command = new SqlCommand(Query, Connection);

            command.Parameters.AddWithValue("@TestAppointmentID", TestAppointmentID);

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

            }
            finally
            {
                Connection.Close();
            }
            return TestAppointmentID;
        }


    }
}
