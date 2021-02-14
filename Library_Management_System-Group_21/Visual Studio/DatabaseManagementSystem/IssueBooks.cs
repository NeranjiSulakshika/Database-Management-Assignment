using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DatabaseManagementSystem
{
    public partial class IssueBooks : Form
    {
        public IssueBooks()
        {
            InitializeComponent();
        }

        private void ISSUE_Load(object sender, EventArgs e)
        {

        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
                         /* Search Member ID*/
            try
            {
                if (txtMemberID.Text != "")   // When the Member ID textbox is not empty, execute following these.
                {
                    String Mid = txtMemberID.Text;

                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = "data source = DESKTOP-VHPDJKD; database=LibraryManagementSystem; Integrated security=True";
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;

                    cmd.CommandText = "SELECT * FROM Borrower WHERE M_ID = '" + Mid + "' ";
                    SqlDataAdapter DA = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    DA.Fill(DS);

                    if (DS.Tables[0].Rows.Count != 0)
                    {
                        txtMemberName.Text = DS.Tables[0].Rows[0][1].ToString();
                        txtEmail.Text = DS.Tables[0].Rows[0][3].ToString();
                        txtContactNo.Text = DS.Tables[0].Rows[0][4].ToString();
                    }
                    else
                    {
                        txtMemberName.Clear();
                        txtContactNo.Clear();
                        txtEmail.Clear();
                        MessageBox.Show("Invalid Member ID!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                else    // Display a Warning message like this, when the Member ID textbox is empty.
                {
                    MessageBox.Show("Please input Member ID!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            } 
            catch(Exception ex)  // Display the error message like this without crash the program, when the SQL part has an error.
            {
                MessageBox.Show("Error detected :" + ex, "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            
        }



        private void txtStudentName_TextChanged(object sender, EventArgs e)
        {

        }



        private void btnIssue_Click(object sender, EventArgs e)
        {
            /* All book issued details INSERT into the 'IssueInfo' database table, when the member borrowing a book. */
            try
            {
                if (txtMemberID.Text == "" || txtISBN.Text == "" || txtCopyNo.Text == "")   // Display a Warning message like this, when the Member ID, ISBN & Copy No textboxs is empty.
                {
                    MessageBox.Show("Please input all details!", "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else   // All book issued details INSERT into the 'IssueInfo' database, when the ISBN textbox is not empty.
                {
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = "data source = DESKTOP-VHPDJKD; database=LibraryManagementSystem; Integrated security=True";
                    con.Open();

                    // Check - Entered ISBN related book copy is already issued or not.
                    SqlCommand check_isbn = new SqlCommand("SELECT COUNT(*) FROM [IssueInfo] WHERE ([B_ISBN] = @Bisbn)", con);
                    check_isbn.Parameters.AddWithValue("@Bisbn", txtISBN.Text);
                    int UserExist = (int)check_isbn.ExecuteScalar();

                    if (UserExist > 0)
                    {
                        //ISBN related book copy is already issued.
                        MessageBox.Show("This book is already issued!", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    else
                    {
                        //If ISBN related book copy is not already issued, this copy issuing.
                        SqlCommand cmd = con.CreateCommand();
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = "INSERT INTO IssueInfo(B_ISBN, CopyNo, Member_ID, IssueDate, ReturnDate) VALUES ('" + txtISBN.Text + "' , '" + txtCopyNo.Text + "' , '" + txtMemberID.Text + "' , '" + tdpBookIssue.Value.ToString("MM/dd/yyyy") + "' , '" + tdpBookReturn.Value.ToString("MM/dd/yyyy") + "')";
                        cmd.ExecuteNonQuery();
                        con.Close();

                        //This message is displaying, when the data insert is successful.
                        MessageBox.Show("Book Issued Successfully!", "Congradulations!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.Hide();
                    }                    
                }
            }
            catch (Exception ex)  // Display an error message like this without crash the program, when the SQL part has an error.
            {
                MessageBox.Show("Error detected :" + ex, "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }



        private void txtMemberID_TextChanged(object sender, EventArgs e)
        {
            /* Erase these all textboxes and hide the DataGridView, when the member Id textbox is empty. */
            if (txtMemberID.Text == "")
            {
                txtMemberName.Text = "";
                txtContactNo.Text = "";
                txtEmail.Text = "";
                txtISBN.Text = "";
                txtCopyNo.Text = "";
                dgvBookDetails.Hide();
            }
        }



        private void txtISBN_TextChanged(object sender, EventArgs e)
        {

        }



        private void btnCancel_Click(object sender, EventArgs e)
        {
            // Close this Interface..
            this.Hide();
        }



        private void btnCheckISBN_Click(object sender, EventArgs e)
        {
                    /* Check ISBN*/
            try
            {
                if (txtISBN.Text != "")   // Search the ISBN related books details and show these details using the DataGridView, when the ISBN textbox is not empty.
                {
                    String isbn = txtISBN.Text;

                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = "data source = DESKTOP-VHPDJKD; database=LibraryManagementSystem; Integrated security=True";
                    con.Open();

                    SqlCommand cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT ISBN, B_Name, B_Author, B_PublishedDate, Copy.CopyNo FROM Book, Copy WHERE Book.ISBN = Copy.Copy_ISBN AND ISBN = '" + isbn + "' ";
                    cmd.ExecuteNonQuery();
                    DataTable dt = new DataTable();
                    SqlDataAdapter DA = new SqlDataAdapter(cmd);
                    DA.Fill(dt);
                    dgvBookDetails.DataSource = dt;
                    con.Close();

                    dgvBookDetails.Show();

                    //Calculate the return date
                    tdpBookReturn.Value = tdpBookIssue.Value.AddDays(14);
                }
                else   // Display a Warning message like this, when the ISBN textbox is empty.
                {
                    dgvBookDetails.Rows.Clear();
                    MessageBox.Show("Please check the ISBN!", "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch (Exception ex)  // Display an error message like this without crash the program, when the SQL part has an error.
            {
                MessageBox.Show("Error detected :" + ex, "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
