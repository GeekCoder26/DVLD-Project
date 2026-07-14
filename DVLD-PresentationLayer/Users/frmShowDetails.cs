using DVLD_PresentationLayer.Default_Controls_For_All_project;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Users
{
    public partial class frmShowDetails : Form
    {
        public frmShowDetails(int UserID, int PersonID)
        {
            InitializeComponent();
           
            ctrlUserCard1.LoadUserInfo(UserID, PersonID);
        }
        public frmShowDetails(string Username)
        {
            InitializeComponent();

           
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
