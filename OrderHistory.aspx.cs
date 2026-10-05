using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PageTurnerBookstore;

namespace PageTurnerBookstore
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        private string connStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("/Login.aspx");
                return;
            }

            connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            if (!IsPostBack)
                LoadOrders();
        }

        private void LoadOrders()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT OrderID, OrderDate, TotalAmount, Status, ShippingAddress
                    FROM Orders
                    WHERE UserID = @UserID
                    ORDER BY OrderDate DESC", conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlEmpty.Visible = true;
                    pnlOrders.Visible = false;
                }
                else
                {
                    pnlEmpty.Visible = false;
                    pnlOrders.Visible = true;
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
            }
        }

        public DataTable GetOrderItems(int orderId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT oi.Quantity, oi.UnitPrice, b.Title, b.Author, b.Genre, b.CoverImage, b.ISBN
                    FROM OrderItems oi
                    JOIN Books b ON oi.BookID = b.BookID
                    WHERE oi.OrderID = @OrderID", conn);
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                return dt;
            }
        }
    }
}
