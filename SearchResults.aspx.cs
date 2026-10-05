using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PageTurnerBookstore
{
    public partial class SearchResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = Request.QueryString["q"] ?? "";
                litQuery.Text = query;
                litNoResultsQuery.Text = query;

                if (!string.IsNullOrEmpty(query))
                    SearchBooks(query);
                else
                    Response.Redirect("/BookList.aspx");
            }
        }

        private void SearchBooks(string query)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT * FROM Books
                    WHERE Title LIKE @Query
                    OR Author LIKE @Query
                    OR Series LIKE @Query
                    OR Genre LIKE @Query
                    ORDER BY Title", conn);

                cmd.Parameters.AddWithValue("@Query", "%" + query + "%");
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptResults.DataSource = dt;
                    rptResults.DataBind();
                    litResultsInfo.Text = $"Found <strong>{dt.Rows.Count}</strong> result(s) for \"{query}\"";
                    pnlNoResults.Visible = false;
                    pnlResults.Visible = true;
                }
                else
                {
                    pnlNoResults.Visible = true;
                    pnlResults.Visible = false;
                    litResultsInfo.Text = "";
                }
            }
        }
    }
}