using System;
using System.Data;
using System.Xml;

namespace PageTurnerBookstore.Pages
{
    public partial class SeriesCatalog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string genre = Request.QueryString["genre"] ?? "";
                LoadSeries(genre);
            }
        }

        private void LoadSeries(string genreFilter)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Name");
            dt.Columns.Add("Author");
            dt.Columns.Add("Genre");
            dt.Columns.Add("TotalBooks");
            dt.Columns.Add("Status");
            dt.Columns.Add("StartYear");
            dt.Columns.Add("Description");

            string xmlPath = Server.MapPath("~/XML/series.xml");
            XmlDocument doc = new XmlDocument();
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.DtdProcessing = DtdProcessing.Parse;
            using (XmlReader reader = XmlReader.Create(xmlPath, settings))
            {
                doc.Load(reader);
            }

            XmlNodeList seriesList = doc.SelectNodes("//collection");
            foreach (XmlNode s in seriesList)
            {
                string genre = s.SelectSingleNode("genre")?.InnerText ?? "";
                if (!string.IsNullOrEmpty(genreFilter) && genre != genreFilter)
                    continue;

                dt.Rows.Add(
                    s.SelectSingleNode("name")?.InnerText,
                    s.SelectSingleNode("author")?.InnerText,
                    genre,
                    s.SelectSingleNode("totalBooks")?.InnerText,
                    s.SelectSingleNode("status")?.InnerText,
                    s.SelectSingleNode("startYear")?.InnerText,
                    s.SelectSingleNode("description")?.InnerText
                );
            }

            string title = string.IsNullOrEmpty(genreFilter)
                ? $"All Series ({dt.Rows.Count} collections)"
                : $"{genreFilter} Series ({dt.Rows.Count} collections)";

            litSectionTitle.Text = title;
            rptSeries.DataSource = dt;
            rptSeries.DataBind();
        }

        public string GetActiveClass(string genre)
        {
            string current = Request.QueryString["genre"] ?? "";
            return current == genre ? "active" : "";
        }
    }
}