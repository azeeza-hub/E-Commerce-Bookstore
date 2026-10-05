using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using PageTurnerBookstore;

namespace PageTurnerBookstore
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("/Login.aspx");
                return;
            }

            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT c.CartID, c.Quantity, b.BookID, b.Title, b.Author,
                           b.Series, b.Genre, b.Price, b.CoverImage, b.ISBN
                    FROM Cart c
                    JOIN Books b ON c.BookID = b.BookID
                    WHERE c.UserID = @UserID
                    ORDER BY c.AddedDate DESC", conn);

                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlEmpty.Visible = true;
                    pnlCart.Visible = false;
                    return;
                }

                pnlEmpty.Visible = false;
                pnlCart.Visible = true;

                rptCart.DataSource = dt;
                rptCart.DataBind();

                // Calculate totals
                decimal subtotal = 0;
                int itemCount = 0;
                foreach (DataRow row in dt.Rows)
                {
                    subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                    itemCount += Convert.ToInt32(row["Quantity"]);
                }

                decimal shipping = subtotal >= 100 ? 0 : 10;
                decimal total = subtotal + shipping;

                litItemCount.Text = itemCount.ToString();
                litSubtotal.Text = subtotal.ToString("F2");
                litShipping.Text = shipping == 0 ? "FREE" : "RM " + shipping.ToString("F2");
                litTotal.Text = total.ToString("F2");

                if (subtotal >= 100)
                    litShippingMsg.Text = "🎉 You qualify for FREE shipping!";
                else
                    litShippingMsg.Text = $"Add RM {(100 - subtotal):F2} more for FREE shipping!";
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int cartId = Convert.ToInt32(e.CommandArgument);
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (e.CommandName == "Remove")
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Cart WHERE CartID = @CartID", conn);
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Increase")
                {
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Cart SET Quantity = Quantity + 1 WHERE CartID = @CartID", conn);
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Decrease")
                {
                    // Check current quantity first
                    SqlCommand checkCmd = new SqlCommand(
                        "SELECT Quantity FROM Cart WHERE CartID = @CartID", conn);
                    checkCmd.Parameters.AddWithValue("@CartID", cartId);
                    int qty = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (qty <= 1)
                    {
                        // Remove if quantity would go to 0
                        SqlCommand delCmd = new SqlCommand(
                            "DELETE FROM Cart WHERE CartID = @CartID", conn);
                        delCmd.Parameters.AddWithValue("@CartID", cartId);
                        delCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand cmd = new SqlCommand(
                            "UPDATE Cart SET Quantity = Quantity - 1 WHERE CartID = @CartID", conn);
                        cmd.Parameters.AddWithValue("@CartID", cartId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            LoadCart();
        }
    }
}
