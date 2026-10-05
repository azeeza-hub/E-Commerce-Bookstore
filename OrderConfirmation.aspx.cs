using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PageTurnerBookstore
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string orderId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(orderId))
                {
                    Response.Redirect("/Default.aspx");
                    return;
                }
                LoadOrder(orderId);
            }
        }

        private void LoadOrder(string orderId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Load order details
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Orders WHERE OrderID = @OrderID AND UserID = @UserID", conn);
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    litOrderId.Text = orderId;
                    litOrderDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("dd MMMM yyyy, hh:mm tt");
                    litTotal.Text = string.Format("{0:F2}", reader["TotalAmount"]);
                    litAddress.Text = reader["ShippingAddress"].ToString();
                }
                reader.Close();

                // Load order items
                SqlCommand itemsCmd = new SqlCommand(@"
                    SELECT oi.Quantity, oi.UnitPrice, b.Title, b.Author
                    FROM OrderItems oi
                    JOIN Books b ON oi.BookID = b.BookID
                    WHERE oi.OrderID = @OrderID", conn);
                itemsCmd.Parameters.AddWithValue("@OrderID", orderId);

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(itemsCmd);
                da.Fill(dt);

                rptItems.DataSource = dt;
                rptItems.DataBind();
            }
        }
    }
}