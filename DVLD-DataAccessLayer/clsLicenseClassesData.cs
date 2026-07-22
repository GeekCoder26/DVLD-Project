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


        public static bool Find(int LicenseClassID, ref string ClassName, ref string ClassDesciption, ref short MinimumAllowedAge,
            ref short DefaultValidityLength, ref float ClassFees)
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
                                ClassDesciption = (string)reader["ClassDesciption"];
                                MinimumAllowedAge = (short)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (short)reader["DefaultValidityLength"];
                                ClassFees = (float)reader["ClassFees"];
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



        public static bool Find(string ClassName, ref int LicenseClassID,  ref string ClassDesciption, ref short MinimumAllowedAge,
            ref short DefaultValidityLength, ref float ClassFees)
        {
            bool IsFound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_FindLicenseClassesByClassname", connection))
                {

                    command.Parameters.AddWithValue("@ClassName", ClassName);

                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            if (reader.Read())
                            {

                                LicenseClassID = (int)reader["LicenseClassID"];
                                ClassDesciption = (string)reader["ClassDesciption"];
                                MinimumAllowedAge = (short)reader["MinimumAllowedAge"];
                                DefaultValidityLength = (short)reader["DefaultValidityLength"];
                                ClassFees = (float)reader["ClassFees"];
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


    }
}
