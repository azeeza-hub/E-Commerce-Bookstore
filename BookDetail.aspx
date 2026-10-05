<%@ Page Title="Book Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookDetail.aspx.cs" Inherits="PageTurnerBookstore.BookDetail" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .detail-wrapper { max-width: 1300px; margin: 0 auto; padding: 60px; }
  .breadcrumb { font-size: 13px; color: #8B5E3C; margin-bottom: 30px; }
  .breadcrumb a { color: #8B5E3C; text-decoration: none; }
  .breadcrumb a:hover { color: #D4A017; }
  .detail-grid { display: grid; grid-template-columns: 340px 1fr; gap: 60px; margin-bottom: 60px; }
  .book-cover-large {
    width: 300px;
    height: 450px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(62,39,35,0.2);
    position: sticky;
    top: 90px;
    background: none;
}
.book-cover-large img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center top;
    display: block;
}
  .book-info { padding-top: 10px; }
  .book-series-tag { display: inline-block; background: rgba(212,160,23,0.15); color: #8B5E3C; padding: 4px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px; }
  .book-title-large { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 700; color: #3E2723; line-height: 1.1; margin-bottom: 12px; }
  .book-author-large { font-size: 18px; color: #6B4C3B; font-style: italic; margin-bottom: 24px; font-family: 'Cormorant Garamond', serif; }
  .book-meta { display: flex; gap: 24px; margin-bottom: 30px; flex-wrap: wrap; }
  .meta-item { text-align: center; padding: 16px 24px; background: white; border-radius: 12px; border: 1px solid rgba(212,160,23,0.2); box-shadow: 0 2px 10px rgba(62,39,35,0.06); }
  .meta-value { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 700; color: #3E2723; display: block; }
  .meta-label { font-size: 11px; color: #8B5E3C; text-transform: uppercase; letter-spacing: 1px; }
  .book-description { font-size: 16px; color: #555; line-height: 1.8; margin-bottom: 36px; }
  .price-section { background: linear-gradient(135deg, #FDF6EC, #F5E6D0); border: 1px solid rgba(212,160,23,0.3); border-radius: 16px; padding: 28px; margin-bottom: 24px; }
  .price-large { font-family: 'Playfair Display', serif; font-size: 48px; font-weight: 700; color: #3E2723; margin-bottom: 8px; }
  .price-large span { font-size: 20px; color: #8B5E3C; }
  .stock-info { font-size: 14px; color: #4CAF50; font-weight: 700; margin-bottom: 20px; }
  .btn-addcart { display: inline-block; background: #3E2723; color: #D4A017; padding: 16px 40px; border-radius: 10px; font-size: 16px; font-weight: 700; border: none; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; margin-right: 12px; text-decoration: none; }
  .btn-addcart:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); box-shadow: 0 8px 25px rgba(212,160,23,0.3); }
  .btn-continue { display: inline-block; background: transparent; color: #3E2723; padding: 16px 40px; border-radius: 10px; font-size: 16px; font-weight: 700; border: 2px solid #e8d5c0; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; text-decoration: none; }
  .btn-continue:hover { border-color: #D4A017; color: #D4A017; }
  .qty-wrapper { display: flex; align-items: center; gap: 12px; margin-bottom: 20px; }
  .qty-label { font-size: 14px; font-weight: 700; color: #3E2723; }
  .qty-input { width: 60px; padding: 10px; border: 2px solid #e8d5c0; border-radius: 8px; text-align: center; font-size: 16px; font-family: 'Lato', sans-serif; outline: none; }
  .qty-input:focus { border-color: #D4A017; }
  .series-section { margin-top: 60px; }
  .section-title { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 700; color: #3E2723; margin-bottom: 24px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; }
  .series-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 16px; }
  .series-book { background: white; border-radius: 12px; overflow: hidden; border: 1px solid rgba(212,160,23,0.15); transition: transform 0.2s; text-decoration: none; display: block; }
  .series-book:hover { transform: translateY(-4px); box-shadow: 0 8px 25px rgba(62,39,35,0.12); }
  .series-book-cover { height: 330px; display: flex; align-items: center; justify-content: center; font-size: 50px; position: relative; overflow: hidden; background: #1a1a1a; }
  .series-book-cover img { width: 100%; height: 100%; object-fit: cover; }
  .series-book-body { padding: 12px; }
  .series-book-num { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1px; }
  .series-book-title { font-family: 'Playfair Display', serif; font-size: 13px; font-weight: 700; color: #3E2723; line-height: 1.3; margin-bottom: 4px; }
  .series-book-price { font-size: 14px; font-weight: 700; color: #3E2723; }
  .current-book { border: 2px solid #D4A017 !important; }
  .success-msg { background: #f0fff0; border: 1px solid #ccffcc; color: #006600; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 16px; }
  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
  .genre-colors-Classic { background: linear-gradient(135deg, #2d2d0a, #6b6b1a); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="detail-wrapper">

    <div class="breadcrumb">
      <a href="/Default.aspx">Home</a> →
      <a href="/BookList.aspx">Books</a> →
      <asp:Literal ID="litBreadcrumb" runat="server"/>
    </div>

    <asp:Panel ID="pnlBook" runat="server">
      <div class="detail-grid">

        <div>
          <asp:Literal ID="litCoverClass" runat="server"/>
        </div>

        <div class="book-info">
          <div class="book-series-tag">
            <asp:Literal ID="litSeries" runat="server"/> —
            Book <asp:Literal ID="litSeriesOrder" runat="server"/>
          </div>
          <div class="book-title-large">
            <asp:Literal ID="litTitle" runat="server"/>
          </div>
          <div class="book-author-large">
            by <asp:Literal ID="litAuthor" runat="server"/>
          </div>
          <div class="book-meta">
            <div class="meta-item">
              <span class="meta-value"><asp:Literal ID="litGenre" runat="server"/></span>
              <span class="meta-label">Genre</span>
            </div>
            <div class="meta-item">
              <span class="meta-value"><asp:Literal ID="litStock" runat="server"/></span>
              <span class="meta-label">In Stock</span>
            </div>
            <div class="meta-item">
              <span class="meta-value"><asp:Literal ID="litSeriesCount" runat="server"/></span>
              <span class="meta-label">In Series</span>
            </div>
          </div>
          <div class="book-description">
            <asp:Literal ID="litDescription" runat="server"/>
          </div>
          <div class="price-section">
            <div class="price-large">
              <span>RM</span> <asp:Literal ID="litPrice" runat="server"/>
            </div>
            <div class="stock-info">
              <asp:Literal ID="litStockStatus" runat="server"/>
            </div>
            <asp:Label ID="lblSuccess" runat="server" CssClass="success-msg" Visible="false"/>
            <div class="qty-wrapper">
              <span class="qty-label">Quantity:</span>
              <asp:TextBox ID="txtQty" runat="server" CssClass="qty-input" Text="1"/>
            </div>
            <asp:Button ID="btnAddToCart" runat="server" Text="🛒 Add to Cart"
              CssClass="btn-addcart" OnClick="btnAddToCart_Click"/>
            <a href="/BookList.aspx" class="btn-continue">← Continue Shopping</a>
          </div>
        </div>
      </div>

      <div class="series-section">
        <div class="section-title">More from this Series</div>
        <div class="series-grid">
          <asp:Repeater ID="rptSeries" runat="server">
            <ItemTemplate>
              <a href='BookDetail.aspx?id=<%# Eval("BookID") %>'
                class='series-book <%# Eval("BookID").ToString() == Request.QueryString["id"] ? "current-book" : "" %>'>
               <div class='series-book-cover genre-colors-<%# Eval("Genre") %>'>
  <img src='<%# !string.IsNullOrEmpty(Eval("CoverImage").ToString()) ? "/Images/" + Eval("CoverImage") : "https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg" %>'
       style="width:100%;height:100%;object-fit:contain;display:block;"
       onerror="this.onerror=null;this.src='https://covers.openlibrary.org/b/isbn/<%# Eval("ISBN") %>-M.jpg';"/>
</div>
                <div class="series-book-body">
                  <div class="series-book-num">Book <%# Eval("SeriesOrder") %></div>
                  <div class="series-book-title"><%# Eval("Title") %></div>
                  <div class="series-book-price">RM <%# Eval("Price", "{0:F2}") %></div>
                </div>
              </a>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </asp:Panel>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false">
      <div style="text-align:center; padding:80px; color:#8B5E3C;">
        <div style="font-size:60px; margin-bottom:20px;">📚</div>
        <h2 style="font-family:'Playfair Display',serif; color:#3E2723;">Book not found</h2>
        <a href="/BookList.aspx" style="color:#D4A017;">← Back to Books</a>
      </div>
    </asp:Panel>

  </div>
</asp:Content>