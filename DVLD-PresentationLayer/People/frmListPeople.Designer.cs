namespace DVLD_PresentationLayer
{
    partial class frmListPeople
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmListPeople));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.dgvShowPeople = new System.Windows.Forms.DataGridView();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.CmsShowDetails = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.CmsAddNewPerson = new System.Windows.Forms.ToolStripMenuItem();
            this.CmsEdit = new System.Windows.Forms.ToolStripMenuItem();
            this.CmsDelete = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.CmsSendEmail = new System.Windows.Forms.ToolStripMenuItem();
            this.CmsPhoneCall = new System.Windows.Forms.ToolStripMenuItem();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.cmbFilterPeople = new System.Windows.Forms.ComboBox();
            this.tbFilterBy = new System.Windows.Forms.TextBox();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            ((System.ComponentModel.ISupportInitialize)(this.dgvShowPeople)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label1.Location = new System.Drawing.Point(628, 148);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(264, 29);
            this.label1.TabIndex = 4;
            this.label1.Text = "People Management";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(11, 210);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 23);
            this.label2.TabIndex = 6;
            this.label2.Text = "Filter By:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(11, 546);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(0, 23);
            this.label3.TabIndex = 9;
            // 
            // dgvShowPeople
            // 
            this.dgvShowPeople.AllowUserToAddRows = false;
            this.dgvShowPeople.AllowUserToDeleteRows = false;
            this.dgvShowPeople.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            this.dgvShowPeople.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.dgvShowPeople.BackgroundColor = System.Drawing.Color.White;
            this.dgvShowPeople.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvShowPeople.ContextMenuStrip = this.contextMenuStrip1;
            this.dgvShowPeople.Location = new System.Drawing.Point(15, 248);
            this.dgvShowPeople.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.dgvShowPeople.MultiSelect = false;
            this.dgvShowPeople.Name = "dgvShowPeople";
            this.dgvShowPeople.ReadOnly = true;
            this.dgvShowPeople.RowHeadersWidth = 62;
            this.dgvShowPeople.RowTemplate.Height = 28;
            this.dgvShowPeople.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvShowPeople.Size = new System.Drawing.Size(1464, 280);
            this.dgvShowPeople.TabIndex = 11;
            this.dgvShowPeople.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvShowPeople_CellClick);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.ImageScalingSize = new System.Drawing.Size(42, 42);
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.CmsShowDetails,
            this.toolStripSeparator1,
            this.CmsAddNewPerson,
            this.CmsEdit,
            this.CmsDelete,
            this.toolStripSeparator2,
            this.CmsSendEmail,
            this.CmsPhoneCall});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(214, 304);
            // 
            // CmsShowDetails
            // 
            this.CmsShowDetails.Image = global::DVLD_PresentationLayer.Properties.Resources.PersonDetails_32;
            this.CmsShowDetails.Name = "CmsShowDetails";
            this.CmsShowDetails.Size = new System.Drawing.Size(213, 48);
            this.CmsShowDetails.Text = "Show Details";
            this.CmsShowDetails.Click += new System.EventHandler(this.CmsShowDetails_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(210, 6);
            // 
            // CmsAddNewPerson
            // 
            this.CmsAddNewPerson.Image = global::DVLD_PresentationLayer.Properties.Resources.Add_Person_40;
            this.CmsAddNewPerson.Name = "CmsAddNewPerson";
            this.CmsAddNewPerson.Size = new System.Drawing.Size(213, 48);
            this.CmsAddNewPerson.Text = "Add New Person";
            this.CmsAddNewPerson.Click += new System.EventHandler(this.CmsAddNewPerson_Click);
            // 
            // CmsEdit
            // 
            this.CmsEdit.Image = global::DVLD_PresentationLayer.Properties.Resources.edit_32;
            this.CmsEdit.Name = "CmsEdit";
            this.CmsEdit.Size = new System.Drawing.Size(213, 48);
            this.CmsEdit.Text = "Edit";
            this.CmsEdit.Click += new System.EventHandler(this.CmsEdit_Click);
            // 
            // CmsDelete
            // 
            this.CmsDelete.Image = global::DVLD_PresentationLayer.Properties.Resources.Delete_32;
            this.CmsDelete.Name = "CmsDelete";
            this.CmsDelete.Size = new System.Drawing.Size(213, 48);
            this.CmsDelete.Text = "Delete";
            this.CmsDelete.Click += new System.EventHandler(this.CmsDelete_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(210, 6);
            // 
            // CmsSendEmail
            // 
            this.CmsSendEmail.Image = global::DVLD_PresentationLayer.Properties.Resources.send_email_32;
            this.CmsSendEmail.Name = "CmsSendEmail";
            this.CmsSendEmail.Size = new System.Drawing.Size(213, 48);
            this.CmsSendEmail.Text = "Send Email";
            // 
            // CmsPhoneCall
            // 
            this.CmsPhoneCall.Image = global::DVLD_PresentationLayer.Properties.Resources.call_32;
            this.CmsPhoneCall.Name = "CmsPhoneCall";
            this.CmsPhoneCall.Size = new System.Drawing.Size(213, 48);
            this.CmsPhoneCall.Text = "Phone Call";
            // 
            // btnRefresh
            // 
            this.btnRefresh.FlatAppearance.BorderSize = 0;
            this.btnRefresh.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRefresh.Image = global::DVLD_PresentationLayer.Properties.Resources.reload;
            this.btnRefresh.Location = new System.Drawing.Point(545, 203);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(35, 37);
            this.btnRefresh.TabIndex = 13;
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.White;
            this.button1.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.button1.FlatAppearance.BorderSize = 2;
            this.button1.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.button1.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Image = global::DVLD_PresentationLayer.Properties.Resources.Add_Person_40;
            this.button1.Location = new System.Drawing.Point(1369, 185);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(110, 58);
            this.button1.TabIndex = 12;
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.pbAddPeople_Click);
            // 
            // btnClose
            // 
            this.btnClose.BackColor = System.Drawing.Color.White;
            this.btnClose.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnClose.FlatAppearance.BorderSize = 2;
            this.btnClose.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClose.Image = global::DVLD_PresentationLayer.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(1367, 538);
            this.btnClose.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(112, 38);
            this.btnClose.TabIndex = 8;
            this.btnClose.Text = "    Close";
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::DVLD_PresentationLayer.Properties.Resources.People_400;
            this.pictureBox1.Location = new System.Drawing.Point(689, 11);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(133, 121);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 3;
            this.pictureBox1.TabStop = false;
            // 
            // cmbFilterPeople
            // 
            this.cmbFilterPeople.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbFilterPeople.FormattingEnabled = true;
            this.cmbFilterPeople.Items.AddRange(new object[] {
            "None",
            "PersonID",
            "NationalNo",
            "FirstName",
            "SecondName",
            "ThirdName",
            "LastName",
            "Nationality",
            "Gender",
            "Phone",
            "Email"});
            this.cmbFilterPeople.Location = new System.Drawing.Point(103, 205);
            this.cmbFilterPeople.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.cmbFilterPeople.Name = "cmbFilterPeople";
            this.cmbFilterPeople.Size = new System.Drawing.Size(215, 31);
            this.cmbFilterPeople.TabIndex = 63;
            this.cmbFilterPeople.SelectedIndexChanged += new System.EventHandler(this.cmbFilterPeople_SelectedIndexChanged);
            // 
            // tbFilterBy
            // 
            this.tbFilterBy.AllowDrop = true;
            this.tbFilterBy.Location = new System.Drawing.Point(324, 205);
            this.tbFilterBy.Multiline = true;
            this.tbFilterBy.Name = "tbFilterBy";
            this.tbFilterBy.Size = new System.Drawing.Size(215, 30);
            this.tbFilterBy.TabIndex = 64;
            this.tbFilterBy.TextChanged += new System.EventHandler(this.tbFilterBy_TextChanged);
            this.tbFilterBy.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbFilterBy_KeyPress);
            // 
            // statusStrip1
            // 
            this.statusStrip1.BackColor = System.Drawing.Color.AliceBlue;
            this.statusStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 591);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(1503, 31);
            this.statusStrip1.TabIndex = 65;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Font = new System.Drawing.Font("Segoe UI", 11F);
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(103, 25);
            this.toolStripStatusLabel1.Text = "# Records: ";
            // 
            // frmListPeople
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.AliceBlue;
            this.ClientSize = new System.Drawing.Size(1503, 622);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.tbFilterBy);
            this.Controls.Add(this.cmbFilterPeople);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.dgvShowPeople);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pictureBox1);
            this.Font = new System.Drawing.Font("Segoe UI", 8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "frmListPeople";
            this.Text = "People Management";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvShowPeople)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.DataGridView dgvShowPeople;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button btnRefresh;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem CmsShowDetails;
        private System.Windows.Forms.ToolStripMenuItem CmsAddNewPerson;
        private System.Windows.Forms.ToolStripMenuItem CmsEdit;
        private System.Windows.Forms.ToolStripMenuItem CmsDelete;
        private System.Windows.Forms.ToolStripMenuItem CmsSendEmail;
        private System.Windows.Forms.ToolStripMenuItem CmsPhoneCall;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ComboBox cmbFilterPeople;
        private System.Windows.Forms.TextBox tbFilterBy;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
    }
}

