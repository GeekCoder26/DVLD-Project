using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace DVLD_PresentationLayer.Global_Classes
{
    internal class clsUtil
    {
        static string LoginDestinationFile = @"D:\Login-Data\Login.txt";
        public static string GenerateGUID()
        {
            Guid NewGuid = Guid.NewGuid();

            return NewGuid.ToString();

        }
        public static string ReplaceFileNameWithGUID(string SourceFile)
        {

            string FileName = SourceFile;
            FileInfo file = new FileInfo(FileName);
            string Extension = file.Extension;

            return GenerateGUID() + Extension;

        }
        public static bool CreateFolderIfDoesNotExist(string DestinationFolder)
        {
            if (!Directory.Exists(DestinationFolder))
            {
                try
                {
                    Directory.CreateDirectory(DestinationFolder);
                    return true;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Creating Folder: " + ex.Message, "File Error");
                    return false;
                }
            }
            return true;
        }
        public static bool CopyImageToProjectImageFolder(ref string SourceImageFile)
        {
            string DestinationFolder = @"C:\DVLD-Project-Personal-Image\";

            if (!CreateFolderIfDoesNotExist(DestinationFolder))
            {
                return false;
            }
            string DestinationFile = DestinationFolder + ReplaceFileNameWithGUID(SourceImageFile);
            try
            {
                File.Copy(SourceImageFile, DestinationFile, true);
            }
            catch (IOException iox)
            {
                MessageBox.Show(iox.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            SourceImageFile = DestinationFile;
            return true;
        }

        //--------------------------------------------------------------------------------------------------
        public static bool SaveLoginInfoToTXT(string Username, string password)
        {
            string DestinationFolder = @"D:\Login-Data\";

            // string LoginInfo = Username + "#" + password;


            if (!CreateFolderIfDoesNotExist(DestinationFolder))
            {
                return false;
            }

            string DestinationTXT = DestinationFolder + "Login.txt";

            try
            {
                //File.CreateText(DestinationTXT);
                File.WriteAllText(DestinationTXT, Username + "\n");
                File.AppendAllText(DestinationTXT, password);

            }
            catch (IOException iox)
            {
                MessageBox.Show(iox.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;

        }
        public static bool GetLoginDataIfExist(ref string Username, ref string Password)
        {


            if (File.Exists(LoginDestinationFile))
            {

                try
                {
                    string[] LoginData = File.ReadAllLines(LoginDestinationFile);

                    if (LoginData.Length > 0)
                    {
                        Username = LoginData[0];
                        Password = LoginData[1];
                        return true;
                    }
                

                }
                catch (IOException iox)
                {
                    MessageBox.Show(iox.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }

            }
            return false;
        }

        public static bool DeleteOldDataFromTXT()
        {
            if(File.Exists(LoginDestinationFile))
            {

                try
                {

                    File.Delete(LoginDestinationFile);
                    
                    return true;
                }
                catch(Exception ex)
                {
                    return false;
                }
                
            }
            return false;


        }


    }
}
