using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class clsPersonData
    {

        public static DataTable GetAllContacts()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"SELECT PersonID, NationalNo, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Address, 
                             Phone, Email, Countries.CountryName as Nationality, ImagePath
                             FROM     People INNER JOIN Countries 
                             ON People.NationalityCountryID = Countries.CountryID;";

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
            catch(Exception ex)
            {

            }
            finally
            {
                connection.Close();

            }

            return dt;

        }



        public static int AddNewPerson(string FirstName, string SecondName, string ThirdName, string LastName,
                             DateTime DateOfBirth, bool Gendor, string Phone, string Email, string NationalNo, string Address,
                                        int NationalityCountryID, string ImagePath)
        {

            int PersonID = -1;

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"insert Into People (NationalNo, firstname, secondname, thirdname, lastname, dateofbirth,
                             gendor, address, phone, email, NationalityCountryID, imagepath)
                                values (@NationaNo, @firstname, @secondname, @thirdname, @lastname, @dateofbirth, @gendor, 
                                        @address, @phone, @email, @NationalityCountryID, @imagepath);
                                select scope_Identity();";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@NationaNo", NationalNo);
            command.Parameters.AddWithValue("@firstname", FirstName);
            command.Parameters.AddWithValue("@secondname", SecondName);
            command.Parameters.AddWithValue("@thirdname", ThirdName);
            command.Parameters.AddWithValue("@lastname", LastName);
            command.Parameters.AddWithValue("@dateofbirth", DateOfBirth);
            command.Parameters.AddWithValue("@gendor", Gendor);
            command.Parameters.AddWithValue("@address", Address);
            command.Parameters.AddWithValue("@phone", Phone);
            command.Parameters.AddWithValue("@email", Email);
            command.Parameters.AddWithValue("@NationalityCountryID", NationalityCountryID);
            if (ImagePath != "")
            {
                command.Parameters.AddWithValue("@ImagePath", ImagePath);

            }
            else
            {
                command.Parameters.AddWithValue("@ImagePath", System.DBNull.Value);
            }

            try
            {
                connection.Open();

                object result = command.ExecuteScalar();

                if(result != null && int.TryParse(result.ToString(), out int returndID))
                {
                    PersonID = returndID;
                }


            }
            catch(Exception ex)
            {

            }
            finally
            {
                connection.Close();
            }

            return PersonID;
        }


        public static bool UpdatePerson(int PersonID, string FirstName, string SecondName, string ThirdName, string LastName,
                             DateTime DateOfBirth, bool Gendor, string Phone, string Email, string NationalNo, string Address,
                                        int NationalityCountryID, string ImagePath)
        {

            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @" Update People 
                            set FirstName = @FirstName,
                                SecondName = @SecondName,
                                ThirdName = @ThirdName,
                                LastName = @LastName,
                                DateOfBirth = @DateOfBirth,
                                Gendor = @Gendor,
                                Phone = @Phone,
                                Email = @Email,
                                NationalNo = @NationalNo,
                                Address = @Address,
                                NationalityCountryID = @NationalityCountryID,
                                ImagePath = @ImagePath
                            Where PersonID = @PersonID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", PersonID);
            command.Parameters.AddWithValue("@FirstName", FirstName);
            command.Parameters.AddWithValue("@SecondName", SecondName);
            command.Parameters.AddWithValue("@ThirdName", ThirdName);
            command.Parameters.AddWithValue("@LastName", LastName);
            command.Parameters.AddWithValue("@DateOfBirth", DateOfBirth);
            command.Parameters.AddWithValue("@Gendor", Gendor);
            command.Parameters.AddWithValue("@Phone", Phone);
            command.Parameters.AddWithValue("@Email", Email);
            command.Parameters.AddWithValue("@NationalNo", NationalNo);
            command.Parameters.AddWithValue("@Address", Address);
            command.Parameters.AddWithValue("@NationalityCountryID", NationalityCountryID);
            if (ImagePath != null)
            {
                command.Parameters.AddWithValue("@ImagePath", ImagePath);
            }
            else
            {
                command.Parameters.AddWithValue("@ImagePath", System.DBNull.Value);
            }

            int RowsAffected = 0;
            try
            {
                connection.Open();

                RowsAffected = command.ExecuteNonQuery();

            }
            catch(Exception ex)
            {

            }
            finally
            {
                connection.Close();

            }

            return (RowsAffected > 0);  



        }

        public static bool DeletePerson(int PersonID)

        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"delete from People
                             where PersonID = @PersonID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", PersonID);

            int RowsAffected = 0;

            try
            {
                connection.Open();

                RowsAffected = command.ExecuteNonQuery();
            }
            catch( Exception ex )
            {

            }
            finally
            {
                connection.Close();
            }

            return (RowsAffected > 0);
        }

        public static DataTable FindPerson(string ColumnName, string Content)
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection( DataAccessSettings.connectionString);

            string Query = $@"SELECT PersonID, NationalNo, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Address, 
                             Phone, Email, Countries.CountryName as Nationality, ImagePath
                             FROM     People INNER JOIN Countries 
                              ON People.NationalityCountryID = Countries.CountryID 
                              Where {ColumnName} = @Content ";

            SqlCommand command = new SqlCommand(Query, connection);

          
            command.Parameters.AddWithValue("@Content", Content);

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

        public static bool FindPerson(int PersonID, ref string FirstName, ref string SecondName, ref string ThirdName, ref string LastName,
                                      ref DateTime DateOfBirth, ref bool Gendor, ref string Phone, ref string Email, ref string NationalNo,
                                      ref string Address, ref int NationalityCountryID, ref string ImagePath)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"select FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Phone, Email, NationalNo, Address,
                             NationalityCountryID, ImagePath from People
                             Where PersonID = @PersonID;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", PersonID);

            bool isfound = true;

            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if(reader.Read())
                {
                    FirstName = (string)reader["FirstName"];
                    SecondName = (string)reader["SecondName"];
                    if (reader["ThirdName"] != DBNull.Value)
                    {
                        ThirdName = (string)reader["ThirdName"];
                    }
                    else
                    {
                        ThirdName = "";
                    }
                    LastName = (string)reader["LastName"];
                    DateOfBirth = (DateTime)reader["DateOfBirth"];
                    Gendor = Convert.ToBoolean(reader["Gendor"]);
                    Phone = (string)reader["Phone"];
                    if (reader["Email"] != DBNull.Value)
                    {
                        Email = (string)reader["Email"];
                    }
                    else
                    {
                        Email = "";
                    }

                    NationalNo = (string)reader["NationalNo"];
                    Address = Convert.ToString(reader["Address"]);
                    NationalityCountryID = (int)reader["NationalityCountryID"];

                    if (reader["ImagePath"] != DBNull.Value)
                    {
                        ImagePath = (string)reader["ImagePath"];
                    }
                    else
                    {
                        ImagePath = "";
                    }

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

        public static bool FindPerson(string NationalNo, ref int PersonID, ref string FirstName, ref string SecondName, ref string ThirdName, ref string LastName,
                                     ref DateTime DateOfBirth, ref bool Gendor, ref string Phone, ref string Email,
                                     ref string Address, ref int NationalityCountryID, ref string ImagePath)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = @"select PersonID, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gendor, Phone, Email, NationalNo, Address,
                             NationalityCountryID, ImagePath from People
                             Where NationalNo = @NationalNo;";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@NationalNo", NationalNo);

            bool isfound = true;

            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    PersonID = (int)reader["PersonID"];
                    FirstName = (string)reader["FirstName"];
                    SecondName = (string)reader["SecondName"];
                    if (reader["ThirdName"] != DBNull.Value)
                    {
                        ThirdName = (string)reader["ThirdName"];
                    }
                    else
                    {
                        ThirdName = "";
                    }
                    LastName = (string)reader["LastName"];
                    DateOfBirth = (DateTime)reader["DateOfBirth"];
                    Gendor = Convert.ToBoolean(reader["Gendor"]);
                    Phone = (string)reader["Phone"];
                    if (reader["Email"] != DBNull.Value)
                    {
                        Email = (string)reader["Email"];
                    }
                    else
                    {
                        Email = "";
                    }

                    NationalNo = (string)reader["NationalNo"];
                    Address = Convert.ToString(reader["Address"]);
                    NationalityCountryID = (int)reader["NationalityCountryID"];

                    if (reader["ImagePath"] != DBNull.Value)
                    {
                        ImagePath = (string)reader["ImagePath"];
                    }
                    else
                    {
                        ImagePath = "";
                    }
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


        public static bool IsPersonExist(string NationalNo)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "Select * from People Where NationalNo = @NationalNo";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@NationalNo", NationalNo);

            bool isfound = true;
            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    isfound = true;
                }
                

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

        public static bool IsPersonExist(int ID)
        {
            SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString);

            string Query = "Select * from People Where PersonID = @PersonID";

            SqlCommand command = new SqlCommand(Query, connection);

            command.Parameters.AddWithValue("@PersonID", ID);

            bool isfound = true;
            try
            {
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    isfound = true;
                }


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
