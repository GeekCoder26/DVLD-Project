using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace DVLD_DataAccessLayer
{
    public class clsLicenseClassesData
    {


        public static bool Find(int LicenseClassID, ref string ClassName, ref string ClassDesciption, ref byte MinimumAllowedAge,
            ref byte DefaultValidityLength, ref decimal ClassFees)
        {
            bool IsFound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_FindLicenseClassesByID", connection))
                {

                    command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ClassName = (string)reader["ClassName"];
                                ClassDesciption = (string)reader["ClassDescription"];
                                MinimumAllowedAge = (byte)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (byte)reader["DefaultValidityLength"];
                                ClassFees = (decimal)reader["ClassFees"];
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



        public static bool Find(string ClassName, ref int LicenseClassID,  ref string ClassDescription, ref byte MinimumAllowedAge,
            ref byte DefaultValidityLength, ref decimal ClassFees)
        {
            bool IsFound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_FindLicenseClassesByClassname", connection))
                {

                    command.Parameters.AddWithValue("@Classname", ClassName);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {

                                LicenseClassID = (int)reader["LicenseClassID"];
                                ClassDescription = (string)reader["ClassDescription"];
                                MinimumAllowedAge = (byte)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (byte)reader["DefaultValidityLength"];
                                ClassFees = (decimal)reader["ClassFees"];
                               
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


        public static bool GetLicenseClassInfoByID(int LicenseClassID,
          ref string ClassName, ref string ClassDescription, ref byte MinimumAllowedAge,
          ref byte DefaultValidityLength, ref decimal ClassFees)
        {
            bool isFound = false;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetLicenseClassInfoByID", connection))
                {

                    command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {
                                // The record was found
                                isFound = true;

                                ClassName = (string)reader["ClassName"];
                                ClassDescription = (string)reader["ClassDescription"];
                                MinimumAllowedAge = (byte)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (byte)reader["DefaultValidityLength"];
                                ClassFees = Convert.ToDecimal(reader["ClassFees"]);

                            }
                            else
                            {
                                // The record was not found
                                isFound = false;
                            }
                        }




                    }
                    catch (Exception ex)
                    {
                        //Console.WriteLine("Error: " + ex.Message);
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isFound = false;
                    }
                }

            }



                return isFound;
        }


        public static bool GetLicenseClassInfoByClassName(string ClassName, ref int LicenseClassID,
            ref string ClassDescription, ref byte MinimumAllowedAge,
           ref byte DefaultValidityLength, ref decimal ClassFees)
        {
            bool isFound = false;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetLicenseClassInfoByClassName", connection))
                {

                    command.Parameters.AddWithValue("@ClassName", ClassName);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {
                                // The record was found
                                isFound = true;
                                LicenseClassID = (int)reader["LicenseClassID"];
                                ClassDescription = (string)reader["ClassDescription"];
                                MinimumAllowedAge = (byte)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (byte)reader["DefaultValidityLength"];
                                ClassFees = Convert.ToDecimal(reader["ClassFees"]);

                            }
                            else
                            {
                                // The record was not found
                                isFound = false;
                            }
                        }




                    }
                    catch (Exception ex)
                    {
                        //Console.WriteLine("Error: " + ex.Message);
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isFound = false;
                    }
                }

            }



                return isFound;
        }



        public static DataTable GetAllLicenseClasses()
        {

            DataTable dt = new DataTable();
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetAllLicenseClasses", connection))
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
                        // Console.WriteLine("Error: " + ex.Message);
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }
                
            }
            return dt;

        }

        public static int AddNewLicenseClass(string ClassName, string ClassDescription,
            byte MinimumAllowedAge, byte DefaultValidityLength, decimal ClassFees)
        {
            int LicenseClassID = -1;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {



                using (SqlCommand command = new SqlCommand("SP_AddNewLicenseClass", connection))
                {

                    command.Parameters.AddWithValue("@ClassName", ClassName);
                    command.Parameters.AddWithValue("@ClassDescription", ClassDescription);
                    command.Parameters.AddWithValue("@MinimumAllowedAge", MinimumAllowedAge);
                    command.Parameters.AddWithValue("@DefaultValidityLength", DefaultValidityLength);
                    command.Parameters.AddWithValue("@ClassFees", ClassFees);

                    command.CommandType = CommandType.StoredProcedure;

                    var outParam = new SqlParameter("@LicenseClassID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(outParam);

                    try
                    {
                        connection.Open();

                        command.ExecuteNonQuery();

                        if (outParam.Value != DBNull.Value && outParam.Value != null)
                        {
                            LicenseClassID = (int)outParam.Value;
                            // ...
                        }
                    }

                    catch (Exception ex)
                    {
                        //Console.WriteLine("Error: " + ex.Message);
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);

                    }
                }

            }




                return LicenseClassID;

        }

        public static bool UpdateLicenseClass(int LicenseClassID, string ClassName,
            string ClassDescription,
            byte MinimumAllowedAge, byte DefaultValidityLength, decimal ClassFees)
        {

            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_UpdateLicenseClass", connection))
                {

                    command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);
                    command.Parameters.AddWithValue("@ClassName", ClassName);
                    command.Parameters.AddWithValue("@ClassDescription", ClassDescription);
                    command.Parameters.AddWithValue("@MinimumAllowedAge", MinimumAllowedAge);
                    command.Parameters.AddWithValue("@DefaultValidityLength", DefaultValidityLength);
                    command.Parameters.AddWithValue("@ClassFees", ClassFees);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();
                        rowsAffected = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        //Console.WriteLine("Error: " + ex.Message);
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

            }



                return (rowsAffected > 0);
        }


    }
}
