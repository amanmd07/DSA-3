<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Projects | Project Flow Scheduling</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600&family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="app-container">
    <!-- Sidebar -->
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
        <a href="projects.jsp" class="nav-item-link active"><i class="fa-solid fa-folder-tree"></i> Projects</a>
        <a href="tasks.jsp" class="nav-item-link"><i class="fa-solid fa-list-check"></i> Tasks</a>
        <a href="dependencies.jsp" class="nav-item-link"><i class="fa-solid fa-diagram-project"></i> Dependencies</a>
        <a href="scheduler.jsp" class="nav-item-link"><i class="fa-solid fa-calculator"></i> CPM Scheduler</a>
        <a href="critical_path.jsp" class="nav-item-link"><i class="fa-solid fa-cube"></i> 3D Critical Path</a>
        <a href="calendar.jsp" class="nav-item-link"><i class="fa-solid fa-calendar-days"></i> Milestone Calendar</a>
        <a href="reports.jsp" class="nav-item-link"><i class="fa-solid fa-file-export"></i> Reports & Export</a>
        <a href="admin_users.jsp" class="nav-item-link"><i class="fa-solid fa-users-gear"></i> User Roles (RBAC)</a>
        <a href="settings.jsp" class="nav-item-link"><i class="fa-solid fa-sliders"></i> Settings</a>
      </nav>

      <div class="sidebar-footer">
        <button id="theme-toggle" class="btn-glass" style="padding: 0.4rem 0.8rem;"><i class="fa-solid fa-sun"></i></button>
        <a href="login.jsp" class="btn-glass btn-gradient-crimson" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"><i class="fa-solid fa-arrow-right-from-bracket"></i></a>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="main-wrapper">
      <header class="top-navbar">
        <div>
          <h2 style="font-size: 1.35rem; margin: 0;">Project Repositories</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Manage scheduling workspaces, DAG scopes and delivery baselines</p>
        </div>
        <button class="btn-glass btn-gradient-cyan" onclick="document.getElementById('new-project-modal').style.display='flex'">
          <i class="fa-solid fa-plus"></i> New Project
        </button>
      </header>

      <div class="page-content">
        <!-- Project Cards Grid -->
        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 1.5rem;">
          <div class="glass-card glass-card-interactive" style="border-top: 4px solid var(--accent-cyan);">
            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.75rem;">
              <span class="mono badge-glass badge-cyan">PROJECT-101</span>
              <span class="badge-glass badge-emerald">ACTIVE SCHEDULE</span>
            </div>
            <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Enterprise Web Platform</h3>
            <p style="color: var(--text-secondary); font-size: 0.88rem; margin-bottom: 1.25rem;">
              End-to-end full stack delivery covering requirements, database models, backend servlets, glassmorphism UI, and 3D visualizer.
            </p>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; padding: 0.85rem; background: var(--bg-tertiary); border-radius: 8px; margin-bottom: 1.25rem; font-size: 0.82rem;">
              <div><span style="color: var(--text-muted);">Duration:</span> <strong>19 Days</strong></div>
              <div><span style="color: var(--text-muted);">Tasks:</span> <strong>6 Activities</strong></div>
              <div><span style="color: var(--text-muted);">Edges:</span> <strong>6 Precedences</strong></div>
              <div><span style="color: var(--text-muted);">Critical:</span> <strong style="color: #f87171;">4 Tasks (0 Float)</strong></div>
            </div>

            <div style="display: flex; justify-content: space-between; align-items: center;">
              <a href="tasks.jsp" class="btn-glass" style="font-size: 0.85rem;"><i class="fa-solid fa-list-check"></i> View Tasks</a>
              <a href="scheduler.jsp" class="btn-glass btn-gradient-cyan" style="font-size: 0.85rem;"><i class="fa-solid fa-timeline"></i> CPM Schedule</a>
            </div>
          </div>
        </div>

        <!-- Create Project Modal Form -->
        <div id="new-project-modal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); backdrop-filter: blur(8px); align-items: center; justify-content: center; z-index: 2000; padding: 1.5rem;">
          <div class="glass-card" style="width: 100%; max-width: 500px; background: var(--bg-secondary);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
              <h3 style="font-size: 1.2rem; margin: 0;"><i class="fa-solid fa-folder-plus" style="color: var(--accent-cyan);"></i> Create New Project</h3>
              <button class="btn-glass" style="padding: 0.3rem 0.6rem;" onclick="document.getElementById('new-project-modal').style.display='none'">&times;</button>
            </div>

            <form action="project" method="post">
              <input type="hidden" name="action" value="CREATE">
              <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Project Title</label>
                <input type="text" name="title" class="form-control-glass" placeholder="e.g. Cloud Migration Plan" required>
              </div>

              <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Description</label>
                <textarea name="description" class="form-control-glass" rows="3" placeholder="Summary of scope and milestones"></textarea>
              </div>

              <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1.5rem;">
                <div>
                  <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Start Date</label>
                  <input type="date" name="startDate" class="form-control-glass" value="2026-10-01" required>
                </div>
                <div>
                  <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Target End Date</label>
                  <input type="date" name="targetEndDate" class="form-control-glass" value="2026-10-31" required>
                </div>
              </div>

              <div style="display: flex; justify-content: flex-end; gap: 0.75rem;">
                <button type="button" class="btn-glass" onclick="document.getElementById('new-project-modal').style.display='none'">Cancel</button>
                <button type="submit" class="btn-glass btn-gradient-cyan">Create Project</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </main>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
