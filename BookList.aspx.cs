using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PageTurnerBookstore
{
    public partial class BookList : System.Web.UI.Page
    {
        private string currentGenre = "";
        private string currentSeries = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                currentGenre = Request.QueryString["genre"] ?? "";
                currentSeries = Request.QueryString["series"] ?? "";
                LoadBooks();
            }
        }

        private void LoadBooks()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd;

                if (!string.IsNullOrEmpty(currentSeries))
                {
                    cmd = new SqlCommand(
                        "SELECT * FROM Books WHERE Series = @Series ORDER BY SeriesOrder", conn);
                    cmd.Parameters.AddWithValue("@Series", currentSeries);
                }
                else if (!string.IsNullOrEmpty(currentGenre))
                {
                    cmd = new SqlCommand(
                        "SELECT * FROM Books WHERE Genre = @Genre ORDER BY Series, SeriesOrder", conn);
                    cmd.Parameters.AddWithValue("@Genre", currentGenre);
                }
                else
                {
                    cmd = new SqlCommand(
                        "SELECT * FROM Books ORDER BY Series, SeriesOrder", conn);
                }

                conn.Open();
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptBooks.DataSource = dt;
                    rptBooks.DataBind();
                    litTotal.Text = dt.Rows.Count.ToString();

                    if (!string.IsNullOrEmpty(currentSeries))
                        litResults.Text = $"Showing {dt.Rows.Count} books in <strong>{currentSeries}</strong> series";
                    else if (!string.IsNullOrEmpty(currentGenre))
                        litResults.Text = $"Showing {dt.Rows.Count} books in <strong>{currentGenre}</strong>";
                    else
                        litResults.Text = $"Showing all {dt.Rows.Count} books";

                    pnlNoBooks.Visible = false;
                }
                else
                {
                    pnlNoBooks.Visible = true;
                    litResults.Text = "No books found";
                }
            }
        }

        public string GetActiveClass(string genre)
        {
            currentGenre = Request.QueryString["genre"] ?? "";
            return currentGenre == genre ? "active" : "";
        }
    }
}