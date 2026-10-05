using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PageTurnerBookstore;

namespace PageTurnerBookstore
{
    public partial class Checkout : System.Web.UI.Page
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
                LoadOrderSummary();
                PreFillUserInfo();
            }
        }

        private void PreFillUserInfo()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT FullName, Email, Phone, Address FROM Users WHERE UserID = @UserID", conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
            }
        }

        private void LoadOrderSummary()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT c.Quantity, b.Title, b.Author, b.Price
                    FROM Cart c
                    JOIN Books b ON c.BookID = b.BookID
                    WHERE c.UserID = @UserID", conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("/Cart.aspx");
                    return;
                }

                rptOrderItems.DataSource = dt;
                rptOrderItems.DataBind();

                decimal subtotal = 0;
                foreach (DataRow row in dt.Rows)
                    subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);

                decimal shipping = subtotal >= 100 ? 0 : 10;
                decimal total = subtotal + shipping;

                litSubtotal.Text = subtotal.ToString("F2");
                litShipping.Text = shipping == 0 ? "FREE" : "RM " + shipping.ToString("F2");
                litTotal.Text = total.ToString("F2");
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string fullAddress = $"{txtAddress.Text.Trim()}, {txtCity.Text.Trim()}, {ddlState.SelectedValue}, {txtPostcode.Text.Trim()}";

            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Get cart items
                SqlCommand cartCmd = new SqlCommand(@"
                    SELECT c.BookID, c.Quantity, b.Price
                    FROM Cart c
                    JOIN Books b ON c.BookID = b.BookID
                    WHERE c.UserID = @UserID", conn);
                cartCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                DataTable cartItems = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cartCmd);
                da.Fill(cartItems);

                if (cartItems.Rows.Count == 0)
                {
                    Response.Redirect("/Cart.aspx");
                    return;
                }

                // Calculate total
                decimal total = 0;
                foreach (DataRow row in cartItems.Rows)
                    total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                if (total < 100) total += 10;

                // Place order
                SqlCommand orderCmd = new SqlCommand("sp_PlaceOrder", conn);
                orderCmd.CommandType = CommandType.StoredProcedure;
                orderCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                orderCmd.Parameters.AddWithValue("@TotalAmount", total);
                orderCmd.Parameters.AddWithValue("@ShippingAddress", fullAddress);

                int orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                // Add order items
                foreach (DataRow row in cartItems.Rows)
                {
                    SqlCommand itemCmd = new SqlCommand(@"
                        INSERT INTO OrderItems (OrderID, BookID, Quantity, UnitPrice)
                        VALUES (@OrderID, @BookID, @Qty, @Price)", conn);
                    itemCmd.Parameters.AddWithValue("@OrderID", orderId);
                    itemCmd.Parameters.AddWithValue("@BookID", row["BookID"]);
                    itemCmd.Parameters.AddWithValue("@Qty", row["Quantity"]);
                    itemCmd.Parameters.AddWithValue("@Price", row["Price"]);
                    itemCmd.ExecuteNonQuery();
                }

                // Clear cart
                SqlCommand clearCmd = new SqlCommand(
                    "DELETE FROM Cart WHERE UserID = @UserID", conn);
                clearCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                clearCmd.ExecuteNonQuery();

                // Redirect to confirmation
                Response.Redirect($"/OrderConfirmation.aspx?id={orderId}");
            }
        }
    }
}
