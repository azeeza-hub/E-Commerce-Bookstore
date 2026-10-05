<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="PageTurnerBookstore.Checkout" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .checkout-wrapper { max-width: 1200px; margin: 0 auto; padding: 60px; }
  .page-title { font-family: 'Playfair Display', serif; font-size: 42px; color: #3E2723; margin-bottom: 8px; }
  .page-sub { font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: #8B5E3C; margin-bottom: 40px; }
  .checkout-grid { display: grid; grid-template-columns: 1fr 380px; gap: 40px; align-items: start; }

  /* FORM */
  .checkout-form { background: white; border-radius: 20px; padding: 36px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); }
  .form-section-title { font-family: 'Playfair Display', serif; font-size: 22px; color: #3E2723; margin-bottom: 24px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; }
  .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
  .form-group { margin-bottom: 20px; }
  .form-group label { display: block; font-size: 13px; font-weight: 700; color: #3E2723; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
  .form-group input, .form-group textarea, .form-group select {
    width: 100%;
    padding: 14px 18px;
    border: 2px solid #e8d5c0;
    border-radius: 10px;
    font-size: 15px;
    font-family: 'Lato', sans-serif;
    color: #3C3C3C;
    background: #FFFDF9;
    transition: border-color 0.2s;
    outline: none;
  }
  .form-group input:focus, .form-group textarea:focus, .form-group select:focus { border-color: #D4A017; box-shadow: 0 0 0 3px rgba(212,160,23,0.15); }
  .form-group textarea { height: 100px; resize: vertical; }

  /* ORDER SUMMARY */
  .order-summary { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 4px 20px rgba(62,39,35,0.08); border: 1px solid rgba(212,160,23,0.15); position: sticky; top: 90px; }
  .summary-title { font-family: 'Playfair Display', serif; font-size: 24px; color: #3E2723; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 2px solid #D4A017; }
  .order-items { max-height: 300px; overflow-y: auto; margin-bottom: 20px; }
  .order-item { display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid #f0e8de; }
  .order-item-title { font-size: 13px; font-weight: 700; color: #3E2723; margin-bottom: 2px; }
  .order-item-qty { font-size: 12px; color: #8B5E3C; }
  .order-item-price { font-size: 14px; font-weight: 700; color: #3E2723; white-space: nowrap; }
  .summary-row { display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 15px; color: #6B4C3B; }
  .summary-row.total { font-size: 20px; font-weight: 700; color: #3E2723; padding-top: 16px; border-top: 1px solid #e8d5c0; margin-top: 8px; }
  .summary-row span:last-child { font-weight: 700; color: #3E2723; }
  .summary-row.total span:last-child { color: #D4A017; font-size: 24px; }
  .btn-place-order {
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
    margin-top: 20px;
  }
  .btn-place-order:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); box-shadow: 0 8px 25px rgba(212,160,23,0.3); }
  .secure-badge { text-align: center; font-size: 12px; color: #8B5E3C; margin-top: 12px; }
  .error-msg { background: #fff0f0; border: 1px solid #ffcccc; color: #cc0000; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="checkout-wrapper">
    <h1 class="page-title">💳 Checkout</h1>
    <p class="page-sub">Complete your order — your books are almost on their way!</p>

    <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false"/>

    <div class="checkout-grid">

      <!-- DELIVERY FORM -->
      <div class="checkout-form">
        <div class="form-section-title">📦 Delivery Information</div>

        <div class="form-row">
          <div class="form-group">
            <label>Full Name</label>
            <asp:TextBox ID="txtName" runat="server" placeholder="Your full name"/>
            <asp:RequiredFieldValidator ID="rfvName" runat="server"
              ControlToValidate="txtName" ErrorMessage="Name is required"
              Display="Dynamic" ForeColor="Red" Font-Size="12px"/>
          </div>
          <div class="form-group">
            <label>Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" placeholder="01X-XXXXXXX"/>
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
              ControlToValidate="txtPhone" ErrorMessage="Phone is required"
              Display="Dynamic" ForeColor="Red" Font-Size="12px"/>
          </div>
        </div>

        <div class="form-group">
          <label>Email Address</label>
          <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="your@email.com"/>
          <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
            ControlToValidate="txtEmail" ErrorMessage="Email is required"
            Display="Dynamic" ForeColor="Red" Font-Size="12px"/>
        </div>

        <div class="form-group">
          <label>Delivery Address</label>
          <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"
            placeholder="Full delivery address including postcode"/>
          <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
            ControlToValidate="txtAddress" ErrorMessage="Address is required"
            Display="Dynamic" ForeColor="Red" Font-Size="12px"/>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label>City</label>
            <asp:TextBox ID="txtCity" runat="server" placeholder="Kuala Lumpur"/>
          </div>
          <div class="form-group">
            <label>State</label>
            <asp:DropDownList ID="ddlState" runat="server">
              <asp:ListItem Value="">-- Select State --</asp:ListItem>
              <asp:ListItem>Johor</asp:ListItem>
              <asp:ListItem>Kedah</asp:ListItem>
              <asp:ListItem>Kelantan</asp:ListItem>
              <asp:ListItem>Kuala Lumpur</asp:ListItem>
              <asp:ListItem>Labuan</asp:ListItem>
              <asp:ListItem>Melaka</asp:ListItem>
              <asp:ListItem>Negeri Sembilan</asp:ListItem>
              <asp:ListItem>Pahang</asp:ListItem>
              <asp:ListItem>Penang</asp:ListItem>
              <asp:ListItem>Perak</asp:ListItem>
              <asp:ListItem>Perlis</asp:ListItem>
              <asp:ListItem>Putrajaya</asp:ListItem>
              <asp:ListItem>Sabah</asp:ListItem>
              <asp:ListItem>Sarawak</asp:ListItem>
              <asp:ListItem>Selangor</asp:ListItem>
              <asp:ListItem>Terengganu</asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>

        <div class="form-group">
          <label>Postcode</label>
          <asp:TextBox ID="txtPostcode" runat="server" placeholder="50000"/>
        </div>

        <div class="form-section-title" style="margin-top:20px;">💬 Additional Notes</div>
        <div class="form-group">
          <label>Order Notes (Optional)</label>
          <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine"
            placeholder="Any special instructions for your order..."/>
        </div>
      </div>

      <!-- ORDER SUMMARY -->
      <div>
        <div class="order-summary">
          <div class="summary-title">Your Order</div>

          <div class="order-items">
            <asp:Repeater ID="rptOrderItems" runat="server">
              <ItemTemplate>
                <div class="order-item">
                  <div>
                    <div class="order-item-title"><%# Eval("Title") %></div>
                    <div class="order-item-qty">x<%# Eval("Quantity") %> — by <%# Eval("Author") %></div>
                  </div>
                  <div class="order-item-price">RM <%# string.Format("{0:F2}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %></div>
                </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>

          <div class="summary-row">
            <span>Subtotal</span>
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

          <asp:Button ID="btnPlaceOrder" runat="server" Text="🎉 Place Order"
            CssClass="btn-place-order" OnClick="btnPlaceOrder_Click"/>

          <div class="secure-badge">🔒 Secure checkout • Malaysia wide delivery</div>
        </div>
      </div>

    </div>
  </div>
</asp:Content>