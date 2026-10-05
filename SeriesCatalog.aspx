<%@ Page Title="Series Catalog" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SeriesCatalog.aspx.cs" Inherits="PageTurnerBookstore.Pages.SeriesCatalog" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .series-hero {
    background: linear-gradient(135deg, #3E2723 0%, #6D4C41 100%);
    padding: 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  .series-hero::before { content: '📚'; position: absolute; font-size: 200px; opacity: 0.05; right: 100px; top: -20px; }
  .series-hero h1 { font-family: 'Playfair Display', serif; font-size: 48px; color: #D4A017; margin-bottom: 10px; }
  .series-hero p { color: rgba(253,246,236,0.7); font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 22px; }
  .series-wrapper { max-width: 1300px; margin: 0 auto; padding: 60px; }
  .filter-bar { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 40px; justify-content: center; }
  .filter-btn { background: white; border: 2px solid #e8d5c0; color: #6B4C3B; padding: 10px 24px; border-radius: 25px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.2s; font-family: 'Lato', sans-serif; text-decoration: none; display: inline-block; }
  .filter-btn:hover, .filter-btn.active { background: #D4A017; border-color: #D4A017; color: #3E2723; }
  .section-title { font-family: 'Playfair Display', serif; font-size: 28px; color: #3E2723; margin-bottom: 24px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; }
  .series-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 28px; }
  .series-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.08); border: 1px solid rgba(212,160,23,0.15); transition: transform 0.3s, box-shadow 0.3s; }
  .series-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(62,39,35,0.15); }
  .series-card-header { padding: 28px; background: linear-gradient(135deg, #3E2723, #6D4C41); }
  .series-card-name { font-family: 'Playfair Display', serif; font-size: 24px; color: #D4A017; margin-bottom: 4px; }
  .series-card-author { color: rgba(253,246,236,0.7); font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 16px; }
  .series-card-body { padding: 24px; }
  .series-tags { display: flex; gap: 8px; margin-bottom: 16px; flex-wrap: wrap; }
  .tag { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; }
  .tag-genre { background: rgba(212,160,23,0.15); color: #8B5E3C; }
  .tag-count { background: rgba(62,39,35,0.1); color: #6B4C3B; }
  .tag-completed { background: rgba(76,175,80,0.15); color: #2e7d32; }
  .tag-ongoing { background: rgba(33,150,243,0.15); color: #1565C0; }
  .series-year { font-size: 13px; color: #8B5E3C; margin-bottom: 12px; }
  .series-desc { font-size: 14px; color: #555; line-height: 1.7; margin-bottom: 20px; }
  .btn-view-series { display: block; background: #3E2723; color: #D4A017; padding: 14px 24px; border-radius: 10px; font-size: 14px; font-weight: 700; text-decoration: none; text-align: center; transition: all 0.2s; }
  .btn-view-series:hover { background: #D4A017; color: #3E2723; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <div class="series-hero">
    <h1>📚 Browse by Series</h1>
    <p>Dive into a world of complete book collections</p>
  </div>

  <div class="series-wrapper">

    <div class="filter-bar">
      <a href="SeriesCatalog.aspx" class="filter-btn <%=GetActiveClass("") %>">All Series</a>
      <a href="SeriesCatalog.aspx?genre=Fantasy" class="filter-btn <%=GetActiveClass("Fantasy") %>">⚡ Fantasy</a>
      <a href="SeriesCatalog.aspx?genre=Dystopian" class="filter-btn <%=GetActiveClass("Dystopian") %>">🔥 Dystopian</a>
      <a href="SeriesCatalog.aspx?genre=Romance" class="filter-btn <%=GetActiveClass("Romance") %>">💕 Romance</a>
      <a href="SeriesCatalog.aspx?genre=Sci-Fi" class="filter-btn <%=GetActiveClass("Sci-Fi") %>">🚀 Sci-Fi</a>
      <a href="SeriesCatalog.aspx?genre=Children" class="filter-btn <%=GetActiveClass("Children") %>">🌟 Children</a>
    </div>

    <div class="section-title">
      <asp:Literal ID="litSectionTitle" runat="server"/>
    </div>

    <div class="series-grid">
      <asp:Repeater ID="rptSeries" runat="server">
        <ItemTemplate>
          <div class="series-card">
            <div class="series-card-header">
              <div class="series-card-name"><%# Eval("Name") %></div>
              <div class="series-card-author">by <%# Eval("Author") %></div>
            </div>
            <div class="series-card-body">
              <div class="series-tags">
                <span class="tag tag-genre"><%# Eval("Genre") %></span>
                <span class="tag tag-count"><%# Eval("TotalBooks") %> Books</span>
                <span class="tag tag-<%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
              </div>
              <div class="series-year">Started: <%# Eval("StartYear") %></div>
              <div class="series-desc"><%# Eval("Description") %></div>
              <a href='BookList.aspx?series=<%# Server.UrlEncode(Eval("Name").ToString()) %>' class="btn-view-series">
                View All <%# Eval("Name") %> Books →
              </a>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>

  </div>
</asp:Content>