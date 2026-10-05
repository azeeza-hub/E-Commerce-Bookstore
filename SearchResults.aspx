<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="PageTurnerBookstore.SearchResults" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .search-wrapper { max-width: 1300px; margin: 0 auto; padding: 60px; }
  .search-hero {
    background: linear-gradient(135deg, #3E2723, #6D4C41);
    padding: 50px 60px;
    margin-bottom: 40px;
    border-radius: 20px;
  }
  .search-hero h1 { font-family: 'Playfair Display', serif; font-size: 36px; color: #D4A017; margin-bottom: 8px; }
  .search-hero p { color: rgba(253,246,236,0.7); font-size: 16px; }
  .search-hero span { color: #D4A017; font-weight: 700; }
  .results-info { font-size: 15px; color: #8B5E3C; margin-bottom: 24px; font-style: italic; }
  .books-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; }
  .book-card { background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.07); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid rgba(212,160,23,0.12); display: flex; flex-direction: column; }
  .book-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(62,39,35,0.14); }
  .book-cover { height: 180px; display: flex; align-items: center; justify-content: center; font-size: 50px; position: relative; }
  .book-badge { position: absolute; top: 10px; right: 10px; background: #D4A017; color: #3E2723; padding: 2px 10px; border-radius: 20px; font-size: 10px; font-weight: 700; text-transform: uppercase; }
  .book-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
  .book-series { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px; }
  .book-title { font-family: 'Playfair Display', serif; font-size: 14px; font-weight: 700; color: #3E2723; margin-bottom: 4px; line-height: 1.3; flex: 1; }
  .book-author { font-size: 12px; color: #6B4C3B; font-style: italic; margin-bottom: 12px; }
  .book-footer { display: flex; justify-content: space-between; align-items: center; margin-top: auto; }
  .book-price { font-size: 18px; font-weight: 700; color: #3E2723; }
  .book-price small { font-size: 11px; color: #6B4C3B; font-weight: 400; display: block; }
  .btn-detail { background: #3E2723; color: #D4A017; border: none; padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 700; cursor: pointer; text-decoration: none; transition: all 0.2s; font-family: 'Lato', sans-serif; }
  .btn-detail:hover { background: #D4A017; color: #3E2723; }
  .no-results { text-align: center; padding: 80px 40px; }
  .no-results .icon { font-size: 70px; margin-bottom: 20px; display: block; }
  .no-results h2 { font-family: 'Playfair Display', serif; font-size: 28px; color: #3E2723; margin-bottom: 12px; }
  .no-results p { color: #8B5E3C; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; margin-bottom: 24px; }
  .btn-browse { display: inline-block; background: #3E2723; color: #D4A017; padding: 14px 36px; border-radius: 10px; font-size: 15px; font-weight: 700; text-decoration: none; transition: all 0.2s; }
  .btn-browse:hover { background: #D4A017; color: #3E2723; }
  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
  .genre-colors-Classic { background: linear-gradient(135deg, #2d2d0a, #6b6b1a); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="search-wrapper">

    <div class="search-hero">
      <h1>🔍 Search Results</h1>
      <p>Showing results for: <span>"<asp:Literal ID="litQuery" runat="server"/>"</span></p>
    </div>

    <div class="results-info">
      <asp:Literal ID="litResultsInfo" runat="server"/>
    </div>

    <asp:Panel ID="pnlResults" runat="server">
      <div class="books-grid">
        <asp:Repeater ID="rptResults" runat="server">
          <ItemTemplate>
            <div class="book-card">
              <div class="book-cover genre-colors-<%# Eval("Genre") %>" style="padding:0; overflow:hidden; position:relative;">
  <%# !string.IsNullOrEmpty(Eval("CoverImage").ToString())
    ? "<img src='/Images/" + Eval("CoverImage") + "' style='width:100%;height:100%;object-fit:cover;display:block;' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'\"/>"
    : "<img src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg' style='width:100%;height:100%;object-fit:cover;display:block;' onerror=\"this.style.display='none'\"/>" %>
  <span class="book-badge" style="position:absolute; top:10px; right:10px;"><%# Eval("Genre") %></span>
</div>
              <div class="book-body">
                <div class="book-series"><%# Eval("Series") %></div>
                <div class="book-title"><%# Eval("Title") %></div>
                <div class="book-author">by <%# Eval("Author") %></div>
                <div class="book-footer">
                  <div class="book-price">
                    RM <%# Eval("Price", "{0:F2}") %>
                    <small><%# Convert.ToInt32(Eval("Stock")) > 0 ? "In Stock" : "Out of Stock" %></small>
                  </div>
                  <a href='BookDetail.aspx?id=<%# Eval("BookID") %>' class="btn-detail">View →</a>
                </div>
              </div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </asp:Panel>

    <asp:Panel ID="pnlNoResults" runat="server" Visible="false">
      <div class="no-results">
        <span class="icon">📚</span>
        <h2>No books found</h2>
        <p>We couldn't find any books matching "<asp:Literal ID="litNoResultsQuery" runat="server"/>"</p>
        <a href="/BookList.aspx" class="btn-browse">Browse All Books →</a>
      </div>
    </asp:Panel>

  </div>
</asp:Content>