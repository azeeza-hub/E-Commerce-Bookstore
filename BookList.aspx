<%@ Page Title="All Books" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookList.aspx.cs" Inherits="PageTurnerBookstore.BookList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .page-hero {
    background: linear-gradient(135deg, #3E2723 0%, #6D4C41 100%);
    padding: 50px 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }
  .page-hero::before { content: '📚'; position: absolute; font-size: 200px; opacity: 0.05; right: 100px; top: -20px; }
  .page-hero h1 { font-family: 'Playfair Display', serif; font-size: 42px; color: #D4A017; margin-bottom: 10px; }
  .page-hero p { color: rgba(253,246,236,0.7); font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; }
  .books-container { max-width: 1300px; margin: 0 auto; padding: 40px 60px; }
  .filter-bar { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 40px; align-items: center; }
  .filter-label { font-weight: 700; color: #3E2723; font-size: 14px; margin-right: 4px; }
  .filter-btn { background: white; border: 2px solid #e8d5c0; color: #6B4C3B; padding: 8px 20px; border-radius: 25px; font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.2s; font-family: 'Lato', sans-serif; text-decoration: none; display: inline-block; }
  .filter-btn:hover, .filter-btn.active { background: #D4A017; border-color: #D4A017; color: #3E2723; }
  .results-info { color: #8B5E3C; font-size: 14px; margin-bottom: 24px; font-style: italic; }
  .books-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; }
  .book-card { background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(62,39,35,0.07); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid rgba(212,160,23,0.12); display: flex; flex-direction: column; }
  .book-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(62,39,35,0.14); }
.book-cover { height: 418px; display: flex; align-items: center; justify-content: center; font-size: 50px; position: relative; overflow: hidden; background: #1a1a1a; } 
.book-cover img { 'width:100%; height:100%; object-fit:cover; display:block;' }
  .book-cover-fallback { font-size: 50px; }
  .book-badge { position: absolute; top: 10px; right: 10px; background: #D4A017; color: #3E2723; padding: 2px 10px; border-radius: 20px; font-size: 10px; font-weight: 700; text-transform: uppercase; z-index: 1; }
  .book-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
  .book-series { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px; }
  .book-title { font-family: 'Playfair Display', serif; font-size: 14px; font-weight: 700; color: #3E2723; margin-bottom: 4px; line-height: 1.3; flex: 1; }
  .book-author { font-size: 12px; color: #6B4C3B; font-style: italic; margin-bottom: 12px; }
  .book-footer { display: flex; justify-content: space-between; align-items: center; margin-top: auto; }
  .book-price { font-size: 18px; font-weight: 700; color: #3E2723; }
  .book-price small { font-size: 11px; color: #6B4C3B; font-weight: 400; display: block; }
  .btn-detail { background: #3E2723; color: #D4A017; border: none; padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 700; cursor: pointer; text-decoration: none; transition: all 0.2s; font-family: 'Lato', sans-serif; }
  .btn-detail:hover { background: #D4A017; color: #3E2723; }
  .no-books { text-align: center; padding: 60px; color: #8B5E3C; font-size: 18px; font-family: 'Cormorant Garamond', serif; font-style: italic; }
  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
  .genre-colors-Classic { background: linear-gradient(135deg, #2d2d0a, #6b6b1a); }
  .genre-colors-Self-Help { background: linear-gradient(135deg, #1a0a2d, #3a1a6b); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <div class="page-hero">
    <h1>📚 All Books</h1>
    <p>Explore our complete collection of <asp:Literal ID="litTotal" runat="server"/> books</p>
  </div>

  <div class="books-container">

    <div class="filter-bar">
      <span class="filter-label">Filter:</span>
      <a href="BookList.aspx" class="filter-btn <%=GetActiveClass("") %>">All</a>
      <a href="BookList.aspx?genre=Fantasy" class="filter-btn <%=GetActiveClass("Fantasy") %>">⚡ Fantasy</a>
      <a href="BookList.aspx?genre=Dystopian" class="filter-btn <%=GetActiveClass("Dystopian") %>">🔥 Dystopian</a>
      <a href="BookList.aspx?genre=Romance" class="filter-btn <%=GetActiveClass("Romance") %>">💕 Romance</a>
      <a href="BookList.aspx?genre=Sci-Fi" class="filter-btn <%=GetActiveClass("Sci-Fi") %>">🚀 Sci-Fi</a>
      <a href="BookList.aspx?genre=Children" class="filter-btn <%=GetActiveClass("Children") %>">🌟 Children</a>
      <a href="BookList.aspx?genre=Classic" class="filter-btn <%=GetActiveClass("Classic") %>">📖 Classic</a>
      <a href="BookList.aspx?genre=Self-Help" class="filter-btn <%=GetActiveClass("Self-Help") %>">💡 Self-Help</a>
    </div>

    <div class="results-info">
      <asp:Literal ID="litResults" runat="server"/>
    </div>

    <div class="books-grid">
      <asp:Repeater ID="rptBooks" runat="server">
        <ItemTemplate>
          <div class="book-card">
           <div class="book-cover genre-colors-<%# Eval("Genre") %>">
  <%# !string.IsNullOrEmpty(Eval("CoverImage").ToString())
    ? "<img src='/Images/" + Eval("CoverImage") + "' style='width:100%;height:100%;object-fit:cover;display:block;' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'\"/>"
    : "<img src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg' style='width:100%;height:100%;object-fit:cover;display:block;' onerror=\"this.style.display='none';this.parentElement.innerHTML+='<span class=book-cover-fallback>📖</span>'\"/>" %>
  <span class="book-badge"><%# Eval("Genre") %></span>
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

    <asp:Panel ID="pnlNoBooks" runat="server" Visible="false">
      <div class="no-books">No books found for this filter. Try another genre!</div>
    </asp:Panel>

  </div>
</asp:Content>