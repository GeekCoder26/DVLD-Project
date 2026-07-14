using DVLD_BusinessLayer;
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

namespace DVLD_PresentationLayer.People
{
    public partial class frmShowPersonDetails : Form
    {

        
        public frmShowPersonDetails(int PersonID)
        {
            InitializeComponent();

            ctrlPersonDetails2.LoadPersonInfo(PersonID);

        }

        public frmShowPersonDetails(string NationalNo)
        {
            ctrlPersonDetails2.LoadPersonInfo(NationalNo);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
