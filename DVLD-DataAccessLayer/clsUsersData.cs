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

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"select * from Users";

            SqlCommand command = new SqlCommand(Query, connection);

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

            }
            finally
            {
                connection.Close();
            }

            return dt;

        }

        public static int AddUser(int PersonID, string Username, string Password, bool isActive)
        {
            int UserID = -1;

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"insert into Users (PersonID, Username, Password, IsActive )
                             values (@PersonID, @Username, @Password, @IsActive);
                                select Scope_Identity();";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", PersonID);
            command.Parameters.AddWithValue("@Username", Username);
            command.Parameters.AddWithValue("@Password", Password);
            command.Parameters.AddWithValue("@IsActive", isActive);

            try
            {
                connection.Open();

                object result = command.ExecuteScalar();

                if (result != null && int.TryParse(result.ToString(), out int ReturnedID))
                {
                    UserID = ReturnedID;
                }



            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }
            return UserID;
        }

        public static bool UpdateUSer(int UserID, string Username, string Password, bool isActive)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"Update Users
                             set Username = @Username,
                                 Password = @Password,
                                 Isactive = @IsActive
                             Where UserID = @UserID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@Username", Username);
            command.Parameters.AddWithValue("@Password", Password);
            command.Parameters.AddWithValue("@IsActive", isActive);
            command.Parameters.AddWithValue("@UserID", UserID);

            int EffectedRows = 0;

            try
            {
                connection.Open();

                EffectedRows = command.ExecuteNonQuery();


            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return (EffectedRows > 0);
        }

        public static bool DeleteUser(int UserID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "delete Users Where UserID = @UserID;";

            SqlCommand command = new SqlCommand( Query, connection);

            command.Parameters.AddWithValue("@UserID", UserID);

            int affectedrows = 0;

            try
            {
                connection.Open();

                affectedrows = command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return (affectedrows > 0);

        }

        public static bool FindUser(int UserID, ref int PersonID, ref string Username,ref string Password, ref bool IsActive)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from users where Userid = @Userid";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@Userid", UserID);

            bool isfound = true;

            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if(reader.Read())
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
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }


            return isfound;
        }

        public static bool FindUser(string Username, ref int PersonID, ref int UserID, ref string Password, ref bool IsActive)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select * from users where Username = @Username";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@Username", Username);

            bool isfound = true;

            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

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
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }


            return isfound;
        }

        public static bool IsUserExist(int UserID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select found= 1 from Users where UserID = @UserID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@UserID", UserID);

            bool isfound = true;

            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    isfound = true;
                }
                else
                {
                    isfound = false;
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            { 
                connection.Close();
            }
            return isfound;
        }

        public static bool IsUserExist(string Username)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select found= 1 from Users where Username = @Username";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@Username", Username);

            bool isfound = true;

            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    isfound = true;
                }
                else
                {
                    isfound = false;
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }
            return isfound;
        }

        public static bool IsUserExistByPersonID(int PersonID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "select found= 1 from Users where PersonID = @PersonID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", PersonID);

            bool isfound = true;

            try
            {

                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    isfound = true;
                }
                else
                {
                    isfound = false;
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                isfound = false;
            }
            finally
            {
                connection.Close();
            }

            return isfound;
        }










    }

}
