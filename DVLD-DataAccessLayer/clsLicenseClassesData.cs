using System;
using System.Collections.Generic;
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
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from LicenseClasses where LicenseClassID = @LicenseClassID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@LicenseClassID", LicenseClassID);

            bool IsFound = true;
            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                ClassName = (string)reader["ClassName"];
                ClassDesciption = (string)reader["ClassDesciption"];
                MinimumAllowedAge = (short)reader["MinimumAllowedAge"];
                DefaultValidityLength = (short)reader["DefaultValidityLength"];
                ClassFees = (float)reader["ClassFees"];
     

            }
            catch (Exception ex)
            {
                IsFound = false;
            }
            finally
            {
                connection.Close();
            }
            return IsFound;
        }



        public static bool Find(string ClassName, ref int LicenseClassID,  ref string ClassDesciption, ref short MinimumAllowedAge,
            ref short DefaultValidityLength, ref float ClassFees)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from LicenseClasses Where ClassName = @ClassName;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@ClassName", ClassName);

            bool IsFound = true;
            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                LicenseClassID = (int)reader["LicenseClassID"];
                ClassDesciption = (string)reader["ClassDesciption"];
                MinimumAllowedAge = (short)reader["MinimumAllowedAge"];
                DefaultValidityLength = (short)reader["DefaultValidityLength"];
                ClassFees = (float)reader["ClassFees"];


            }
            catch (Exception ex)
            {
                IsFound = false;
            }
            finally
            {
                connection.Close();
            }
            return IsFound;
        }


    }
}
