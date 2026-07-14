using DVLD_BusinessLayer;
using DVLD_PresentationLayer.Global_Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.ApplicationTypes
{
    public partial class frmEditApplicationTypes : Form
    {


        int _ApplicationID;

        clsApplicationTypes AppTypes;
       
        public frmEditApplicationTypes(int ApplicationID)
        {
            InitializeComponent();
            _ApplicationID = ApplicationID;

        }

        private void LoadData()
        {
            AppTypes = clsApplicationTypes.FindApplicationType(_ApplicationID);

            if(AppTypes == null)
            {
                MessageBox.Show("Error Opening Edit Window, Please Verify Your Data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblAppID.Text = AppTypes._ApplicationID.ToString();
            txbAppTitle.Text = AppTypes._ApplicationTitle;
            txbAppFees.Text = AppTypes._ApplicationFees.ToString();


        }
        private void frmEditApplicationTypes_Load(object sender, EventArgs e)
        {
            LoadData();

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if(!this.ValidateChildren())
            {
                MessageBox.Show("Some Field Are Empty, Please Enter The Data", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            AppTypes._ApplicationID = int.Parse(lblAppID.ToString());
            AppTypes._ApplicationTitle = txbAppTitle.Text;
            AppTypes._ApplicationFees = Convert.ToSingle(txbAppFees.Text);

            if(AppTypes.Save())
            {
                MessageBox.Show("Data Saved Succeffully", "Save", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("Data Save Failed", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txbAppTitle_Validating(object sender, CancelEventArgs e)
        {

            if(string.IsNullOrEmpty(txbAppTitle.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbAppTitle, "This Field Is Required");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbAppTitle, null);
            }

        }

        private void txbAppFees_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txbAppFees.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbAppFees, "This Field Is Required");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbAppFees, null);
            }

            if(!clsValidation.IsNumber(txbAppFees.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbAppFees, "Invalid Number");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbAppFees, null);
            }

        }
    }
}
