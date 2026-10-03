<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Milestone Calendar | Project Flow Scheduling</title>
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
        <a href="calendar.jsp" class="nav-item-link active"><i class="fa-solid fa-calendar-days"></i> Milestone Calendar</a>
        <a href="reports.jsp" class="nav-item-link"><i class="fa-solid fa-file-export"></i> Reports & Export</a>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Milestone & Gantt Timeline</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Linear Gantt mapping across project days 0 to 19</p>
        </div>
      </header>

      <div class="page-content">
        <div class="glass-card">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <h3 style="font-size: 1.15rem; margin: 0;">Schedule Gantt Visualization (Total 19 Days)</h3>
            <span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> Red = Zero Float Critical Activity</span>
          </div>

          <!-- Gantt Header Days (0 - 19) -->
          <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center; margin-bottom: 1rem; font-size: 0.8rem; color: var(--text-muted);">
            <div>TASK / ACTIVITY</div>
            <div style="display: flex; justify-content: space-between; padding: 0 0.5rem;">
              <span>Day 0</span>
              <span>Day 5</span>
              <span>Day 10</span>
              <span>Day 15</span>
              <span>Day 19</span>
            </div>
          </div>

          <!-- Gantt Bars -->
          <div style="display: flex; flex-direction: column; gap: 1.25rem;">
            <!-- T1: Day 0 to 5 (5d) -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: #f87171;">T1</strong>: Requirements Arch
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 0 &rarr; 5 (5d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill critical" style="width: 26.3%; margin-left: 0%;"></div>
              </div>
            </div>

            <!-- T2: Day 5 to 9 (4d) -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: #f87171;">T2</strong>: Database Schema
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 5 &rarr; 9 (4d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill critical" style="width: 21%; margin-left: 26.3%;"></div>
              </div>
            </div>

            <!-- T4: Day 5 to 8 (3d) [Float 2d] -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: var(--accent-cyan);">T4</strong>: UI/UX Glassmorphism
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 5 &rarr; 8 (Slack: 2d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill" style="width: 15.8%; margin-left: 26.3%;"></div>
              </div>
            </div>

            <!-- T3: Day 9 to 15 (6d) -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: #f87171;">T3</strong>: Backend Servlets
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 9 &rarr; 15 (6d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill critical" style="width: 31.5%; margin-left: 47.3%;"></div>
              </div>
            </div>

            <!-- T5: Day 8 to 13 (5d) [Float 2d] -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: var(--accent-cyan);">T5</strong>: 3D WebGL Three.js
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 8 &rarr; 13 (Slack: 2d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill" style="width: 26.3%; margin-left: 42.1%;"></div>
              </div>
            </div>

            <!-- T6: Day 15 to 19 (4d) -->
            <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1rem; align-items: center;">
              <div>
                <strong style="color: #f87171;">T6</strong>: Integration & QA
                <div style="font-size: 0.75rem; color: var(--text-muted);">Days 15 &rarr; 19 (4d)</div>
              </div>
              <div class="timeline-bar-bg">
                <div class="timeline-bar-fill critical" style="width: 21.2%; margin-left: 78.8%;"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
