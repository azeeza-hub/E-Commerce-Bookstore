using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PageTurnerBookstore;

namespace PageTurnerBookstore
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
                Response.Redirect("/Default.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();

            if (password.Length < 6)
            {
                lblError.Text = "❌ Password must be at least 6 characters.";
                lblError.Visible = true;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_RegisterUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Phone", phone);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string message = reader["Message"].ToString();
                    if (message == "Registration successful")
                    {
                        lblSuccess.Text = "✅ Account created successfully! Redirecting to login...";
                        lblSuccess.Visible = true;
                        Response.AddHeader("REFRESH", "2;URL=/Login.aspx");
                    }
                    else
                    {
                        lblError.Text = "❌ " + message;
                        lblError.Visible = true;
                    }
                }
            }
        }
    }
}
