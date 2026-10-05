<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="PageTurnerBookstore.AdminDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<style>
  .admin-wrapper { max-width: 1300px; margin: 0 auto; padding: 40px 60px; }
  .admin-header {
    background: linear-gradient(135deg, #3E2723, #6D4C41);
    border-radius: 20px;
    padding: 36px 40px;
    margin-bottom: 36px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border: 1px solid rgba(212,160,23,0.3);
  }
  .admin-header h1 { font-family: 'Playfair Display', serif; font-size: 36px; color: #D4A017; margin-bottom: 6px; }
  .admin-header p { color: rgba(253,246,236,0.7); font-size: 15px; }
  .admin-badge { background: rgba(212,160,23,0.2); border: 1px solid rgba(212,160,23,0.4); color: #D4A017; padding: 8px 20px; border-radius: 20px; font-size: 13px; font-weight: 700; }
  .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 36px; }
  .stat-card { background: white; border-radius: 16px; padding: 24px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); text-align: center; transition: transform 0.2s; }
  .stat-card:hover { transform: translateY(-4px); }
  .stat-icon { font-size: 36px; margin-bottom: 12px; display: block; }
  .stat-number { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 700; color: #3E2723; display: block; line-height: 1; margin-bottom: 6px; }
  .stat-label { font-size: 13px; color: #8B5E3C; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; }
  .charts-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 36px; }
  .chart-card { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); }
  .chart-card-full { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); margin-bottom: 36px; }
  .chart-title { font-family: 'Playfair Display', serif; font-size: 20px; color: #3E2723; margin-bottom: 6px; }
  .chart-sub { font-size: 13px; color: #8B5E3C; font-style: italic; margin-bottom: 20px; }
  .xml-badge { display: inline-block; background: rgba(212,160,23,0.1); border: 1px solid rgba(212,160,23,0.3); color: #8B5E3C; padding: 2px 10px; border-radius: 20px; font-size: 10px; font-weight: 700; letter-spacing: 1px; margin-left: 8px; vertical-align: middle; }
  .tab-bar { display: flex; gap: 4px; margin-bottom: 24px; background: white; padding: 6px; border-radius: 12px; box-shadow: 0 2px 10px rgba(62,39,35,0.06); border: 1px solid rgba(212,160,23,0.12); width: fit-content; }
  .tab-btn { padding: 10px 24px; border-radius: 8px; border: none; background: transparent; color: #8B5E3C; font-size: 14px; font-weight: 700; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; }
  .tab-btn.active, .tab-btn:hover { background: #3E2723; color: #D4A017; }
  .table-card { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); }
  .table-title { font-family: 'Playfair Display', serif; font-size: 22px; color: #3E2723; margin-bottom: 20px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; display: flex; justify-content: space-between; align-items: center; }
  table { width: 100%; border-collapse: collapse; }
  th { background: #3E2723; color: #D4A017; padding: 12px 16px; text-align: left; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
  th:first-child { border-radius: 8px 0 0 8px; }
  th:last-child { border-radius: 0 8px 8px 0; }
  td { padding: 14px 16px; border-bottom: 1px solid #f0e8de; font-size: 14px; color: #3C3C3C; vertical-align: middle; }
  tr:last-child td { border-bottom: none; }
  tr:hover td { background: #FFFDF9; }
  .badge { padding: 3px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; text-transform: uppercase; }
  .badge-pending { background: rgba(255,193,7,0.15); color: #F57F17; }
  .badge-confirmed { background: rgba(76,175,80,0.15); color: #2e7d32; }
  .badge-shipped { background: rgba(33,150,243,0.15); color: #1565C0; }
  .badge-delivered { background: rgba(76,175,80,0.2); color: #1b5e20; }
  .badge-admin { background: rgba(212,160,23,0.15); color: #8B5E3C; }
  .badge-customer { background: rgba(62,39,35,0.08); color: #6B4C3B; }
  .status-select { padding: 6px 10px; border: 1px solid #e8d5c0; border-radius: 6px; font-size: 12px; font-family: 'Lato', sans-serif; color: #3C3C3C; background: white; cursor: pointer; }
  .btn-update { background: #3E2723; color: #D4A017; border: none; padding: 6px 14px; border-radius: 6px; font-size: 12px; font-weight: 700; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; }
  .btn-update:hover { background: #D4A017; color: #3E2723; }
  .section-panel { display: none; }
  .section-panel.active { display: block; }
  .xml-section { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 20px rgba(62,39,35,0.07); border: 1px solid rgba(212,160,23,0.12); margin-bottom: 36px; }
  .xml-section h2 { font-family: 'Playfair Display', serif; font-size: 22px; color: #3E2723; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 2px solid #D4A017; }
  .xml-btn-row { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 16px; }
  .btn-xml { background: #3E2723; color: #D4A017; border: none; padding: 12px 24px; border-radius: 10px; font-size: 14px; font-weight: 700; cursor: pointer; font-family: 'Lato', sans-serif; transition: all 0.2s; }
  .btn-xml:hover { background: #D4A017; color: #3E2723; }
  .xml-report { background: #FFFDF9; border: 1px solid #e8d5c0; border-radius: 10px; padding: 20px; margin-top: 16px; overflow-x: auto; }
  .msg-success { color: #2e7d32; font-weight: 700; font-size: 14px; margin-top: 8px; }
</style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="admin-wrapper">

    <div class="admin-header">
      <div>
        <h1>👑 Admin Dashboard</h1>
        <p>Welcome back, <asp:Literal ID="litAdminName" runat="server"/>! Here's what's happening today.</p>
      </div>
      <span class="admin-badge">🔐 Admin Access</span>
    </div>

    <div class="stats-grid">
      <div class="stat-card">
        <span class="stat-icon">📚</span>
        <span class="stat-number"><asp:Literal ID="litTotalBooks" runat="server"/></span>
        <span class="stat-label">Total Books</span>
      </div>
      <div class="stat-card">
        <span class="stat-icon">👥</span>
        <span class="stat-number"><asp:Literal ID="litTotalUsers" runat="server"/></span>
        <span class="stat-label">Registered Users</span>
      </div>
      <div class="stat-card">
        <span class="stat-icon">📦</span>
        <span class="stat-number"><asp:Literal ID="litTotalOrders" runat="server"/></span>
        <span class="stat-label">Total Orders</span>
      </div>
      <div class="stat-card">
        <span class="stat-icon">💰</span>
        <span class="stat-number">RM <asp:Literal ID="litRevenue" runat="server"/></span>
        <span class="stat-label">Total Revenue</span>
      </div>
    </div>

    <!-- SALES CHARTS FROM XML DATA -->
    <div class="chart-card-full">
      <div class="chart-title">📈 Sales Analytics <span class="xml-badge">📡 XML Data</span></div>
      <div class="chart-sub">Generated from XML sales data — orders and revenue visualization</div>
      <canvas id="salesChart" height="100"></canvas>
    </div>

    <div class="charts-grid">
      <div class="chart-card">
        <div class="chart-title">📚 Books by Genre <span class="xml-badge">📡 XML Data</span></div>
        <div class="chart-sub">Distribution of books across genres</div>
        <canvas id="genreChart"></canvas>
      </div>
      <div class="chart-card">
        <div class="chart-title">📦 Orders by Status <span class="xml-badge">📡 XML Data</span></div>
        <div class="chart-sub">Current order status breakdown</div>
        <canvas id="statusChart"></canvas>
      </div>
    </div>

    <!-- XML TOOLS SECTION -->
    <div class="xml-section">
      <h2>🗂️ XML Tools</h2>
      <div class="xml-btn-row">
        <asp:Button ID="btnExportXML" runat="server" Text="📥 Export Book Catalog as XML"
          CssClass="btn-xml" OnClick="btnExportXML_Click"/>
        <asp:Button ID="btnGenerateReport" runat="server" Text="📊 Generate XSLT Report"
          CssClass="btn-xml" OnClick="btnGenerateReport_Click"/>
        <asp:Button ID="btnValidateDTD" runat="server" Text="✅ Validate XML (DTD)"
          CssClass="btn-xml" OnClick="btnValidateDTD_Click"/>
      </div>
      <asp:Label ID="lblExportMsg" runat="server" CssClass="msg-success"/>
      <asp:Panel ID="pnlReport" runat="server" Visible="false">
        <div class="xml-report">
          <asp:Literal ID="litXmlReport" runat="server"/>
        </div>
      </asp:Panel>
    </div>

    <div class="tab-bar">
      <button type="button" class="tab-btn active" onclick="showTab('orders', this)">📦 Orders</button>
      <button type="button" class="tab-btn" onclick="showTab('users', this)">👥 Users</button>
      <button type="button" class="tab-btn" onclick="showTab('books', this)">📚 Books</button>
    </div>

    <!-- ORDERS TAB -->
    <div id="tab-orders" class="section-panel active">
      <div class="table-card">
        <div class="table-title">
          All Orders
          <span style="font-size:14px; color:#8B5E3C; font-family:'Lato',sans-serif; font-weight:400;">
            <asp:Literal ID="litOrderCount" runat="server"/> orders total
          </span>
        </div>
        <table>
          <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Date</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Update</th>
          </tr>
          <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
            <ItemTemplate>
              <tr>
                <td><strong>#<%# Eval("OrderID") %></strong></td>
                <td><%# Eval("FullName") %></td>
                <td><%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd MMM yyyy") %></td>
                <td><strong>RM <%# string.Format("{0:F2}", Eval("TotalAmount")) %></strong></td>
                <td><span class="badge badge-<%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span></td>
                <td>
                  <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-select">
                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                    <asp:ListItem Value="Confirmed">Confirmed</asp:ListItem>
                    <asp:ListItem Value="Shipped">Shipped</asp:ListItem>
                    <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                  </asp:DropDownList>
                  <asp:LinkButton runat="server" CssClass="btn-update"
                    CommandName="UpdateStatus"
                    CommandArgument='<%# Eval("OrderID") %>'>Update</asp:LinkButton>
                </td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </table>
      </div>
    </div>

    <!-- USERS TAB -->
    <div id="tab-users" class="section-panel">
      <div class="table-card">
        <div class="table-title">All Users</div>
        <table>
          <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Joined</th>
          </tr>
          <asp:Repeater ID="rptUsers" runat="server">
            <ItemTemplate>
              <tr>
                <td>#<%# Eval("UserID") %></td>
                <td><strong><%# Eval("FullName") %></strong></td>
                <td><%# Eval("Email") %></td>
                <td><%# Eval("Phone") %></td>
                <td><span class="badge badge-<%# Eval("Role").ToString().ToLower() %>"><%# Eval("Role") %></span></td>
                <td><%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %></td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </table>
      </div>
    </div>

    <!-- BOOKS TAB -->
    <div id="tab-books" class="section-panel">
      <div class="table-card">
        <div class="table-title">All Books</div>
        <table>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Series</th>
            <th>Genre</th>
            <th>Price</th>
            <th>Stock</th>
          </tr>
          <asp:Repeater ID="rptBooks" runat="server">
            <ItemTemplate>
              <tr>
                <td><%# Eval("BookID") %></td>
                <td><strong><%# Eval("Title") %></strong></td>
                <td><%# Eval("Author") %></td>
                <td><%# Eval("Series") %></td>
                <td><span class="badge badge-customer"><%# Eval("Genre") %></span></td>
                <td><strong>RM <%# Eval("Price") %></strong></td>
                <td><%# Eval("Stock") %></td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </table>
      </div>
    </div>

  </div>

  <!-- HIDDEN XML DATA FOR CHARTS -->
  <asp:Literal ID="litChartData" runat="server"/>

  <script>
      function showTab(tab, btn) {
          document.querySelectorAll('.section-panel').forEach(p => p.classList.remove('active'));
          document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
          document.getElementById('tab-' + tab).classList.add('active');
          btn.classList.add('active');
      }

      window.onload = function () {
          // Sales Chart
          var salesCtx = document.getElementById('salesChart').getContext('2d');
          new Chart(salesCtx, {
              type: 'bar',
              data: {
                  labels: salesLabels,
                  datasets: [
                      {
                          label: 'Orders',
                          data: salesOrders,
                          backgroundColor: 'rgba(62,39,35,0.8)',
                          borderRadius: 8,
                          yAxisID: 'y'
                      },
                      {
                          label: 'Revenue (RM)',
                          data: salesRevenue,
                          backgroundColor: 'rgba(212,160,23,0.8)',
                          borderRadius: 8,
                          yAxisID: 'y1'
                      }
                  ]
              },
              options: {
                  responsive: true,
                  plugins: { legend: { position: 'top' } },
                  scales: {
                      y: { position: 'left', title: { display: true, text: 'Orders' } },
                      y1: { position: 'right', title: { display: true, text: 'Revenue (RM)' }, grid: { drawOnChartArea: false } }
                  }
              }
          });

          // Genre Chart
          var genreCtx = document.getElementById('genreChart').getContext('2d');
          new Chart(genreCtx, {
              type: 'doughnut',
              data: {
                  labels: genreLabels,
                  datasets: [{
                      data: genreData,
                      backgroundColor: ['#1a1a3e', '#2d0a0a', '#2d0a1a', '#0a2d2d', '#1a2d0a', '#2d2d0a'],
                      borderWidth: 3,
                      borderColor: '#fff'
                  }]
              },
              options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
          });

          // Status Chart
          var statusCtx = document.getElementById('statusChart').getContext('2d');
          new Chart(statusCtx, {
              type: 'pie',
              data: {
                  labels: statusLabels,
                  datasets: [{
                      data: statusData,
                      backgroundColor: ['#F57F17', '#2e7d32', '#1565C0', '#1b5e20'],
                      borderWidth: 3,
                      borderColor: '#fff'
                  }]
              },
              options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
          });
      };
  </script>
</asp:Content>