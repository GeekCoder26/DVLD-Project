namespace DVLD_PresentationLayer.People
{
    partial class frmShowPersonDetails
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
            this.button1 = new System.Windows.Forms.Button();
            this.ctrlPersonDetails2 = new DVLD_PresentationLayer.Default_Controls_For_All_project.ctrlPersonDetails();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Image = global::DVLD_PresentationLayer.Properties.Resources.Close_32;
            this.button1.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button1.Location = new System.Drawing.Point(831, 295);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(106, 35);
            this.button1.TabIndex = 1;
            this.button1.Text = "   Close";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // ctrlPersonDetails2
            // 
            this.ctrlPersonDetails2.Location = new System.Drawing.Point(18, 12);
            this.ctrlPersonDetails2.Name = "ctrlPersonDetails2";
            this.ctrlPersonDetails2.Size = new System.Drawing.Size(935, 263);
            this.ctrlPersonDetails2.TabIndex = 0;
            // 
            // frmShowPersonDetails
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(965, 342);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.ctrlPersonDetails2);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "frmShowPersonDetails";
            this.Text = "Show Person Details";
            this.ResumeLayout(false);

        }

        #endregion

        private Default_Controls_For_All_project.ctrlPersonDetails ctrlPersonDetails2;
        private System.Windows.Forms.Button button1;
    }
}