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

namespace DVLD_PresentationLayer.Tests.Manage_Test_Types
{
    public partial class frmEditTestTypes : Form
    {

        clsTestTypes.enType _TestTypeID = clsTestTypes.enType.VisionTest;

        clsTestTypes TestTypes;

        public frmEditTestTypes(clsTestTypes.enType TestTypeID)
        {
            InitializeComponent();

            _TestTypeID = TestTypeID;
        }


        private void LoadData()
        {
            TestTypes = clsTestTypes.FindApplicationType(_TestTypeID);

            if (TestTypes == null)
            {
                MessageBox.Show("Error Opening Edit Window, Please Verify Your Data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblTestID.Text = TestTypes._TestTypeID.ToString();
            txbTestTitle.Text = TestTypes._TestTypeTitle;
            txbTestDescription.Text = TestTypes._TestTypeDescription;
            txbTestFees.Text = TestTypes._TestTypeFees.ToString();



        }

        private void frmEditTestTypes_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
            {
                MessageBox.Show("Some Field Are Empty, Please Enter The Data", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            TestTypes._TestTypeTitle = txbTestTitle.Text;
            TestTypes._TestTypeDescription = txbTestDescription.Text;
            TestTypes._TestTypeFees = Convert.ToDouble(txbTestFees.Text);

            if (TestTypes.Save())
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

        private void txbTestTitle_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txbTestTitle.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbTestTitle, "This Field Is Required");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbTestTitle, null);
            }
        }

        private void txbTestDescription_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txbTestDescription.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbTestDescription, "This Field Is Required");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbTestDescription, null);
            }
        }

        private void txbTestFees_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txbTestFees.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbTestFees, "This Field Is Required");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbTestFees, null);
            }

            if (!clsValidation.IsNumber(txbTestFees.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbTestFees, "Invalid Number");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txbTestFees, null);
            }
        }
    }
}
