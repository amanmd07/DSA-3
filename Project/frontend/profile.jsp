<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Profile | Project Flow</title>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Employee Workspace & Assigned Tasks</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Update task progress and execution milestones</p>
        </div>
      </header>

      <div class="page-content">
        <div class="glass-card" style="margin-bottom: 2rem;">
          <div style="display: flex; gap: 1.5rem; align-items: center;">
            <div style="width: 64px; height: 64px; border-radius: 50%; background: linear-gradient(135deg, var(--accent-cyan), var(--accent-indigo)); display: flex; align-items: center; justify-content: center; font-size: 1.75rem; color: #fff;">
              <i class="fa-solid fa-user-astronaut"></i>
            </div>
            <div>
              <h3 style="font-size: 1.25rem; margin-bottom: 0.25rem;">Nisar Ahamad</h3>
              <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 0;">Role: <span class="badge-glass badge-cyan">Lead Project Architect</span> &nbsp;|&nbsp; Team: Core Algorithms & 3D WebGL</p>
            </div>
          </div>
        </div>

        <div class="glass-card">
          <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">My Assigned Tasks</h3>
          <div style="overflow-x: auto;">
            <table class="table-glass">
              <thead>
                <tr>
                  <th>Task ID</th>
                  <th>Task Description</th>
                  <th>Duration</th>
                  <th>Current Status</th>
                  <th>Update Milestone Status</th>
                </tr>
              </thead>
              <tbody>
                <tr class="critical-row">
                  <td class="mono"><strong>#1 (T1)</strong></td>
                  <td>Requirements Gathering & Architecture</td>
                  <td>5 Days</td>
                  <td><span class="badge-glass badge-emerald">COMPLETED</span></td>
                  <td>
                    <form action="employeeTask" method="post" style="display: flex; gap: 0.5rem; align-items: center;">
                      <input type="hidden" name="taskId" value="1">
                      <select name="status" class="form-control-glass" style="width: auto; padding: 0.35rem 0.6rem;">
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="COMPLETED" selected>Completed</option>
                        <option value="PENDING">Pending</option>
                      </select>
                      <button type="submit" class="btn-glass btn-gradient-cyan" style="padding: 0.35rem 0.75rem;">Update</button>
                    </form>
                  </td>
                </tr>
                <tr class="critical-row">
                  <td class="mono"><strong>#3 (T3)</strong></td>
                  <td>Backend Algorithms & Servlets</td>
                  <td>6 Days</td>
                  <td><span class="badge-glass badge-cyan">IN_PROGRESS</span></td>
                  <td>
                    <form action="employeeTask" method="post" style="display: flex; gap: 0.5rem; align-items: center;">
                      <input type="hidden" name="taskId" value="3">
                      <select name="status" class="form-control-glass" style="width: auto; padding: 0.35rem 0.6rem;">
                        <option value="IN_PROGRESS" selected>In Progress</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="PENDING">Pending</option>
                      </select>
                      <button type="submit" class="btn-glass btn-gradient-cyan" style="padding: 0.35rem 0.75rem;">Update</button>
                    </form>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
