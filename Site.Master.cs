using System;

namespace PageTurnerBookstore
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Cart badge for customers
            if (Session["UserID"] != null && Session["Role"] != null
                && Session["Role"].ToString() != "Admin")
            {
                int count = GetCartCount();
                var litBadge = (System.Web.UI.WebControls.Literal)FindControl("litCartBadge");
                if (litBadge != null && count > 0)
                    litBadge.Text = $"<span class='cart-badge'>{count}</span>";

                // Username in dropdown
                var litName = (System.Web.UI.WebControls.Literal)FindControl("litUserName");
                if (litName != null && Session["FullName"] != null)
                    litName.Text = Session["FullName"].ToString().Split(' ')[0];

                // Greeting in dropdown
                var litGreet = (System.Web.UI.WebControls.Literal)FindControl("litGreeting");
                if (litGreet != null && Session["FullName"] != null)
                    litGreet.Text = Session["FullName"].ToString();
            }
        }

        public int GetCartCount()
        {
            if (Session["UserID"] == null) return 0;
            try
            {
                string connStr = System.Configuration.ConfigurationManager
                    .ConnectionStrings["ReadingNookDB"].ConnectionString;
                using (var conn = new System.Data.SqlClient.SqlConnection(connStr))
                {
                    var cmd = new System.Data.SqlClient.SqlCommand(
                        "SELECT ISNULL(SUM(Quantity),0) FROM Cart WHERE UserID=@UserID", conn);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    conn.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch { return 0; }
        }
    }
}