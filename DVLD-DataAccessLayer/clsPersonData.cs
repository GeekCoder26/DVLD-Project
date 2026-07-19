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

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_GetAllPeople", connection))
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
                            reader.Close();
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



        public static int AddNewPerson(string FirstName, string SecondName, string ThirdName, string LastName,
                             DateTime DateOfBirth, bool Gendor, string Phone, string Email, string NationalNo, string Address,
                                        int NationalityCountryID, string ImagePath)
        {

            //int PersonID = -1;

            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_AddNewPerson", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.Parameters.AddWithValue("@firstname", FirstName);
                    command.Parameters.AddWithValue("@secondname", SecondName);
                    command.Parameters.AddWithValue("@thirdname", ThirdName);
                    command.Parameters.AddWithValue("@lastname", LastName);
                    command.Parameters.AddWithValue("@dateofbirth", DateOfBirth);
                    command.Parameters.AddWithValue("@gender", Gendor);
                    command.Parameters.AddWithValue("@address", Address);
                    command.Parameters.AddWithValue("@phone", Phone);
                    command.Parameters.AddWithValue("@email", Email);
                    command.Parameters.AddWithValue("@NationalityCountryID", NationalityCountryID);
                    command.Parameters.AddWithValue("@ImagePath", string.IsNullOrEmpty(ImagePath) ? DBNull.Value : (object)ImagePath);

                    var outParam = new SqlParameter("@PersonID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    command.Parameters.Add(outParam);

                    try
                    {
                        connection.Open();

                        command.ExecuteNonQuery();
                        var result = command.Parameters["@PersonID"].Value;
                        if (result == null || result == DBNull.Value) return 0;
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


        public static bool UpdatePerson(int PersonID, string FirstName, string SecondName, string ThirdName, string LastName,
                             DateTime DateOfBirth, bool Gendor, string Phone, string Email, string NationalNo, string Address,
                                        int NationalityCountryID, string ImagePath)
        {
            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_UpdatePerson", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);
                    command.Parameters.AddWithValue("@FirstName", FirstName);
                    command.Parameters.AddWithValue("@SecondName", SecondName);
                    command.Parameters.AddWithValue("@ThirdName", ThirdName);
                    command.Parameters.AddWithValue("@LastName", LastName);
                    command.Parameters.AddWithValue("@DateOfBirth", DateOfBirth);
                    command.Parameters.AddWithValue("@Gender", Gendor);
                    command.Parameters.AddWithValue("@Phone", Phone);
                    command.Parameters.AddWithValue("@Email", Email);
                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.Parameters.AddWithValue("@Address", Address);
                    command.Parameters.AddWithValue("@NationalityCountryID", NationalityCountryID);
                    command.Parameters.AddWithValue("@ImagePath", string.IsNullOrEmpty(ImagePath) ? DBNull.Value : (object)ImagePath);

                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

            }

            return (RowsAffected > 0);  

        }

        public static bool DeletePerson(int PersonID)

        {
            int RowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_DeletePerson", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        ExceptionEventLog.RegiterErrorToLogRegitry(ex);
                        return false;
                    }
                }

                
            }
            return (RowsAffected > 0);
        }

        //public static DataTable FindPerson(string ColumnName, string Content)
        //{
        //    DataTable dt = new DataTable();

        //    SqlConnection connection = new SqlConnection( DataAccessSettings.connectionString);

        //    string Query = $@"SELECT PersonID, NationalNo, FirstName, SecondName, ThirdName, LastName, DateOfBirth, Gender, Address, 
        //                     Phone, Email, Countries.CountryName as Nationality, ImagePath
        //                     FROM     People INNER JOIN Countries 
        //                      ON People.NationalityCountryID = Countries.CountryID 
        //                      Where {ColumnName} = @Content ";

        //    SqlCommand command = new SqlCommand(Query, connection);

          
        //    command.Parameters.AddWithValue("@Content", Content);

        //    try
        //    {
        //        connection.Open();

        //        SqlDataReader reader = command.ExecuteReader();

        //        if(reader.HasRows)
        //        {
        //            dt.Load(reader);
        //        }
        //        reader.Close();

        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    finally
        //    {
        //        connection.Close();
        //    }

        //    return dt;
        //}

        public static bool FindPerson(int PersonID, ref string FirstName, ref string SecondName, ref string ThirdName, ref string LastName,
                                      ref DateTime DateOfBirth, ref bool Gendor, ref string Phone, ref string Email, ref string NationalNo,
                                      ref string Address, ref int NationalityCountryID, ref string ImagePath)
        {
            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_FindPersonByPersonID", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);

                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                FirstName = (string)reader["FirstName"];
                                SecondName = (string)reader["SecondName"];
                                ThirdName = reader["ThirdName"] != DBNull.Value ? (string)reader["ThirdName"] : string.Empty;
                                LastName = (string)reader["LastName"];
                                DateOfBirth = (DateTime)reader["DateOfBirth"];
                                Gendor = Convert.ToBoolean(reader["Gender"]);
                                Phone = (string)reader["Phone"];
                                Email = reader["Email"] != DBNull.Value ? (string)reader["Email"] : string.Empty;
                                NationalNo = (string)reader["NationalNo"];
                                Address = Convert.ToString(reader["Address"]);
                                NationalityCountryID = (int)reader["NationalityCountryID"];
                                ImagePath = reader["ImagePath"] != DBNull.Value ? (string)reader["ImagePath"] : string.Empty;

                            }
                            else
                            {
                                isfound = false;
                            }

                            reader.Close();
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

        public static bool FindPerson(string NationalNo, ref int PersonID, ref string FirstName, ref string SecondName, ref string ThirdName, ref string LastName,
                                     ref DateTime DateOfBirth, ref bool Gendor, ref string Phone, ref string Email,
                                     ref string Address, ref int NationalityCountryID, ref string ImagePath)
        {
            bool isfound = true;
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_FindPersonByNationalNo", connection))
                {

                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.CommandType = CommandType.StoredProcedure;


                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                PersonID = (int)reader["PersonID"];
                                FirstName = (string)reader["FirstName"];
                                SecondName = (string)reader["SecondName"];
                                ThirdName = reader["ThirdName"] != DBNull.Value ? (string)reader["ThirdName"] : string.Empty;

                                LastName = (string)reader["LastName"];
                                DateOfBirth = (DateTime)reader["DateOfBirth"];
                                Gendor = Convert.ToBoolean(reader["Gender"]);
                                Phone = (string)reader["Phone"];
                                Email = reader["Email"] != DBNull.Value ? (string)reader["Email"] : string.Empty;


                                NationalNo = (string)reader["NationalNo"];
                                Address = Convert.ToString(reader["Address"]);
                                NationalityCountryID = (int)reader["NationalityCountryID"];
                                ImagePath = reader["ImagePath"] != DBNull.Value ? (string)reader["ImagePath"] : string.Empty;

                            }
                            else
                            {
                                isfound = false;
                            }
                            reader.Close();
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


        public static bool IsPersonExist(string NationalNo)
        {
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsPersonExistByNationalNo", connection))
                {

                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.CommandType = CommandType.StoredProcedure;

                    int isfound = -1;
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

        public static bool IsPersonExist(int ID)
        {
            using (SqlConnection connection = new SqlConnection(DataAccessSettings.connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_IsPersonIDExist", connection))
                {
                    command.Parameters.AddWithValue("@PersonID", ID);
                    command.CommandType = CommandType.StoredProcedure;

                    int isfound = -1;
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
