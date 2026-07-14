using DVLD_BusinessLayer;
using DVLD_PresentationLayer.People;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DVLD_PresentationLayer.Default_Controls_For_All_project
{
    public partial class ctrlPersonDetailsWithFilter : UserControl
    {

        public event Action<int> OnPesonSelected;

        protected virtual void PersonSelected(int PersonID)
        {
            Action<int> handler = OnPesonSelected;
            if(handler != null)
            {
                handler(PersonID);
            }
        }

        private bool _ShowAddPerson = true;

        private bool ShowAddPerson
        {
            get {  return _ShowAddPerson; }

            set 
            {
                _ShowAddPerson = value;
                btnAdd.Visible = _ShowAddPerson;
            }
        }

        private bool _EnableFilter = true;

        public bool  EnableFilter
        {
            get { return _EnableFilter; }
            set
            {
                _EnableFilter = value;
                gbFilter.Enabled = _EnableFilter;
            }
        }

        public ctrlPersonDetailsWithFilter()
        {
            InitializeComponent();
        }


        private int _PersonID;
        public int PersonID
        {
            get { return ctrlPersonDetails1.PersonID; }
        }

        public clsPerson SelectedPersonInfo
        {
            get { return ctrlPersonDetails1.SelectPersonInfo; }
        }

        public void LoadPersonInfo(int  PersonID)
        {
            cbFilter.SelectedIndex = 1;
            txbFilter.Text = PersonID.ToString();
            FindNow();

        }

        private void FindNow()
        {
            switch(cbFilter.Text)
            {
                case "PersonID":

                    ctrlPersonDetails1.LoadPersonInfo(int.Parse(txbFilter.Text)); 
                    break;

                case "NationalNo":
                    ctrlPersonDetails1.LoadPersonInfo(txbFilter.Text);
                    break;

                default:
                    break;
            }

            if (OnPesonSelected != null && EnableFilter)
                OnPesonSelected(ctrlPersonDetails1.PersonID);
        }

        private void cbFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            txbFilter.Text = "";
            txbFilter.Focus();

        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            if(!this.ValidateChildren())
            {
                MessageBox.Show("Some Fields Are Not valid", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            FindNow();

        }

        private void ctrlPersonDetailsWithFilter_Load(object sender, EventArgs e)
        {
            cbFilter.SelectedIndex = 0;
            txbFilter.Focus();
        }

        private void txbFilter_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrEmpty(txbFilter.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txbFilter, "This Field Is required");
            }
            else
            {
                errorProvider1.SetError(txbFilter, null);
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Add_Edit_Form frm = new Add_Edit_Form();
            frm.DataBack += DataBackEvent;
            frm.ShowDialog();
        }

        private void DataBackEvent(object sender, int PersonID)
        {
            cbFilter.SelectedIndex = 1;
            txbFilter.Text = PersonID.ToString();
            ctrlPersonDetails1.LoadPersonInfo(PersonID);
        }

        public void FilterFocus()
        {
            txbFilter.Focus();
        }

        private void txbFilter_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(e.KeyChar == (char)13)
            {
                btnSearch.PerformClick();
            }

            if(cbFilter.Text == "PersonID")
            {
                e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);
            }
        }

        private void gbFilter_Enter(object sender, EventArgs e)
        {

        }
    }
}
