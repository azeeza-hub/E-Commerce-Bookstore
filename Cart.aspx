<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="PageTurnerBookstore.Cart" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .cart-wrapper { max-width: 1200px; margin: 0 auto; padding: 60px; }
  .page-title { font-family: 'Playfair Display', serif; font-size: 42px; color: #3E2723; margin-bottom: 8px; }
  .page-sub { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: #8B5E3C; margin-bottom: 40px; }
  .cart-grid { display: grid; grid-template-columns: 1fr 360px; gap: 40px; align-items: start; }
  .cart-items { display: flex; flex-direction: column; gap: 16px; }
  .cart-item {
    background: white;
    border-radius: 16px;
    padding: 24px;
    display: flex;
    align-items: center;
    gap: 24px;
    box-shadow: 0 4px 20px rgba(62,39,35,0.07);
    border: 1px solid rgba(212,160,23,0.12);
    transition: box-shadow 0.2s;
  }
  .cart-item:hover { box-shadow: 0 8px 30px rgba(62,39,35,0.12); }
  .cart-item-cover {
    width: 80px;
    height: 100px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 36px;
    flex-shrink: 0;
  }
  .cart-item-info { flex: 1; }
  .cart-item-series { font-size: 10px; font-weight: 700; color: #D4A017; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px; }
  .cart-item-title { font-family: 'Playfair Display', serif; font-size: 18px; font-weight: 700; color: #3E2723; margin-bottom: 4px; }
  .cart-item-author { font-size: 13px; color: #8B5E3C; font-style: italic; }
  .cart-item-price { font-size: 22px; font-weight: 700; color: #3E2723; text-align: right; }
  .cart-item-subtotal { font-size: 12px; color: #8B5E3C; }
  .qty-controls { display: flex; align-items: center; gap: 8px; }
  .qty-btn {
    width: 32px; height: 32px;
    border-radius: 50%;
    border: 2px solid #e8d5c0;
    background: white;
    font-size: 18px;
    cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    transition: all 0.2s;
    font-family: 'Lato', sans-serif;
    color: #3E2723;
  }
  .qty-btn:hover { background: #D4A017; border-color: #D4A017; color: white; }
  .qty-num { font-size: 16px; font-weight: 700; color: #3E2723; width: 30px; text-align: center; }
  .remove-btn {
    background: none;
    border: none;
    color: #cc0000;
    cursor: pointer;
    font-size: 13px;
    font-family: 'Lato', sans-serif;
    padding: 4px 8px;
    border-radius: 4px;
    transition: background 0.2s;
  }
  .remove-btn:hover { background: #fff0f0; }

  /* ORDER SUMMARY */
  .order-summary {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(62,39,35,0.08);
    border: 1px solid rgba(212,160,23,0.15);
    position: sticky;
    top: 90px;
  }
  .summary-title { font-family: 'Playfair Display', serif; font-size: 24px; color: #3E2723; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 2px solid #D4A017; }
  .summary-row { display: flex; justify-content: space-between; margin-bottom: 14px; font-size: 15px; color: #6B4C3B; }
  .summary-row.total { font-size: 20px; font-weight: 700; color: #3E2723; padding-top: 16px; border-top: 1px solid #e8d5c0; margin-top: 8px; }
  .summary-row span:last-child { font-weight: 700; color: #3E2723; }
  .summary-row.total span:last-child { color: #D4A017; font-size: 24px; }
  .free-shipping { background: rgba(76,175,80,0.1); border: 1px solid rgba(76,175,80,0.3); border-radius: 8px; padding: 10px 14px; font-size: 13px; color: #2e7d32; margin-bottom: 20px; text-align: center; }
  .btn-checkout {
    width: 100%;
    background: #3E2723;
    color: #D4A017;
    border: none;
    padding: 18px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    font-family: 'Lato', sans-serif;
    transition: all 0.2s;
    margin-bottom: 12px;
    text-decoration: none;
    display: block;
    text-align: center;
  }
  .btn-checkout:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); box-shadow: 0 8px 25px rgba(212,160,23,0.3); }
  .btn-continue-shopping {
    width: 100%;
    background: transparent;
    color: #3E2723;
    border: 2px solid #e8d5c0;
    padding: 14px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Lato', sans-serif;
    transition: all 0.2s;
    text-decoration: none;
    display: block;
    text-align: center;
  }
  .btn-continue-shopping:hover { border-color: #D4A017; color: #D4A017; }

  /* EMPTY CART */
  .empty-cart { text-align: center; padding: 80px 40px; }
  .empty-cart .icon { font-size: 80px; margin-bottom: 24px; display: block; }
  .empty-cart h2 { font-family: 'Playfair Display', serif; font-size: 32px; color: #3E2723; margin-bottom: 12px; }
  .empty-cart p { color: #8B5E3C; font-size: 16px; margin-bottom: 30px; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 20px; }

  .genre-colors-Fantasy { background: linear-gradient(135deg, #1a1a3e, #2d2d6b); }
  .genre-colors-Dystopian { background: linear-gradient(135deg, #2d0a0a, #6b1a1a); }
  .genre-colors-Romance { background: linear-gradient(135deg, #2d0a1a, #6b1a3a); }
  .genre-colors-Sci-Fi { background: linear-gradient(135deg, #0a2d2d, #1a6b6b); }
  .genre-colors-Children { background: linear-gradient(135deg, #1a2d0a, #3a6b1a); }
  .genre-colors-Classic { background: linear-gradient(135deg, #2d2d0a, #6b6b1a); }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="cart-wrapper">

    <h1 class="page-title">🛒 My Cart</h1>
    <p class="page-sub">Review your selected books before checkout</p>

    <!-- EMPTY CART -->
    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
      <div class="empty-cart">
        <span class="icon">🛒</span>
        <h2>Your cart is empty</h2>
        <p>Looks like you haven't added any books yet!</p>
        <a href="/BookList.aspx" class="btn-checkout" style="display:inline-block; width:auto; padding:16px 40px;">
          Browse Books →
        </a>
      </div>
    </asp:Panel>

    <!-- CART WITH ITEMS -->
    <asp:Panel ID="pnlCart" runat="server">
      <div class="cart-grid">

        <!-- CART ITEMS -->
        <div class="cart-items">
          <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
            <ItemTemplate>
              <div class="cart-item">
           <div class="cart-item-cover genre-colors-<%# Eval("Genre") %>" style="padding:0; overflow:hidden;">
  <%# !string.IsNullOrEmpty(Eval("CoverImage").ToString())
    ? "<img src='/Images/" + Eval("CoverImage") + "' style='width:100%;height:100%;object-fit:cover;border-radius:10px;' onerror=\"this.src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg'\"/>"
    : "<img src='https://covers.openlibrary.org/b/isbn/" + Eval("ISBN") + "-M.jpg' style='width:100%;height:100%;object-fit:cover;border-radius:10px;' onerror=\"this.style.display='none'\"/>" %>
</div>
                <div class="cart-item-info">
                  <div class="cart-item-series"><%# Eval("Series") %></div>
                  <div class="cart-item-title"><%# Eval("Title") %></div>
                  <div class="cart-item-author">by <%# Eval("Author") %></div>
                  <div style="margin-top:12px; display:flex; align-items:center; gap:16px;">
                    <div class="qty-controls">
                      <asp:LinkButton CssClass="qty-btn" runat="server"
                        CommandName="Decrease"
                        CommandArgument='<%# Eval("CartID") %>'>−</asp:LinkButton>
                      <span class="qty-num"><%# Eval("Quantity") %></span>
                      <asp:LinkButton CssClass="qty-btn" runat="server"
                        CommandName="Increase"
                        CommandArgument='<%# Eval("CartID") %>'>+</asp:LinkButton>
                    </div>
                    <asp:LinkButton CssClass="remove-btn" runat="server"
                      CommandName="Remove"
                      CommandArgument='<%# Eval("CartID") %>'
                      OnClientClick="return confirm('Remove this book from cart?')">🗑 Remove</asp:LinkButton>
                  </div>
                </div>
                <div style="text-align:right;">
                  <div class="cart-item-price">RM <%# Eval("Price", "{0:F2}") %></div>
                  <div class="cart-item-subtotal">Subtotal: RM <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %></div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>

        <!-- ORDER SUMMARY -->
        <div>
          <div class="order-summary">
            <div class="summary-title">Order Summary</div>
            <div class="summary-row">
              <span>Subtotal (<asp:Literal ID="litItemCount" runat="server"/> items)</span>
              <span>RM <asp:Literal ID="litSubtotal" runat="server"/></span>
            </div>
            <div class="summary-row">
              <span>Shipping</span>
              <span><asp:Literal ID="litShipping" runat="server"/></span>
            </div>
            <div class="summary-row total">
              <span>Total</span>
              <span>RM <asp:Literal ID="litTotal" runat="server"/></span>
            </div>
            <div class="free-shipping">
              <asp:Literal ID="litShippingMsg" runat="server"/>
            </div>
            <a href="/Checkout.aspx" class="btn-checkout">Proceed to Checkout →</a>
            <a href="/BookList.aspx" class="btn-continue-shopping">← Continue Shopping</a>
          </div>
        </div>

      </div>
    </asp:Panel>

  </div>
</asp:Content>