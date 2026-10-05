<%@ Page Title="Order Confirmed!" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="PageTurnerBookstore.OrderConfirmation" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .confirm-wrapper { max-width: 800px; margin: 0 auto; padding: 80px 40px; text-align: center; }
  .success-icon { font-size: 80px; margin-bottom: 24px; display: block; animation: bounce 1s ease; }
  @keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-20px); }
  }
  .confirm-title { font-family: 'Playfair Display', serif; font-size: 48px; color: #3E2723; margin-bottom: 12px; }
  .confirm-sub { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 22px; color: #8B5E3C; margin-bottom: 40px; }
  .order-card {
    background: white;
    border-radius: 20px;
    padding: 36px;
    box-shadow: 0 4px 20px rgba(62,39,35,0.08);
    border: 1px solid rgba(212,160,23,0.2);
    text-align: left;
    margin-bottom: 32px;
  }
  .order-card-title { font-family: 'Playfair Display', serif; font-size: 22px; color: #3E2723; margin-bottom: 20px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; }
  .order-detail-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f0e8de; font-size: 15px; }
  .order-detail-row:last-child { border-bottom: none; }
  .order-detail-label { color: #8B5E3C; }
  .order-detail-value { font-weight: 700; color: #3E2723; }
  .order-items-list { margin-top: 16px; }
  .order-item-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #f0e8de; }
  .order-item-name { font-size: 14px; font-weight: 700; color: #3E2723; }
  .order-item-qty { font-size: 12px; color: #8B5E3C; }
  .order-item-price { font-size: 14px; font-weight: 700; color: #3E2723; }
  .status-badge {
    display: inline-block;
    background: rgba(76,175,80,0.15);
    color: #2e7d32;
    padding: 4px 16px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
  }
  .btn-primary {
    display: inline-block;
    background: #3E2723;
    color: #D4A017;
    padding: 16px 40px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
    transition: all 0.2s;
    margin: 8px;
  }
  .btn-primary:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); }
  .btn-secondary {
    display: inline-block;
    background: transparent;
    color: #3E2723;
    padding: 16px 40px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
    border: 2px solid #e8d5c0;
    transition: all 0.2s;
    margin: 8px;
  }
  .btn-secondary:hover { border-color: #D4A017; color: #D4A017; }
  .confetti { font-size: 24px; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="confirm-wrapper">
    <span class="success-icon">🎉</span>
    <h1 class="confirm-title">Order Placed!</h1>
    <p class="confirm-sub">Thank you for shopping at The Reading Nook. Your books are on their way!</p>

    <div class="order-card">
      <div class="order-card-title">📋 Order Details</div>
      <div class="order-detail-row">
        <span class="order-detail-label">Order ID</span>
        <span class="order-detail-value">#<asp:Literal ID="litOrderId" runat="server"/></span>
      </div>
      <div class="order-detail-row">
        <span class="order-detail-label">Order Date</span>
        <span class="order-detail-value"><asp:Literal ID="litOrderDate" runat="server"/></span>
      </div>
      <div class="order-detail-row">
        <span class="order-detail-label">Total Amount</span>
        <span class="order-detail-value" style="color:#D4A017; font-size:18px;">RM <asp:Literal ID="litTotal" runat="server"/></span>
      </div>
      <div class="order-detail-row">
        <span class="order-detail-label">Shipping Address</span>
        <span class="order-detail-value"><asp:Literal ID="litAddress" runat="server"/></span>
      </div>
      <div class="order-detail-row">
        <span class="order-detail-label">Status</span>
        <span class="order-detail-value"><span class="status-badge">✅ Confirmed</span></span>
      </div>
    </div>

    <div class="order-card">
      <div class="order-card-title">📚 Your Books</div>
      <div class="order-items-list">
        <asp:Repeater ID="rptItems" runat="server">
          <ItemTemplate>
            <div class="order-item-row">
              <div>
                <div class="order-item-name"><%# Eval("Title") %></div>
                <div class="order-item-qty">by <%# Eval("Author") %> • Qty: <%# Eval("Quantity") %></div>
              </div>
              <div class="order-item-price">RM <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("UnitPrice")) * Convert.ToInt32(Eval("Quantity"))) %></div>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>

    <div>
      <a href="/BookList.aspx" class="btn-primary">Continue Shopping →</a>
      <a href="/OrderHistory.aspx" class="btn-secondary">View Order History</a>
    </div>
  </div>
</asp:Content>