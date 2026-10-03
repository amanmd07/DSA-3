<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Settings | Project Flow</title>
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
        <a href="reports.jsp" class="nav-item-link"><i class="fa-solid fa-file-export"></i> Reports & Export</a>
        <a href="admin_users.jsp" class="nav-item-link"><i class="fa-solid fa-users-gear"></i> User Roles (RBAC)</a>
        <a href="settings.jsp" class="nav-item-link active"><i class="fa-solid fa-sliders"></i> Settings</a>
      </nav>

      <div class="sidebar-footer">
        <button id="theme-toggle" class="btn-glass" style="padding: 0.4rem 0.8rem;"><i class="fa-solid fa-sun"></i></button>
        <a href="login.jsp" class="btn-glass btn-gradient-crimson" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"><i class="fa-solid fa-arrow-right-from-bracket"></i></a>
      </div>
    </aside>

    <main class="main-wrapper">
      <header class="top-navbar">
        <div>
          <h2 style="font-size: 1.35rem; margin: 0;">System Configuration & DSA Engine Settings</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Algorithm tolerances, database pool parameters and 3D visual fidelity</p>
        </div>
      </header>

      <div class="page-content">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(360px, 1fr)); gap: 1.5rem;">
          <div class="glass-card">
            <h3 style="font-size: 1.15rem; margin-bottom: 1rem;"><i class="fa-solid fa-microchip" style="color: var(--accent-cyan);"></i> Graph Algorithm Engine</h3>
            
            <div style="margin-bottom: 1rem;">
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Cycle Detection Strategy</label>
              <input type="text" class="form-control-glass" value="Depth-First Search (DFS) & Kahn's In-Degree Sorter" disabled>
            </div>

            <div style="margin-bottom: 1rem;">
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Time Complexity</label>
              <input type="text" class="form-control-glass mono" value="O(V + E) Linear Graph Traversal" disabled>
            </div>

            <div>
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">CPM Pass Mode</label>
              <input type="text" class="form-control-glass" value="Two-Pass Forward/Backward Pass (Float Zero Isolate)" disabled>
            </div>
          </div>

          <div class="glass-card">
            <h3 style="font-size: 1.15rem; margin-bottom: 1rem;"><i class="fa-solid fa-database" style="color: var(--accent-indigo);"></i> Database & Server Status</h3>
            
            <div style="margin-bottom: 1rem;">
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Database Engine</label>
              <input type="text" class="form-control-glass" value="MySQL Relational Server (project_scheduler_db)" disabled>
            </div>

            <div style="margin-bottom: 1rem;">
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Connection Pool</label>
              <input type="text" class="form-control-glass" value="DBConnectionPool (Max Active: 20)" disabled>
            </div>

            <div>
              <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Java Runtime</label>
              <input type="text" class="form-control-glass mono" value="Java SE Runtime 26.0 (HotSpot 64-Bit)" disabled>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
