<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tasks | Project Flow Scheduling</title>
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
        <a href="projects.jsp" class="nav-item-link"><i class="fa-solid fa-folder-tree"></i> Projects</a>
        <a href="tasks.jsp" class="nav-item-link active"><i class="fa-solid fa-list-check"></i> Tasks</a>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Task Directory (Graph Vertices)</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Activities with duration estimates for DAG precedence processing</p>
        </div>
        <button class="btn-glass btn-gradient-cyan" onclick="document.getElementById('new-task-modal').style.display='flex'">
          <i class="fa-solid fa-plus"></i> Add New Task
        </button>
      </header>

      <div class="page-content">
        <div class="glass-card">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
            <div style="font-size: 0.9rem; color: var(--text-secondary);">
              Showing <strong>6 active activities</strong> in Project 101
            </div>
            <a href="dependencies.jsp" class="btn-glass" style="font-size: 0.82rem;">
              <i class="fa-solid fa-arrow-right-arrow-left"></i> Manage Dependencies
            </a>
          </div>

          <div style="overflow-x: auto;">
            <table class="table-glass">
              <thead>
                <tr>
                  <th>Vertex ID</th>
                  <th>Task Code</th>
                  <th>Task Description</th>
                  <th>Duration</th>
                  <th>Assigned Role</th>
                  <th>Float / Slack</th>
                  <th>Critical Path?</th>
                </tr>
              </thead>
              <tbody>
                <tr class="critical-row">
                  <td class="mono"><strong>#1</strong></td>
                  <td><span class="mono badge-glass badge-critical">T1</span></td>
                  <td>Requirements Gathering & Architecture</td>
                  <td>5 Days</td>
                  <td>Chief Architect</td>
                  <td class="mono">0 days</td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono"><strong>#2</strong></td>
                  <td><span class="mono badge-glass badge-critical">T2</span></td>
                  <td>Database Schema & Entity Models</td>
                  <td>4 Days</td>
                  <td>Database Admin</td>
                  <td class="mono">0 days</td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr>
                  <td class="mono">#4</td>
                  <td><span class="mono badge-glass badge-cyan">T4</span></td>
                  <td>UI/UX Glassmorphism Design</td>
                  <td>3 Days</td>
                  <td>Lead Designer</td>
                  <td class="mono">2 days</td>
                  <td><span class="badge-glass badge-cyan">Non-Critical</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono"><strong>#3</strong></td>
                  <td><span class="mono badge-glass badge-critical">T3</span></td>
                  <td>Backend Algorithms & Servlets</td>
                  <td>6 Days</td>
                  <td>Java Engineer</td>
                  <td class="mono">0 days</td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr>
                  <td class="mono">#5</td>
                  <td><span class="mono badge-glass badge-cyan">T5</span></td>
                  <td>3D WebGL Three.js Visualizer</td>
                  <td>5 Days</td>
                  <td>Graphics Engineer</td>
                  <td class="mono">2 days</td>
                  <td><span class="badge-glass badge-cyan">Non-Critical</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono"><strong>#6</strong></td>
                  <td><span class="mono badge-glass badge-critical">T6</span></td>
                  <td>System Integration & Testing</td>
                  <td>4 Days</td>
                  <td>QA Lead</td>
                  <td class="mono">0 days</td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Add Task Modal -->
        <div id="new-task-modal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); backdrop-filter: blur(8px); align-items: center; justify-content: center; z-index: 2000; padding: 1.5rem;">
          <div class="glass-card" style="width: 100%; max-width: 480px; background: var(--bg-secondary);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
              <h3 style="font-size: 1.2rem; margin: 0;"><i class="fa-solid fa-calendar-plus" style="color: var(--accent-cyan);"></i> Add New Task (Vertex)</h3>
              <button class="btn-glass" style="padding: 0.3rem 0.6rem;" onclick="document.getElementById('new-task-modal').style.display='none'">&times;</button>
            </div>

            <form action="task" method="post">
              <input type="hidden" name="action" value="CREATE">
              <input type="hidden" name="projectId" value="101">

              <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Task Name / Code</label>
                <input type="text" name="taskName" class="form-control-glass" placeholder="e.g. T7 or Security Audit" required>
              </div>

              <div style="margin-bottom: 1rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Description</label>
                <textarea name="description" class="form-control-glass" rows="2" placeholder="Task deliverables & criteria"></textarea>
              </div>

              <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1.5rem;">
                <div>
                  <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Duration (Days)</label>
                  <input type="number" name="duration" class="form-control-glass" value="4" min="1" required>
                </div>
                <div>
                  <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Assignee (User ID)</label>
                  <input type="number" name="assignedTo" class="form-control-glass" value="3" placeholder="3">
                </div>
              </div>

              <div style="display: flex; justify-content: flex-end; gap: 0.75rem;">
                <button type="button" class="btn-glass" onclick="document.getElementById('new-task-modal').style.display='none'">Cancel</button>
                <button type="submit" class="btn-glass btn-gradient-cyan">Save Task</button>
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
