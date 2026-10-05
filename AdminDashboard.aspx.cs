using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Text;

namespace PageTurnerBookstore
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("/Default.aspx");
                return;
            }

            connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            litAdminName.Text = Session["FullName"].ToString();

            if (!IsPostBack)
                LoadDashboard();
        }

        private void LoadDashboard()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Stats
                SqlCommand statsCmd = new SqlCommand(@"
                    SELECT
                        (SELECT COUNT(*) FROM Books) AS TotalBooks,
                        (SELECT COUNT(*) FROM Users WHERE Role = 'Customer') AS TotalUsers,
                        (SELECT COUNT(*) FROM Orders) AS TotalOrders,
                        (SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders) AS Revenue", conn);

                SqlDataReader statsReader = statsCmd.ExecuteReader();
                if (statsReader.Read())
                {
                    litTotalBooks.Text = statsReader["TotalBooks"].ToString();
                    litTotalUsers.Text = statsReader["TotalUsers"].ToString();
                    litTotalOrders.Text = statsReader["TotalOrders"].ToString();
                    litRevenue.Text = string.Format("{0:F2}", statsReader["Revenue"]);
                    litOrderCount.Text = statsReader["TotalOrders"].ToString();
                }
                statsReader.Close();

                // Orders
                SqlCommand ordersCmd = new SqlCommand(@"
                    SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.Status, u.FullName
                    FROM Orders o
                    JOIN Users u ON o.UserID = u.UserID
                    ORDER BY o.OrderDate DESC", conn);
                DataTable ordersTable = new DataTable();
                new SqlDataAdapter(ordersCmd).Fill(ordersTable);
                rptOrders.DataSource = ordersTable;
                rptOrders.DataBind();

                // Users
                SqlCommand usersCmd = new SqlCommand(
                    "SELECT * FROM Users ORDER BY CreatedDate DESC", conn);
                DataTable usersTable = new DataTable();
                new SqlDataAdapter(usersCmd).Fill(usersTable);
                rptUsers.DataSource = usersTable;
                rptUsers.DataBind();

                // Books
                SqlCommand booksCmd = new SqlCommand(
                    "SELECT * FROM Books ORDER BY Series, SeriesOrder", conn);
                DataTable booksTable = new DataTable();
                new SqlDataAdapter(booksCmd).Fill(booksTable);
                rptBooks.DataSource = booksTable;
                rptBooks.DataBind();

                // Charts
                LoadChartData(conn);
            }
        }

        private void LoadChartData(SqlConnection conn)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script>\n");

            // Sales per month
            SqlCommand salesCmd = new SqlCommand(@"
                SELECT FORMAT(OrderDate,'MMM yyyy') AS Month,
                       COUNT(*) AS Orders,
                       SUM(TotalAmount) AS Revenue
                FROM Orders
                GROUP BY FORMAT(OrderDate,'MMM yyyy'),
                         YEAR(OrderDate), MONTH(OrderDate)
                ORDER BY YEAR(OrderDate), MONTH(OrderDate)", conn);
            DataTable salesDt = new DataTable();
            new SqlDataAdapter(salesCmd).Fill(salesDt);

            sb.Append("var salesLabels=[");
            foreach (DataRow r in salesDt.Rows)
                sb.Append($"'{r["Month"]}',");
            sb.Append("];\n");

            sb.Append("var salesOrders=[");
            foreach (DataRow r in salesDt.Rows)
                sb.Append($"{r["Orders"]},");
            sb.Append("];\n");

            sb.Append("var salesRevenue=[");
            foreach (DataRow r in salesDt.Rows)
                sb.Append($"{r["Revenue"]},");
            sb.Append("];\n");

            // Genre distribution
            SqlCommand genreCmd = new SqlCommand(
                "SELECT Genre, COUNT(*) AS Total FROM Books GROUP BY Genre", conn);
            DataTable genreDt = new DataTable();
            new SqlDataAdapter(genreCmd).Fill(genreDt);

            sb.Append("var genreLabels=[");
            foreach (DataRow r in genreDt.Rows)
                sb.Append($"'{r["Genre"]}',");
            sb.Append("];\n");

            sb.Append("var genreData=[");
            foreach (DataRow r in genreDt.Rows)
                sb.Append($"{r["Total"]},");
            sb.Append("];\n");

            // Order status
            SqlCommand statusCmd = new SqlCommand(
                "SELECT Status, COUNT(*) AS Total FROM Orders GROUP BY Status", conn);
            DataTable statusDt = new DataTable();
            new SqlDataAdapter(statusCmd).Fill(statusDt);

            sb.Append("var statusLabels=[");
            foreach (DataRow r in statusDt.Rows)
                sb.Append($"'{r["Status"]}',");
            sb.Append("];\n");

            sb.Append("var statusData=[");
            foreach (DataRow r in statusDt.Rows)
                sb.Append($"{r["Total"]},");
            sb.Append("];\n");

            sb.Append("</script>");
            litChartData.Text = sb.ToString();
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                DropDownList ddl = (DropDownList)e.Item.FindControl("ddlStatus");
                string newStatus = ddl.SelectedValue;
                int orderId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Orders SET Status = @Status WHERE OrderID = @OrderID", conn);
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadDashboard();
            }
        }

        // ── XML EXPORT ──────────────────────────────────────────
        protected void btnExportXML_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    DataTable dt = new DataTable();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT BookID, Title, Author, Genre, Series, SeriesOrder, " +
                        "Price, Stock, ISBN, CoverImage FROM Books ORDER BY Series, SeriesOrder", conn);
                    new SqlDataAdapter(cmd).Fill(dt);

                    string filePath = Server.MapPath("~/XML/books.xml");

                    using (XmlWriter writer = XmlWriter.Create(filePath,
                        new XmlWriterSettings { Indent = true }))
                    {
                        writer.WriteStartDocument();
                        writer.WriteDocType("books", null, "books.dtd", null);
                        writer.WriteStartElement("books");

                        foreach (DataRow row in dt.Rows)
                        {
                            writer.WriteStartElement("book");
                            writer.WriteAttributeString("id", row["BookID"].ToString());
                            writer.WriteElementString("title", row["Title"].ToString());
                            writer.WriteElementString("author", row["Author"].ToString());
                            writer.WriteElementString("genre", row["Genre"].ToString());
                            writer.WriteElementString("series", row["Series"].ToString());
                            writer.WriteElementString("seriesOrder", row["SeriesOrder"].ToString());
                            writer.WriteElementString("price", row["Price"].ToString());
                            writer.WriteElementString("stock", row["Stock"].ToString());
                            writer.WriteElementString("isbn", row["ISBN"].ToString());
                            writer.WriteElementString("coverImage", row["CoverImage"].ToString());
                            writer.WriteEndElement();
                        }

                        writer.WriteEndElement();
                        writer.WriteEndDocument();
                    }

                    lblExportMsg.Text = "✅ XML exported successfully! Now click Generate XSLT Report.";
                    pnlReport.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblExportMsg.Text = "❌ Error: " + ex.Message;
            }
        }

        // ── XSLT REPORT ─────────────────────────────────────────
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            try
            {
                string xmlPath = Server.MapPath("~/XML/books.xml");
                string xsltPath = Server.MapPath("~/XML/books.xslt");

                if (!File.Exists(xmlPath))
                {
                    lblExportMsg.Text = "⚠️ Please export XML first!";
                    return;
                }

                XslCompiledTransform xslt = new XslCompiledTransform();
                xslt.Load(xsltPath);

                XmlReaderSettings settings = new XmlReaderSettings();
                settings.DtdProcessing = DtdProcessing.Ignore;

                StringWriter sw = new StringWriter();
                XmlWriter xw = XmlWriter.Create(sw,
                    new XmlWriterSettings { OmitXmlDeclaration = true });

                using (XmlReader reader = XmlReader.Create(xmlPath, settings))
                {
                    xslt.Transform(reader, xw);
                }

                litXmlReport.Text = sw.ToString();
                pnlReport.Visible = true;
                lblExportMsg.Text = "✅ XSLT report generated successfully!";
            }
            catch (Exception ex)
            {
                lblExportMsg.Text = "❌ Error: " + ex.Message;
            }
        }

        // ── DTD VALIDATION ──────────────────────────────────────
        protected void btnValidateDTD_Click(object sender, EventArgs e)
        {
            string xmlPath = Server.MapPath("~/XML/books.xml");

            if (!File.Exists(xmlPath))
            {
                lblExportMsg.Text = "⚠️ Please export XML first before validating!";
                return;
            }

            if (ValidateXml(xmlPath))
                lblExportMsg.Text = "✅ XML is valid and matches the DTD structure!";

            pnlReport.Visible = false;
        }

        private bool ValidateXml(string xmlPath)
        {
            try
            {
                XmlReaderSettings settings = new XmlReaderSettings();
                settings.DtdProcessing = DtdProcessing.Parse;
                settings.ValidationType = ValidationType.DTD;
                settings.XmlResolver = new XmlUrlResolver();
                settings.ValidationEventHandler +=
                    (s, ex) => { throw new Exception(ex.Message); };

                using (XmlReader reader = XmlReader.Create(xmlPath, settings))
                {
                    while (reader.Read()) { }
                }
                return true;
            }
            catch (Exception ex)
            {
                lblExportMsg.Text = "❌ XML Validation failed: " + ex.Message;
                return false;
            }
        }
    }
}