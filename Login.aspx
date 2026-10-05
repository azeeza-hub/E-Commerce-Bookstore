<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PageTurnerBookstore.Login" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<style>
  .login-wrapper {
    min-height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    background: linear-gradient(135deg, #FDF6EC 0%, #F5E6D0 100%);
  }
  .login-box {
    background: white;
    border-radius: 24px;
    padding: 50px;
    width: 100%;
    max-width: 480px;
    box-shadow: 0 20px 60px rgba(62,39,35,0.12);
    border: 1px solid rgba(212,160,23,0.2);
  }
  .login-header { text-align: center; margin-bottom: 36px; }
  .login-header .icon {
    font-size: 48px;
    margin-bottom: 16px;
    display: block;
  }
  .login-header h1 {
    font-family: 'Playfair Display', serif;
    font-size: 32px;
    color: #3E2723;
    margin-bottom: 8px;
  }
  .login-header p {
    color: #8B5E3C;
    font-size: 15px;
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 18px;
  }
  .form-group { margin-bottom: 20px; }
  .form-group label {
    display: block;
    font-size: 13px;
    font-weight: 700;
    color: #3E2723;
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
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
  .form-group input:focus {
    border-color: #D4A017;
    box-shadow: 0 0 0 3px rgba(212,160,23,0.15);
  }
  .forgot-link {
    text-align: right;
    margin-top: -12px;
    margin-bottom: 20px;
  }
  .forgot-link a {
    font-size: 13px;
    color: #8B5E3C;
    text-decoration: none;
  }
  .forgot-link a:hover { color: #D4A017; }
  .btn-login {
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
  }
  .btn-login:hover { background: #D4A017; color: #3E2723; transform: translateY(-2px); box-shadow: 0 8px 25px rgba(212,160,23,0.3); }
  .divider {
    text-align: center;
    margin: 24px 0;
    position: relative;
    color: #8B5E3C;
    font-size: 13px;
  }
  .divider::before, .divider::after {
    content: '';
    position: absolute;
    top: 50%;
    width: 42%;
    height: 1px;
    background: #e8d5c0;
  }
  .divider::before { left: 0; }
  .divider::after { right: 0; }
  .register-link {
    text-align: center;
    font-size: 14px;
    color: #6B4C3B;
  }
  .register-link a {
    color: #D4A017;
    font-weight: 700;
    text-decoration: none;
  }
  .register-link a:hover { color: #3E2723; }
  .error-msg {
    background: #fff0f0;
    border: 1px solid #ffcccc;
    color: #cc0000;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    margin-bottom: 20px;
    display: none;
  }
  .success-msg {
    background: #f0fff0;
    border: 1px solid #ccffcc;
    color: #006600;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    margin-bottom: 20px;
  }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="login-wrapper">
    <div class="login-box">

      <div class="login-header">
        <span class="icon">📚</span>
        <h1>Welcome Back</h1>
        <p>Sign in to your Reading Nook account</p>
      </div>

      <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false"/>
      <asp:Label ID="lblSuccess" runat="server" CssClass="success-msg" Visible="false"/>

      <div class="form-group">
        <label>Email Address</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
          placeholder="Enter your email address"/>
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
          ControlToValidate="txtEmail"
          ErrorMessage="Email is required"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
      </div>

      <div class="form-group">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
          placeholder="Enter your password"/>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
          ControlToValidate="txtPassword"
          ErrorMessage="Password is required"
          Display="Dynamic"
          ForeColor="Red"
          Font-Size="12px"/>
      </div>

      <div class="forgot-link">
        <a href="#">Forgot password?</a>
      </div>

      <asp:Button ID="btnLogin" runat="server" Text="Sign In →"
        CssClass="btn-login" OnClick="btnLogin_Click"/>

      <div class="divider">or</div>

      <div class="register-link">
        Don't have an account? <a href="/Register.aspx">Create one free →</a>
      </div>

    </div>
  </div>
</asp:Content>