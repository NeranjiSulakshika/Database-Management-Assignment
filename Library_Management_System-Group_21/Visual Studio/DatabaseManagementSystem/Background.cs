using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DatabaseManagementSystem
{
    public partial class Background : Form
    {
        public Background()
        {
            InitializeComponent();
        }

        private void btnIssueBooks_Click(object sender, EventArgs e)
        {
            IssueBooks i = new IssueBooks();
            i.Show();
        }

        private void btnReturnBooks_Click(object sender, EventArgs e)
        {
            ReturnBook rb = new ReturnBook();
            rb.Show();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBooks_Click(object sender, EventArgs e)
        {
            AddBooks ab = new AddBooks();
            ab.Show();
        }
    }
}
