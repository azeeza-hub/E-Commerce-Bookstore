using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace PageTurnerBookstore
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If already logged in redirect to home
            if (Session["UserID"] != null)
                Response.Redirect("/Default.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_LoginUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Save user info in session
                    Session["UserID"] = reader["UserID"].ToString();
                    Session["FullName"] = reader["FullName"].ToString();
                    Session["Email"] = reader["Email"].ToString();
                    Session["Role"] = reader["Role"].ToString();

                    // Redirect based on role
                    if (reader["Role"].ToString() == "Admin")
                        Response.Redirect("/AdminDashboard.aspx");
                    else
                        Response.Redirect("/Default.aspx");
                }
                else
                {
                    lblError.Text = "❌ Invalid email or password. Please try again.";
                    lblError.Visible = true;
                }
            }
        }
    }
}
