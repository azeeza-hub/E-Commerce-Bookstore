using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PageTurnerBookstore
{
    public partial class BookDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bookId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(bookId))
                {
                    pnlBook.Visible = false;
                    pnlNotFound.Visible = true;
                    return;
                }
                LoadBook(bookId);
            }
        }

        private void LoadBook(string bookId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Books WHERE BookID = @BookID", conn);
                cmd.Parameters.AddWithValue("@BookID", bookId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string genre = reader["Genre"].ToString();
                    string series = reader["Series"].ToString();
                    string title = reader["Title"].ToString();

                    litBreadcrumb.Text = title;
                    litTitle.Text = title;
                    litAuthor.Text = reader["Author"].ToString();
                    litSeries.Text = series;
                    litSeriesOrder.Text = reader["SeriesOrder"].ToString();
                    litGenre.Text = genre;
                    litDescription.Text = reader["Description"].ToString();
                    litPrice.Text = string.Format("{0:F2}", reader["Price"]);
                    litStock.Text = reader["Stock"].ToString();

                    string coverImage = reader["CoverImage"] != DBNull.Value ? reader["CoverImage"].ToString() : "";
                    string isbn = reader["ISBN"] != DBNull.Value ? reader["ISBN"].ToString() : "";

                    if (!string.IsNullOrEmpty(coverImage))
                        litCoverClass.Text = $"<div class='book-cover-large genre-colors-{genre}' style='padding:0;background:none;'><img src='/Images/{coverImage}' style='width:100%;height:100%;object-fit:cover;object-position:center center;display:block;' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/{isbn}-L.jpg'\"/></div>";
                    else if (!string.IsNullOrEmpty(isbn))
                        litCoverClass.Text = $"<div class='book-cover-large genre-colors-{genre}' style='padding:0;background:none;'><img src='https://covers.openlibrary.org/b/isbn/{isbn}-L.jpg' style='width:100%;height:100%;object-fit:cover;object-position:center center;display:block;'/></div>";
                    else
                        litCoverClass.Text = $"<div class='book-cover-large genre-colors-{genre}'>📖</div>";

                    int stock = Convert.ToInt32(reader["Stock"]);
                    if (stock == 0)
                    {
                        litStockStatus.Text = "❌ Out of Stock";
                        btnAddToCart.Enabled = false;
                    }
                    else if (stock < 10)
                        litStockStatus.Text = $"⚠️ Only {stock} left in stock!";
                    else
                        litStockStatus.Text = $"✅ {stock} copies available";

                    reader.Close();
                    LoadSeriesBooks(series, bookId, conn);
                }
                else
                {
                    pnlBook.Visible = false;
                    pnlNotFound.Visible = true;
                }
            }
        }

        private void LoadSeriesBooks(string series, string currentBookId, SqlConnection conn)
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT BookID, Title, Author, Genre, Price, SeriesOrder, ISBN, CoverImage FROM Books WHERE Series = @SeriesName ORDER BY SeriesOrder", conn);
            cmd.Parameters.AddWithValue("@SeriesName", series);

            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            litSeriesCount.Text = dt.Rows.Count.ToString();
            rptSeries.DataSource = dt;
            rptSeries.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("/Login.aspx");
                return;
            }

            string bookId = Request.QueryString["id"];
            int qty = 1;
            int.TryParse(txtQty.Text, out qty);
            if (qty < 1) qty = 1;

            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand checkCmd = new SqlCommand(
                    "SELECT CartID FROM Cart WHERE UserID=@UserID AND BookID=@BookID", conn);
                checkCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                checkCmd.Parameters.AddWithValue("@BookID", bookId);

                object existing = checkCmd.ExecuteScalar();

                if (existing != null)
                {
                    SqlCommand updateCmd = new SqlCommand(
                        "UPDATE Cart SET Quantity = Quantity + @Qty WHERE UserID=@UserID AND BookID=@BookID", conn);
                    updateCmd.Parameters.AddWithValue("@Qty", qty);
                    updateCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    updateCmd.Parameters.AddWithValue("@BookID", bookId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand insertCmd = new SqlCommand(
                        "INSERT INTO Cart (UserID, BookID, Quantity) VALUES (@UserID, @BookID, @Qty)", conn);
                    insertCmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    insertCmd.Parameters.AddWithValue("@BookID", bookId);
                    insertCmd.Parameters.AddWithValue("@Qty", qty);
                    insertCmd.ExecuteNonQuery();
                }
            }

            lblSuccess.Text = "✅ Added to cart successfully!";
            lblSuccess.Visible = true;
        }
    }
}