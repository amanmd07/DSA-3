<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reports & Export | Project Flow Scheduling</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600&family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="app-container">
    <aside class="sidebar">
      <div class="sidebar-header">
        <div class="sidebar-brand-icon"><i class="fa-solid fa-network-wired"></i></div>
        <div>
          <h4 style="font-size: 1.1rem; margin: 0;">PROJECT FLOW</h4>
          <span style="font-size: 0.75rem; color: var(--text-muted);">DSA 3D Engine</span>
        </div>
      </div>

      <nav class="sidebar-nav">
        <a href="dashboard.jsp" class="nav-item-link"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        <a href="projects.jsp" class="nav-item-link"><i class="fa-solid fa-folder-tree"></i> Projects</a>
        <a href="tasks.jsp" class="nav-item-link"><i class="fa-solid fa-list-check"></i> Tasks</a>
        <a href="dependencies.jsp" class="nav-item-link"><i class="fa-solid fa-diagram-project"></i> Dependencies</a>
        <a href="scheduler.jsp" class="nav-item-link"><i class="fa-solid fa-calculator"></i> CPM Scheduler</a>
        <a href="critical_path.jsp" class="nav-item-link"><i class="fa-solid fa-cube"></i> 3D Critical Path</a>
        <a href="calendar.jsp" class="nav-item-link"><i class="fa-solid fa-calendar-days"></i> Milestone Calendar</a>
        <a href="reports.jsp" class="nav-item-link active"><i class="fa-solid fa-file-export"></i> Reports & Export</a>
        <a href="admin_users.jsp" class="nav-item-link"><i class="fa-solid fa-users-gear"></i> User Roles (RBAC)</a>
        <a href="settings.jsp" class="nav-item-link"><i class="fa-solid fa-sliders"></i> Settings</a>
      </nav>

      <div class="sidebar-footer">
        <button id="theme-toggle" class="btn-glass" style="padding: 0.4rem 0.8rem;"><i class="fa-solid fa-sun"></i></button>
        <a href="login.jsp" class="btn-glass btn-gradient-crimson" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"><i class="fa-solid fa-arrow-right-from-bracket"></i></a>
      </div>
    </aside>

    <main class="main-wrapper">
      <header class="top-navbar">
        <div>
          <h2 style="font-size: 1.35rem; margin: 0;">Executive Reports & Data Export</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Generate auditable project documentation, CPM matrices and CSV spreadsheets</p>
        </div>
      </header>

      <div class="page-content">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 1.5rem;">
          <!-- PDF Report Card -->
          <div class="glass-card glass-card-interactive">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(239, 68, 68, 0.15); color: #ef4444; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1.25rem;">
              <i class="fa-solid fa-file-pdf"></i>
            </div>
            <h3 style="font-size: 1.15rem; margin-bottom: 0.35rem;">Formal CPM Schedule PDF</h3>
            <p style="color: var(--text-secondary); font-size: 0.88rem; margin-bottom: 1.5rem; line-height: 1.6;">
              Executive project summary detailing critical bottleneck activities, zero-float milestones, and risk boundaries for client presentation.
            </p>
            <a href="report?type=PDF&projectId=101" class="btn-glass btn-gradient-crimson" style="width: 100%; justify-content: center;">
              <i class="fa-solid fa-download"></i> Download PDF Report
            </a>
          </div>

          <!-- Excel CSV Card -->
          <div class="glass-card glass-card-interactive">
            <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(16, 185, 129, 0.15); color: #10b981; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1.25rem;">
              <i class="fa-solid fa-file-excel"></i>
            </div>
            <h3 style="font-size: 1.15rem; margin-bottom: 0.35rem;">Task Precedence Matrix (CSV)</h3>
            <p style="color: var(--text-secondary); font-size: 0.88rem; margin-bottom: 1.5rem; line-height: 1.6;">
              Full tabular spreadsheet containing EST, EFT, LST, LFT, Total Slack, and Critical Boolean flags for import into Microsoft Excel.
            </p>
            <a href="report?type=EXCEL&projectId=101" class="btn-glass btn-gradient-cyan" style="width: 100%; justify-content: center;">
              <i class="fa-solid fa-file-csv"></i> Export CSV Spreadsheet
            </a>
          </div>
        </div>
      </div>
    </main>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
