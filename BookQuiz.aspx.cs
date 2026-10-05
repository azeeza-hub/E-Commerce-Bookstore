using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Xml;
using System.Text;

namespace PageTurnerBookstore
{
    public partial class BookQuiz : System.Web.UI.Page
    {
        public string QuizQuestionsJson { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadQuizFromXml();
        }

        private void LoadQuizFromXml()
        {
            string xmlPath = Server.MapPath("~/XML/quiz.xml");
            XmlDocument doc = new XmlDocument();
            doc.Load(xmlPath);

            StringBuilder json = new StringBuilder("[");
            XmlNodeList questions = doc.SelectNodes("//question");

            foreach (XmlNode q in questions)
            {
                json.Append("{");
                json.Append("\"id\":\"" + q.Attributes["id"].Value + "\",");
                json.Append("\"text\":\"" + q.Attributes["text"].Value + "\",");
                json.Append("\"options\":[");

                foreach (XmlNode opt in q.SelectNodes("option"))
                {
                    json.Append("{");
                    json.Append("\"value\":\"" + opt.Attributes["value"].Value + "\",");
                    json.Append("\"text\":\"" + opt.InnerText.Replace("\"", "'") + "\"");
                    json.Append("},");
                }

                if (json[json.Length - 1] == ',')
                    json.Remove(json.Length - 1, 1);

                json.Append("]},");
            }

            if (json[json.Length - 1] == ',')
                json.Remove(json.Length - 1, 1);

            json.Append("]");
            QuizQuestionsJson = json.ToString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string genre = hdnGenre.Value;
            if (string.IsNullOrEmpty(genre))
            {
                genre = "Fantasy";
            }

            string connStr = ConfigurationManager.ConnectionStrings["ReadingNookDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT TOP 3 BookID, Title, Author, Series, Genre,
                                 Price, Stock, CoverImage, ISBN
                    FROM Books
                    WHERE Genre = @Genre AND Stock > 0
                    ORDER BY NEWID()", conn);
                cmd.Parameters.AddWithValue("@Genre", genre);
                conn.Open();

                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);

                rptRecommended.DataSource = dt;
                rptRecommended.DataBind();
            }

            string script = "document.getElementById('quizSection').style.display='none';" +
                           "document.getElementById('resultsSection').style.display='block';";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "showResults", script, true);
        }
    }
}