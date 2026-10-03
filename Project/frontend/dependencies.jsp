<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dependencies | Project Flow Scheduling</title>
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
        <a href="tasks.jsp" class="nav-item-link"><i class="fa-solid fa-list-check"></i> Tasks</a>
        <a href="dependencies.jsp" class="nav-item-link active"><i class="fa-solid fa-diagram-project"></i> Dependencies</a>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Precedence Constraints (DAG Edges)</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Directed relationships enforcing strict topological predecessor order</p>
        </div>
        <button class="btn-glass btn-gradient-cyan" onclick="document.getElementById('new-edge-modal').style.display='flex'">
          <i class="fa-solid fa-link"></i> Add Dependency
        </button>
      </header>

      <div class="page-content">
        <% if (request.getAttribute("errorMessage") != null) { %>
          <div style="background: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.35); color: #f87171; padding: 1rem 1.25rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
            <i class="fa-solid fa-triangle-exclamation" style="font-size: 1.2rem;"></i>
            <div>
              <strong>Cycle Validation Error:</strong> <%= request.getAttribute("errorMessage") %>
            </div>
          </div>
        <% } %>

        <div class="glass-card">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
            <h3 style="font-size: 1.15rem; margin: 0;">Active Directed Graph Edges E = (u, v)</h3>
            <span class="badge-glass badge-emerald"><i class="fa-solid fa-check"></i> 6 Edges Active | Zero Cycles</span>
          </div>

          <div style="overflow-x: auto;">
            <table class="table-glass">
              <thead>
                <tr>
                  <th>Edge ID</th>
                  <th>Predecessor Task (u)</th>
                  <th>Directed Link</th>
                  <th>Successor Task (v)</th>
                  <th>Type</th>
                  <th>Critical Path?</th>
                </tr>
              </thead>
              <tbody>
                <tr class="critical-row">
                  <td class="mono">#E1</td>
                  <td><strong>T1</strong>: Requirements Gathering</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-critical);"></i></td>
                  <td><strong>T2</strong>: Database Schema</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-critical">YES</span></td>
                </tr>
                <tr>
                  <td class="mono">#E2</td>
                  <td><strong>T1</strong>: Requirements Gathering</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-cyan);"></i></td>
                  <td><strong>T4</strong>: UI/UX Design</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-cyan">NO</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono">#E3</td>
                  <td><strong>T2</strong>: Database Schema</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-critical);"></i></td>
                  <td><strong>T3</strong>: Backend Algorithms</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-critical">YES</span></td>
                </tr>
                <tr>
                  <td class="mono">#E4</td>
                  <td><strong>T4</strong>: UI/UX Design</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-cyan);"></i></td>
                  <td><strong>T5</strong>: 3D WebGL Three.js</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-cyan">NO</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono">#E5</td>
                  <td><strong>T3</strong>: Backend Algorithms</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-critical);"></i></td>
                  <td><strong>T6</strong>: System Integration</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-critical">YES</span></td>
                </tr>
                <tr>
                  <td class="mono">#E6</td>
                  <td><strong>T5</strong>: 3D WebGL Three.js</td>
                  <td><i class="fa-solid fa-arrow-right" style="color: var(--accent-cyan);"></i></td>
                  <td><strong>T6</strong>: System Integration</td>
                  <td><span class="badge-glass badge-cyan">Finish-to-Start</span></td>
                  <td><span class="badge-glass badge-cyan">NO</span></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Add Precedence Modal -->
        <div id="new-edge-modal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); backdrop-filter: blur(8px); align-items: center; justify-content: center; z-index: 2000; padding: 1.5rem;">
          <div class="glass-card" style="width: 100%; max-width: 460px; background: var(--bg-secondary);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
              <h3 style="font-size: 1.2rem; margin: 0;"><i class="fa-solid fa-link" style="color: var(--accent-cyan);"></i> Link Dependency (Precedence)</h3>
              <button class="btn-glass" style="padding: 0.3rem 0.6rem;" onclick="document.getElementById('new-edge-modal').style.display='none'">&times;</button>
            </div>

            <form action="dependency" method="post">
              <input type="hidden" name="action" value="CREATE">
              <input type="hidden" name="projectId" value="101">

              <div style="margin-bottom: 1.25rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Predecessor Task (Must Finish First)</label>
                <select name="predecessorTaskId" class="form-control-glass">
                  <option value="1">T1: Requirements Gathering (5d)</option>
                  <option value="2">T2: Database Schema (4d)</option>
                  <option value="3">T3: Backend Servlets (6d)</option>
                  <option value="4">T4: UI/UX Design (3d)</option>
                  <option value="5">T5: 3D Visualizer (5d)</option>
                  <option value="6">T6: Testing & QA (4d)</option>
                </select>
              </div>

              <div style="margin-bottom: 1.5rem;">
                <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.35rem;">Successor Task (Cannot Start Until Predecessor Completes)</label>
                <select name="successorTaskId" class="form-control-glass">
                  <option value="2">T2: Database Schema (4d)</option>
                  <option value="3">T3: Backend Servlets (6d)</option>
                  <option value="4">T4: UI/UX Design (3d)</option>
                  <option value="5">T5: 3D Visualizer (5d)</option>
                  <option value="6" selected>T6: Testing & QA (4d)</option>
                </select>
              </div>

              <div style="display: flex; justify-content: flex-end; gap: 0.75rem;">
                <button type="button" class="btn-glass" onclick="document.getElementById('new-edge-modal').style.display='none'">Cancel</button>
                <button type="submit" class="btn-glass btn-gradient-cyan">Connect Edge</button>
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
