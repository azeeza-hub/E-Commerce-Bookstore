<%@ Page Title="Order History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="PageTurnerBookstore.OrderHistory" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .history-wrapper { max-width: 1000px; margin: 0 auto; padding: 60px; }
  .page-title { font-family: 'Playfair Display', serif; font-size: 42px; color: #3E2723; margin-bottom: 8px; }
  .page-sub { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: #8B5E3C; margin-bottom: 40px; }

  .order-card {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(62,39,35,0.07);
    border: 1px solid rgba(212,160,23,0.12);
    margin-bottom: 24px;
    transition: box-shadow 0.2s;
  }
  .order-card:hover { box-shadow: 0 8px 30px rgba(62,39,35,0.12); }
  .order-header {
    background: linear-gradient(135deg, #3E2723, #6D4C41);
    padding: 20px 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .order-id { font-family: 'Playfair Display', serif; font-size: 20px; color: #D4A017; font-weight: 700; }
  .order-date { color: rgba(253,246,236,0.7); font-size: 13px; }
  .order-status {
    padding: 5px 16px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .status-pending { background: rgba(255,193,7,0.2); color: #FFC107; border: 1px solid rgba(255,193,7,0.4); }
  .status-confirmed { background: rgba(76,175,80,0.2); color: #4CAF50; border: 1px solid rgba(76,175,80,0.4); }
  .status-shipped { background: rgba(33,150,243,0.2); color: #2196F3; border: 1px solid rgba(33,150,243,0.4); }
  .status-delivered { background: rgba(76,175,80,0.3); color: #2e7d32; border: 1px solid rgba(76,175,80,0.5); }
  .order-body { padding: 24px 28px; }
  .order-items-grid { display: flex; flex-direction: column; gap: 12px; margin-bottom: 20px; }
  .order-item-row {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 12px;
    background: #FFFDF9;
    border-radius: 10px;
    border: 1px solid #f0e8de;
  }
  .order-item-cover {
    width: 48px; height: 60px;
    border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    font-size: 24px;
    flex-shrink: 0;
  }
  .order-item-info { flex: 1; }
  .order-item-title { font-size: 14px; font-weight: 700; color: #3E2723; margin-bottom: 2px; }
  .order-item-author { font-size: 12px; color: #8B5E3C; font-style: italic; }
  .order-item-qty { font-size: 12px; color: #8B5E3C; margin-top: 2px; }
  .order-item-price { font-size: 15px; font-weight: 700; color: #3E2723; white-space: nowrap; }
  .order-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 16px;
    border-top: 1px solid #f0e8de;
  }
  .order-total { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 700; color: #D4A017; }
  .order-total span { font-size: 14px; color: #8B5E3C; font-family: 'Lato', sans-serif; font-weight: 400; margin-right: 8px; }
  .btn-reorder {
    background: #3E2723;
    color: #D4A017;
    padding: 10px 24px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 700;
    text-decoration: none;
    transition: all 0.2s;
    border: none;
    cursor: pointer;
    font-family: 'Lato', sans-serif;
  }
  .btn-reorder:hover { background: #D4A017; color: #3E2723; }

  .empty-history { text-align: center; padding: 80px 40px; }
  .empty-history .icon { font-size: 70px; margin-bottom: 24px; display: block; }
  .empty-history h2 { font-family: 'Playfair Display', serif; font-size: 28px; color: #3E2723; margin-bottom: 12px; }
  .empty-history p { color: #8B5E3C; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; margin-bottom: 30px; }
  .btn-shop { display: inline-block; background: #3E2723; color: #D4A017; padding: 16px 40px; border-radius: 10px; font-size: 16px; font-weight: 700; text-decoration: none; transition: all 0.2s; }
  .btn-shop:hover { background: #D4A017; color: #3E2723; }

  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
  .genre-colors-Classic { background: linear-gradient(135deg, #2d2d0a, #6b6b1a); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="history-wrapper">
    <h1 class="page-title">📋 Order History</h1>
    <p class="page-sub">All your past orders in one place</p>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
      <div class="empty-history">
        <span class="icon">📦</span>
        <h2>No orders yet!</h2>
        <p>You haven't placed any orders yet. Start browsing!</p>
        <a href="/BookList.aspx" class="btn-shop">Browse Books →</a>
      </div>
    </asp:Panel>

    <asp:Panel ID="pnlOrders" runat="server">
      <asp:Repeater ID="rptOrders" runat="server">
        <ItemTemplate>
          <div class="order-card">
            <div class="order-header">
              <div>
                <div class="order-id">Order #<%# Eval("OrderID") %></div>
                <div class="order-date">Placed on <%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd MMMM yyyy") %></div>
              </div>
              <span class="order-status status-<%# Eval("Status").ToString().ToLower() %>">
                <%# Eval("Status") %>
              </span>
            </div>
            <div class="order-body">
              <div class="order-items-grid">
                <asp:Repeater ID="rptItems" runat="server" DataSource='<%# GetOrderItems(Convert.ToInt32(Eval("OrderID"))) %>'>
                  <ItemTemplate>
                    <div class="order-item-row">
                      <div class="order-item-cover genre-colors-<%# Eval("Genre") %>" style="padding:0; overflow:hidden;">
  <%# !string.IsNullOrEmpty(Eval("CoverImage").ToString())
    ? "<img src='/Images/" + Eval("CoverImage") + "' style='width:100%;height:100%;object-fit:cover;border-radius:6px;' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'\"/>"
    : "<img src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg' style='width:100%;height:100%;object-fit:cover;border-radius:6px;' onerror=\"this.style.display='none'\"/>" %>
</div>
                      <div class="order-item-info">
                        <div class="order-item-title"><%# Eval("Title") %></div>
                        <div class="order-item-author">by <%# Eval("Author") %></div>
                        <div class="order-item-qty">Quantity: <%# Eval("Quantity") %></div>
                      </div>
                      <div class="order-item-price">RM <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("UnitPrice")) * Convert.ToInt32(Eval("Quantity"))) %></div>
                    </div>
                  </ItemTemplate>
                </asp:Repeater>
              </div>
              <div class="order-footer">
                <div class="order-total">
                  <span>Total Paid</span>
                  RM <%# string.Format("{0:F2}", Eval("TotalAmount")) %>
                </div>
                <a href='/OrderConfirmation.aspx?id=<%# Eval("OrderID") %>' class="btn-reorder">View Details →</a>
              </div>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </asp:Panel>

  </div>
</asp:Content>