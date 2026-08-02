namespace DVLD_PresentationLayer.Application.Local_Driving_License
{
    partial class frmListLocalDrivingLicense
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
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.Records = new System.Windows.Forms.ToolStripStatusLabel();
            this.tbFilterBy = new System.Windows.Forms.TextBox();
            this.cmbFilterApplications = new System.Windows.Forms.ComboBox();
            this.dgvShowLDLA = new System.Windows.Forms.DataGridView();
            this.cmsApplications = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.CmsShowDetails = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsEditApplication = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsDeleteApplication = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsCancelApplication = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsScheduleTest = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsVisionTest = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsWrittenTest = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsStreetTest = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsIssueDrivingLicense = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsShowLicense = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator6 = new System.Windows.Forms.ToolStripSeparator();
            this.cmsLicenseHistory = new System.Windows.Forms.ToolStripMenuItem();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.btnAddNew = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.statusStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvShowLDLA)).BeginInit();
            this.cmsApplications.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // statusStrip1
            // 
            this.statusStrip1.BackColor = System.Drawing.Color.AliceBlue;
            this.statusStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.Records});
            this.statusStrip1.Location = new System.Drawing.Point(0, 592);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(1498, 31);
            this.statusStrip1.TabIndex = 75;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // Records
            // 
            this.Records.Font = new System.Drawing.Font("Segoe UI", 11F);
            this.Records.Name = "Records";
            this.Records.Size = new System.Drawing.Size(103, 25);
            this.Records.Text = "# Records: ";
            // 
            // tbFilterBy
            // 
            this.tbFilterBy.AllowDrop = true;
            this.tbFilterBy.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbFilterBy.Location = new System.Drawing.Point(324, 200);
            this.tbFilterBy.Multiline = true;
            this.tbFilterBy.Name = "tbFilterBy";
            this.tbFilterBy.Size = new System.Drawing.Size(215, 30);
            this.tbFilterBy.TabIndex = 74;
            this.tbFilterBy.TextChanged += new System.EventHandler(this.tbFilterBy_TextChanged);
            this.tbFilterBy.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbFilterBy_KeyPress);
            // 
            // cmbFilterApplications
            // 
            this.cmbFilterApplications.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbFilterApplications.FormattingEnabled = true;
            this.cmbFilterApplications.Items.AddRange(new object[] {
            "None",
            "L.D.L.AppID",
            "Nationalno",
            "Fullname",
            "Status"});
            this.cmbFilterApplications.Location = new System.Drawing.Point(103, 200);
            this.cmbFilterApplications.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.cmbFilterApplications.Name = "cmbFilterApplications";
            this.cmbFilterApplications.Size = new System.Drawing.Size(215, 31);
            this.cmbFilterApplications.TabIndex = 73;
            this.cmbFilterApplications.SelectedIndexChanged += new System.EventHandler(this.cmbFilterApplications_SelectedIndexChanged);
            // 
            // dgvShowLDLA
            // 
            this.dgvShowLDLA.AllowUserToAddRows = false;
            this.dgvShowLDLA.AllowUserToDeleteRows = false;
            this.dgvShowLDLA.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            this.dgvShowLDLA.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.AllCells;
            this.dgvShowLDLA.BackgroundColor = System.Drawing.Color.White;
            this.dgvShowLDLA.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvShowLDLA.ContextMenuStrip = this.cmsApplications;
            this.dgvShowLDLA.Location = new System.Drawing.Point(15, 243);
            this.dgvShowLDLA.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.dgvShowLDLA.MultiSelect = false;
            this.dgvShowLDLA.Name = "dgvShowLDLA";
            this.dgvShowLDLA.ReadOnly = true;
            this.dgvShowLDLA.RowHeadersWidth = 62;
            this.dgvShowLDLA.RowTemplate.Height = 28;
            this.dgvShowLDLA.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvShowLDLA.Size = new System.Drawing.Size(1464, 280);
            this.dgvShowLDLA.TabIndex = 70;
            // 
            // cmsApplications
            // 
            this.cmsApplications.ImageScalingSize = new System.Drawing.Size(42, 42);
            this.cmsApplications.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.CmsShowDetails,
            this.toolStripSeparator1,
            this.cmsEditApplication,
            this.cmsDeleteApplication,
            this.toolStripSeparator3,
            this.cmsCancelApplication,
            this.toolStripSeparator2,
            this.cmsScheduleTest,
            this.toolStripSeparator4,
            this.cmsIssueDrivingLicense,
            this.toolStripSeparator5,
            this.cmsShowLicense,
            this.toolStripSeparator6,
            this.cmsLicenseHistory});
            this.cmsApplications.Name = "contextMenuStrip1";
            this.cmsApplications.Size = new System.Drawing.Size(319, 424);
            this.cmsApplications.Opening += new System.ComponentModel.CancelEventHandler(this.cmsApplications_Opening);
            // 
            // CmsShowDetails
            // 
            this.CmsShowDetails.Image = global::DVLD_PresentationLayer.Properties.Resources.PersonDetails_32;
            this.CmsShowDetails.Name = "CmsShowDetails";
            this.CmsShowDetails.Size = new System.Drawing.Size(318, 48);
            this.CmsShowDetails.Text = "Show Application Details";
            this.CmsShowDetails.Click += new System.EventHandler(this.CmsShowDetails_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsEditApplication
            // 
            this.cmsEditApplication.Image = global::DVLD_PresentationLayer.Properties.Resources.edit_32;
            this.cmsEditApplication.Name = "cmsEditApplication";
            this.cmsEditApplication.Size = new System.Drawing.Size(318, 48);
            this.cmsEditApplication.Text = "Edit Application";
            this.cmsEditApplication.Click += new System.EventHandler(this.cmsEditApplication_Click);
            // 
            // cmsDeleteApplication
            // 
            this.cmsDeleteApplication.Image = global::DVLD_PresentationLayer.Properties.Resources.Delete_32_2;
            this.cmsDeleteApplication.Name = "cmsDeleteApplication";
            this.cmsDeleteApplication.Size = new System.Drawing.Size(318, 48);
            this.cmsDeleteApplication.Text = "Delete Application";
            this.cmsDeleteApplication.Click += new System.EventHandler(this.cmsDeleteApplication_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsCancelApplication
            // 
            this.cmsCancelApplication.Image = global::DVLD_PresentationLayer.Properties.Resources.Delete_32;
            this.cmsCancelApplication.Name = "cmsCancelApplication";
            this.cmsCancelApplication.Size = new System.Drawing.Size(318, 48);
            this.cmsCancelApplication.Text = "Cancel Application";
            this.cmsCancelApplication.Click += new System.EventHandler(this.cmsCancelApplication_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsScheduleTest
            // 
            this.cmsScheduleTest.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.cmsVisionTest,
            this.cmsWrittenTest,
            this.cmsStreetTest});
            this.cmsScheduleTest.Image = global::DVLD_PresentationLayer.Properties.Resources.Schedule_Test_32;
            this.cmsScheduleTest.Name = "cmsScheduleTest";
            this.cmsScheduleTest.Size = new System.Drawing.Size(318, 48);
            this.cmsScheduleTest.Text = "Schedule Test";
            this.cmsScheduleTest.Click += new System.EventHandler(this.cmsScheduleTest_Click);
            // 
            // cmsVisionTest
            // 
            this.cmsVisionTest.Image = global::DVLD_PresentationLayer.Properties.Resources.Vision_Test_Schdule1;
            this.cmsVisionTest.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.cmsVisionTest.Name = "cmsVisionTest";
            this.cmsVisionTest.Size = new System.Drawing.Size(236, 38);
            this.cmsVisionTest.Text = "VisionTest";
            // 
            // cmsWrittenTest
            // 
            this.cmsWrittenTest.Image = global::DVLD_PresentationLayer.Properties.Resources.Written_Test_32_Sechdule1;
            this.cmsWrittenTest.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.cmsWrittenTest.Name = "cmsWrittenTest";
            this.cmsWrittenTest.Size = new System.Drawing.Size(236, 38);
            this.cmsWrittenTest.Text = "Written Test";
            // 
            // cmsStreetTest
            // 
            this.cmsStreetTest.Image = global::DVLD_PresentationLayer.Properties.Resources.Street_Test_32;
            this.cmsStreetTest.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.cmsStreetTest.Name = "cmsStreetTest";
            this.cmsStreetTest.Size = new System.Drawing.Size(236, 38);
            this.cmsStreetTest.Text = "Street Test";
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsIssueDrivingLicense
            // 
            this.cmsIssueDrivingLicense.Image = global::DVLD_PresentationLayer.Properties.Resources.IssueDrivingLicense_32;
            this.cmsIssueDrivingLicense.Name = "cmsIssueDrivingLicense";
            this.cmsIssueDrivingLicense.Size = new System.Drawing.Size(318, 48);
            this.cmsIssueDrivingLicense.Text = "Issue Driving License (First Time)";
            this.cmsIssueDrivingLicense.Click += new System.EventHandler(this.cmsIssueDrivingLicense_Click);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsShowLicense
            // 
            this.cmsShowLicense.Image = global::DVLD_PresentationLayer.Properties.Resources.License_View_321;
            this.cmsShowLicense.Name = "cmsShowLicense";
            this.cmsShowLicense.Size = new System.Drawing.Size(318, 48);
            this.cmsShowLicense.Text = "Show License";
            this.cmsShowLicense.ToolTipText = "Show License";
            this.cmsShowLicense.Click += new System.EventHandler(this.cmsShowLicense_Click);
            // 
            // toolStripSeparator6
            // 
            this.toolStripSeparator6.Name = "toolStripSeparator6";
            this.toolStripSeparator6.Size = new System.Drawing.Size(315, 6);
            // 
            // cmsLicenseHistory
            // 
            this.cmsLicenseHistory.Image = global::DVLD_PresentationLayer.Properties.Resources.PersonLicenseHistory_32;
            this.cmsLicenseHistory.Name = "cmsLicenseHistory";
            this.cmsLicenseHistory.Size = new System.Drawing.Size(318, 48);
            this.cmsLicenseHistory.Text = "Show Person License History";
            this.cmsLicenseHistory.ToolTipText = "Show Person License History";
            this.cmsLicenseHistory.Click += new System.EventHandler(this.cmsLicenseHistory_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(11, 205);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 23);
            this.label2.TabIndex = 68;
            this.label2.Text = "Filter By:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label1.Location = new System.Drawing.Point(527, 146);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(434, 29);
            this.label1.TabIndex = 67;
            this.label1.Text = "Local Driving License Applications";
            // 
            // btnRefresh
            // 
            this.btnRefresh.FlatAppearance.BorderSize = 0;
            this.btnRefresh.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRefresh.Image = global::DVLD_PresentationLayer.Properties.Resources.reload;
            this.btnRefresh.Location = new System.Drawing.Point(545, 198);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(35, 37);
            this.btnRefresh.TabIndex = 72;
            this.btnRefresh.UseVisualStyleBackColor = true;
            // 
            // btnAddNew
            // 
            this.btnAddNew.BackColor = System.Drawing.Color.White;
            this.btnAddNew.FlatAppearance.BorderColor = System.Drawing.Color.Black;
            this.btnAddNew.FlatAppearance.BorderSize = 2;
            this.btnAddNew.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnAddNew.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.btnAddNew.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddNew.Image = global::DVLD_PresentationLayer.Properties.Resources.New_Application_641;
            this.btnAddNew.Location = new System.Drawing.Point(1369, 173);
            this.btnAddNew.Name = "btnAddNew";
            this.btnAddNew.Size = new System.Drawing.Size(110, 58);
            this.btnAddNew.TabIndex = 71;
            this.btnAddNew.UseVisualStyleBackColor = false;
            this.btnAddNew.Click += new System.EventHandler(this.btnAddNew_Click);
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
            this.btnClose.Location = new System.Drawing.Point(1367, 533);
            this.btnClose.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(112, 38);
            this.btnClose.TabIndex = 69;
            this.btnClose.Text = "    Close";
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::DVLD_PresentationLayer.Properties.Resources.Application_Types_5121;
            this.pictureBox1.Location = new System.Drawing.Point(689, 6);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(133, 121);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 66;
            this.pictureBox1.TabStop = false;
            // 
            // frmListLocalDrivingLicense
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.AliceBlue;
            this.ClientSize = new System.Drawing.Size(1498, 623);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.tbFilterBy);
            this.Controls.Add(this.cmbFilterApplications);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.btnAddNew);
            this.Controls.Add(this.dgvShowLDLA);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pictureBox1);
            this.Name = "frmListLocalDrivingLicense";
            this.Text = "frmListLocalDrivingLicense";
            this.Load += new System.EventHandler(this.frmListLocalDrivingLicense_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvShowLDLA)).EndInit();
            this.cmsApplications.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel Records;
        private System.Windows.Forms.TextBox tbFilterBy;
        private System.Windows.Forms.ComboBox cmbFilterApplications;
        private System.Windows.Forms.Button btnRefresh;
        private System.Windows.Forms.Button btnAddNew;
        private System.Windows.Forms.DataGridView dgvShowLDLA;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.ContextMenuStrip cmsApplications;
        private System.Windows.Forms.ToolStripMenuItem CmsShowDetails;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem cmsEditApplication;
        private System.Windows.Forms.ToolStripMenuItem cmsDeleteApplication;
        private System.Windows.Forms.ToolStripMenuItem cmsCancelApplication;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem cmsScheduleTest;
        private System.Windows.Forms.ToolStripMenuItem cmsIssueDrivingLicense;
        private System.Windows.Forms.ToolStripMenuItem cmsShowLicense;
        private System.Windows.Forms.ToolStripMenuItem cmsLicenseHistory;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator6;
        private System.Windows.Forms.ToolStripMenuItem cmsVisionTest;
        private System.Windows.Forms.ToolStripMenuItem cmsWrittenTest;
        private System.Windows.Forms.ToolStripMenuItem cmsStreetTest;
    }
}