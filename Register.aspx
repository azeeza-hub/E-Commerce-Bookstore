<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PageTurnerBookstore.Register" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .register-wrapper {
    min-height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    background: linear-gradient(135deg, #FDF6EC 0%, #F5E6D0 100%);
  }
  .register-box {
    background: white;
    border-radius: 24px;
    padding: 50px;
    width: 100%;
    max-width: 560px;
    box-shadow: 0 20px 60px rgba(62,39,35,0.12);
    border: 1px solid rgba(212,160,23,0.2);
  }
  .register-header { text-align: center; margin-bottom: 36px; }
  .register-header .icon { font-size: 48px; margin-bottom: 16px; display: block; }
  .register-header h1 { font-family: 'Playfair Display', serif; font-size: 32px; color: #3E2723; margin-bottom: 8px; }
  .register-header p { color: #8B5E3C; font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; }
  .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
  .form-group { margin-bottom: 20px; }
  .form-group label { display: block; font-size: 13px; font-weight: 700; color: #3E2723; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
  .form-group input {
    width: 100%;
    padding: 14px 18px;
    border: 2px solid #e8d5c0;
    border-radius: 10px;
    font-size: 15px;
    font-family: 'Lato', sans-serif;
    color: #3C3C3C;
    background: #FFFDF9;
    transition: border-color 0.2s, box-shadow 0.2s;
    outline: none;
  }
  .form-group input:focus { border-color: #D4A017; box-shadow: 0 0 0 3px rgba(212,160,23,0.15); }
  .btn-register {
    width: 100%;
    background: #3E2723;
    color: #D4A017;
    border: none;
    padding: 16px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    font-family: 'Lato', sans-serif;
    transition: all 0.2s;
    letter-spacing: 0.5px;
    margin-top: 8px;
  }
  .btn-register:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); box-shadow: 0 8px 25px rgba(212,160,23,0.3); }
  .login-link { text-align: center; font-size: 14px; color: #6B4C3B; margin-top: 20px; }
  .login-link a { color: #D4A017; font-weight: 700; text-decoration: none; }
  .login-link a:hover { color: #3E2723; }
  .error-msg { background: #fff0f0; border: 1px solid #ffcccc; color: #cc0000; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; }
  .success-msg { background: #f0fff0; border: 1px solid #ccffcc; color: #006600; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; }
  .password-hint { font-size: 12px; color: #8B5E3C; margin-top: 6px; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="register-wrapper">
    <div class="register-box">

      <div class="register-header">
        <span class="icon">✨</span>
        <h1>Create Account</h1>
        <p>Join The Reading Nook family today</p>
      </div>

      <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false"/>
      <asp:Label ID="lblSuccess" runat="server" CssClass="success-msg" Visible="false"/>

      <div class="form-row">
        <div class="form-group">
          <label>First Name</label>
          <asp:TextBox ID="txtFirstName" runat="server" placeholder="John"/>
          <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
            ControlToValidate="txtFirstName"
            ErrorMessage="Required"
            Display="Dynamic"
            ForeColor="Red"
            Font-Size="12px"/>
        </div>
        <div class="form-group">
          <label>Last Name</label>
          <asp:TextBox ID="txtLastName" runat="server" placeholder="Doe"/>
          <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
            ControlToValidate="txtLastName"
            ErrorMessage="Required"
            Display="Dynamic"
            ForeColor="Red"
            Font-Size="12px"/>
        </div>
      </div>

      <div class="form-group">
        <label>Email Address</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="john@email.com"/>
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
          ControlToValidate="txtEmail"
          ErrorMessage="Email is required"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
      </div>

      <div class="form-group">
        <label>Phone Number</label>
        <asp:TextBox ID="txtPhone" runat="server" placeholder="01X-XXXXXXX"/>
      </div>

      <div class="form-group">
        <label>Address</label>
        <asp:TextBox ID="txtAddress" runat="server" placeholder="Your delivery address"/>
      </div>

      <div class="form-group">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Create a password"/>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
          ControlToValidate="txtPassword"
          ErrorMessage="Password is required"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
        <div class="password-hint">Minimum 6 characters</div>
      </div>

      <div class="form-group">
        <label>Confirm Password</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Repeat your password"/>
        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
          ControlToValidate="txtConfirmPassword"
          ErrorMessage="Please confirm password"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
        <asp:CompareValidator ID="cvPassword" runat="server"
          ControlToValidate="txtConfirmPassword"
          ControlToCompare="txtPassword"
          ErrorMessage="Passwords do not match"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
      </div>

      <asp:Button ID="btnRegister" runat="server" Text="Create My Account →"
        CssClass="btn-register" OnClick="btnRegister_Click"/>

      <div class="login-link">
        Already have an account? <a href="/Login.aspx">Sign in →</a>
      </div>

    </div>
  </div>
</asp:Content>