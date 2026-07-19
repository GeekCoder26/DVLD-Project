using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DVLD_DataAccessLayer
{
    public class clsUsersData
    {

        public static DataTable GetAllUsers()
        {
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_GetAllUsers", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
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
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                    }
                }

                
            }
            return dt;

        }

        public static int AddUser(int PersonID, string Username, string Password, bool isActive)
        {
            

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {

                using (SqlCommand command = new SqlCommand("SP_AddNewUser", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);
                    command.Parameters.AddWithValue("@Username", Username);
                    command.Parameters.AddWithValue("@Password", Password);
                    command.Parameters.AddWithValue("@IsActive", isActive);

                    command.CommandType = CommandType.StoredProcedure;

                    var outParam = new SqlParameter("@UserID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(outParam);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        var result = command.Parameters["@PersonID"].Value;
                        if (result == null || result == DBNull.Value) return -1;
                        return Convert.ToInt32(result);



                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return -1;
                    }
                }

                
            }

            

        }

        public static bool UpdateUSer(int UserID, string Username, string Password, bool isActive)
        {
            int EffectedRows = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_UpdateUsers", connection))
                {
                    command.Parameters.AddWithValue("@Username", Username);
                    command.Parameters.AddWithValue("@Password", Password);
                    command.Parameters.AddWithValue("@IsActive", isActive);
                    command.Parameters.AddWithValue("@UserID", UserID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        EffectedRows = command.ExecuteNonQuery();


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

               
            }
            return (EffectedRows > 0);
        }

        public static bool DeleteUser(int UserID)
        {
            int affectedrows = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_DeleteUser", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@UserID", UserID);


                    try
                    {
                        connection.Open();

                        affectedrows = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

                
            }
            return (affectedrows > 0);

        }

        public static bool FindUser(int UserID, ref int PersonID, ref string Username,ref string Password, ref bool IsActive)
        {

            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("FindUserByUserID", connection))
                {
                    command.Parameters.AddWithValue("@Userid", UserID);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                PersonID = (int)reader["PersonID"];
                                Username = (string)reader["Username"];
                                Password = (string)reader["Password"];
                                IsActive = (bool)reader["IsActive"];
                            }
                            else
                            {
                                isfound = false;
                            }
                        }

                        


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isfound = false;
                    }
                }

                
            }
            return isfound;
        }

        public static bool FindUser(string Username, ref int PersonID, ref int UserID, ref string Password, ref bool IsActive)
        {

            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_FindUserByUsername", connection))
                {
                    command.Parameters.AddWithValue("@Username", Username);


                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                UserID = (int)reader["UserID"];
                                PersonID = (int)reader["PersonID"];
                                Password = (string)reader["Password"];
                                IsActive = (bool)reader["IsActive"];
                            }
                            else
                            {
                                isfound = false;
                            }
                        }

                        


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        isfound = false;
                    }
                }

               
            }

            return isfound;



        }

        public static bool IsUserExist(int UserID)
        {
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsUserExists", connection))
                {
                    command.Parameters.AddWithValue("@UserID", UserID);
                    command.CommandType = CommandType.StoredProcedure;

                    int isfound = 0;

                    try
                    {

                        connection.Open();

                        isfound = (int)command.ExecuteScalar();

                        return isfound > 0;


                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

            }

        }

        public static bool IsUserExist(string Username)
        {
            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsUserExistsByUsername", connection))
                {
                    command.Parameters.AddWithValue("@Username", Username);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                isfound = true;
                            }
                            else
                            {
                                isfound = false;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        isfound = false;
                    }
                }

                
            }
            return isfound;



        }

        public static bool IsUserExistByPersonID(int PersonID)
        {
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsUserExistsByPersonID", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);

                    command.CommandType = CommandType.StoredProcedure;

                    int isfound = 0;

                    try
                    {

                        connection.Open();

                        isfound = (int)command.ExecuteScalar();

                        return isfound > 0;

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

               
            }


            
           
        }










    }

}
