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

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from Applications;";

            SqlCommand command = new SqlCommand(Query, connection);


            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if(reader.HasRows)
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

        public static int AddNewApplication(int PersonID, DateTime ApplicationDate, int ApplicationTypeID,
                                            byte ApplicationStatus, DateTime LastStatusDate, float PaidFees,
                                            int UserID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"insert into Applications (ApplicantPersonID, ApplicationDate, ApplicationTypeID, ApplicationStatus, LastStatusDate, PaidFees, CreatedByUserID)
                             Values (@ApplicantPersonID, @ApplicationDate, @ApplicationTypeID, @ApplicationStatus, @LastStatusDate, @PaidFees, @CreatedByUserID)
                             Select Scope_Identity();";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
            command.Parameters.AddWithValue("@ApplicationDate", ApplicationDate);
            command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
            command.Parameters.AddWithValue("@ApplicationStatus", ApplicationStatus);
            command.Parameters.AddWithValue("@LastStatusDate", LastStatusDate);
            command.Parameters.AddWithValue("@PaidFees", PaidFees);
            command.Parameters.AddWithValue("@CreatedByUserID", UserID);

            int ApplicationID = -1;

            try
            {
                connection.Open();

                object result = command.ExecuteScalar();

                if(result != null && int.TryParse(result.ToString(), out int ReturnedID))
                {
                    ApplicationID = ReturnedID;
                }


            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return ApplicationID;

        }

        public static bool UpdateApplication(int ApplicationID, int PersonID, DateTime ApplicationDate,
                                             int ApplicationTypeID, byte ApplicationStatus,
                                             DateTime LastStatusDate, float PaidFees, int UserID)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Update Applications
                             Set ApplicantPersonID = @ApplicantPersonID,
                                 ApplicationDate = @ApplicationDate, 
                                 ApplicationTypeID = @ApplicationTypeID,
                                 ApplicationStatus = @ApplicationStatus, 
                                 LastStatusDate = @LastStatusDate, 
                                 PaidFees = @PaidFees, 
                                 CreatedByUserID = @CreatedByUserID
                                 Where ApplicationID = @ApplicationID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
            command.Parameters.AddWithValue("@ApplicationDate", ApplicationDate);
            command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
            command.Parameters.AddWithValue("@ApplicationStatus", ApplicationStatus);
            command.Parameters.AddWithValue("@LastStatusDate", LastStatusDate);
            command.Parameters.AddWithValue("@PaidFees", PaidFees);
            command.Parameters.AddWithValue("@CreatedByUserID", UserID);
            command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

            int RowsAffected = 0;
            try
            {
                connection.Open();

                RowsAffected = command.ExecuteNonQuery();

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
        public static bool DeleteApplication(int ApplicationID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Delete Applications Where ApplicationID = @ApplicationID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

            int RowsAffected = 0;
            try
            {
                connection.Open();

                RowsAffected = command.ExecuteNonQuery();

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

        public static bool FindApplication(int ApplicationID, ref int PersonID, ref DateTime ApplicationDate,
                                           ref int ApplicationTypeID, ref byte ApplicationStatus,ref DateTime LastStatusDate,
                                           ref float PaidFees, ref int UserID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Select * from Applications Where ApplicationID = @ApplicationID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

            bool IsFound = true;
            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                PersonID = (int)reader["ApplicantPersonID"];
                ApplicationDate = (DateTime)reader["ApplicationDate"];
                ApplicationTypeID = (int)reader["ApplicationTypeID"];
                ApplicationStatus = (byte)reader["ApplicationStatus"];
                LastStatusDate = (DateTime)reader["LastStatusDate"];
                PaidFees = (float)reader["PaidFees"];
                UserID = (int)reader["CreatedByUserID"];

            }
            catch(Exception ex)
            {
                IsFound = false;
            }
            finally
            {
                connection.Close();
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

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"select ActiveApplicationID= ApplicationID from Applications 
                             where ApplicantPersonID =@ApplicantPersonID and ApplicationTypeID = @ApplicationTypeID 
                             and ApplicationStatus = 1";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
            command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
            bool isfound = false;
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

            }
            finally
            {
                connection.Close();
            }
            return ActiveApplicationID;

        }

        public static int GetActiveApplicationIDForLicenseClass(int PersonID, int ApplicationTypeID, int LicenseClassID)
        {
            int ActiveAppApplicationID = -1;

            SqlConnection connection = new SqlConnection (DataAccessSettings.connectionString);

            string Query = @"@""SELECT ActiveApplicationID=Applications.ApplicationID  
                            From
                            Applications INNER JOIN
                            LocalDrivingLicenseApplications ON Applications.ApplicationID = LocalDrivingLicenseApplications.ApplicationID
                            WHERE ApplicantPersonID = @ApplicantPersonID 
                            and ApplicationTypeID=@ApplicationTypeID 
							and LocalDrivingLicenseApplications.LicenseClassID = @LicenseClassID
                            and ApplicationStatus=1";

            SqlCommand command = new SqlCommand (Query, connection);

            command.Parameters.AddWithValue("@ApplicantPersonID", PersonID);
            command.Parameters.AddWithValue("@ApplicationTypeID", ApplicationTypeID);
            command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);

            try
            {

                connection.Open();

                object Result = command.ExecuteScalar();

                if(Result != null && int.TryParse(Result.ToString(), out int AppID))
                {
                    ActiveAppApplicationID = AppID;
                }

            }
            catch(Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }
            return ActiveAppApplicationID;


        }

        public static bool UpdateStatus(int ApplicationID, short Status)
        {
            int RowsAffected = 0;

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"update Applications
                             set
                             ApplicationStatus = @ApplicationStatus,
                             LastStatusDate = @LastStatusDate,
                             where ApplicationID = @ApplicationID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ApplicationStatus", Status);
            command.Parameters.AddWithValue("@LastStatusDate", DateTime.Now);
            command.Parameters.AddWithValue("@ApplicationID", ApplicationID);

            try
            {
                connection.Open();

                RowsAffected = command.ExecuteNonQuery();


            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return RowsAffected > 0;

        }

    }
}
