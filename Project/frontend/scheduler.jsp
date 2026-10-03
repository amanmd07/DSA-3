<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CPM Scheduler | Project Flow Scheduling</title>
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
        <a href="dependencies.jsp" class="nav-item-link"><i class="fa-solid fa-diagram-project"></i> Dependencies</a>
        <a href="scheduler.jsp" class="nav-item-link active"><i class="fa-solid fa-calculator"></i> CPM Scheduler</a>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Critical Path Method (CPM) Engine</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Forward Pass (EST/EFT) and Backward Pass (LST/LFT) Slack Computation</p>
        </div>
        <form action="schedule" method="post" style="margin: 0;">
          <input type="hidden" name="projectId" value="101">
          <button type="submit" class="btn-glass btn-gradient-cyan">
            <i class="fa-solid fa-play"></i> Run CPM Calculation
          </button>
        </form>
      </header>

      <div class="page-content">
        <% if (request.getAttribute("successMessage") != null) { %>
          <div style="background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.35); color: #34d399; padding: 1rem 1.25rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
            <i class="fa-solid fa-circle-check"></i>
            <div><%= request.getAttribute("successMessage") %></div>
          </div>
        <% } %>

        <!-- Formula Cards -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
          <div class="glass-card">
            <span class="mono badge-glass badge-cyan" style="margin-bottom: 0.5rem;">FORWARD PASS</span>
            <h4 style="font-size: 1.05rem; margin-bottom: 0.35rem;">Earliest Boundary Times</h4>
            <p style="font-size: 0.84rem; color: var(--text-secondary); margin-bottom: 0.5rem;">
              Determines earliest times tasks can start and complete without breaking predecessor links.
            </p>
            <div class="mono" style="background: var(--bg-tertiary); padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 0.8rem;">
              ES = max(EF of predecessors)<br>
              EF = ES + Duration
            </div>
          </div>

          <div class="glass-card">
            <span class="mono badge-glass badge-indigo" style="margin-bottom: 0.5rem;">BACKWARD PASS</span>
            <h4 style="font-size: 1.05rem; margin-bottom: 0.35rem;">Latest Boundary Times</h4>
            <p style="font-size: 0.84rem; color: var(--text-secondary); margin-bottom: 0.5rem;">
              Walks backward from project end to compute deadline thresholds before delaying project.
            </p>
            <div class="mono" style="background: var(--bg-tertiary); padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 0.8rem;">
              LF = min(LS of successors)<br>
              LS = LF - Duration
            </div>
          </div>

          <div class="glass-card">
            <span class="mono badge-glass badge-critical" style="margin-bottom: 0.5rem;">SLACK TIME</span>
            <h4 style="font-size: 1.05rem; margin-bottom: 0.35rem;">Zero Float Identification</h4>
            <p style="font-size: 0.84rem; color: var(--text-secondary); margin-bottom: 0.5rem;">
              Zero slack tasks constitute the critical bottleneck path governing delivery time.
            </p>
            <div class="mono" style="background: var(--bg-tertiary); padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 0.8rem;">
              Float = LS - ES = LF - EF<br>
              Critical Task &hArr; Float = 0
            </div>
          </div>
        </div>

        <!-- Schedule Matrix -->
        <div class="glass-card">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
            <div>
              <h3 style="font-size: 1.15rem; margin-bottom: 0.25rem;">Topological CPM Schedule Table</h3>
              <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Ordered by Kahn's Topological Sort sequence [1, 2, 4, 3, 5, 6]</p>
            </div>
            <div style="display: flex; gap: 0.5rem;">
              <a href="report?type=EXCEL&projectId=101" class="btn-glass" style="font-size: 0.82rem;"><i class="fa-solid fa-file-excel"></i> Export CSV</a>
              <a href="critical_path.jsp" class="btn-glass btn-gradient-crimson" style="font-size: 0.82rem;"><i class="fa-solid fa-cube"></i> View 3D Halos</a>
            </div>
          </div>

          <div style="overflow-x: auto;">
            <table class="table-glass">
              <thead>
                <tr>
                  <th>Order</th>
                  <th>Task ID</th>
                  <th>Task Name</th>
                  <th>Duration</th>
                  <th>ES</th>
                  <th>EF</th>
                  <th>LS</th>
                  <th>LF</th>
                  <th>Float (Slack)</th>
                  <th>Bottleneck Status</th>
                </tr>
              </thead>
              <tbody>
                <tr class="critical-row">
                  <td class="mono">1</td>
                  <td class="mono"><strong>#1</strong></td>
                  <td>Requirements Gathering & Architecture</td>
                  <td>5 days</td>
                  <td class="mono">0</td>
                  <td class="mono">5</td>
                  <td class="mono">0</td>
                  <td class="mono">5</td>
                  <td class="mono"><strong>0</strong></td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono">2</td>
                  <td class="mono"><strong>#2</strong></td>
                  <td>Database Schema & Entity Models</td>
                  <td>4 days</td>
                  <td class="mono">5</td>
                  <td class="mono">9</td>
                  <td class="mono">5</td>
                  <td class="mono">9</td>
                  <td class="mono"><strong>0</strong></td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr>
                  <td class="mono">3</td>
                  <td class="mono">#4</td>
                  <td>UI/UX Glassmorphism Design</td>
                  <td>3 days</td>
                  <td class="mono">5</td>
                  <td class="mono">8</td>
                  <td class="mono">7</td>
                  <td class="mono">10</td>
                  <td class="mono">2</td>
                  <td><span class="badge-glass badge-cyan">Slack (2d)</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono">4</td>
                  <td class="mono"><strong>#3</strong></td>
                  <td>Backend Algorithms & Servlets</td>
                  <td>6 days</td>
                  <td class="mono">9</td>
                  <td class="mono">15</td>
                  <td class="mono">9</td>
                  <td class="mono">15</td>
                  <td class="mono"><strong>0</strong></td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
                <tr>
                  <td class="mono">5</td>
                  <td class="mono">#5</td>
                  <td>3D WebGL Three.js Visualizer</td>
                  <td>5 days</td>
                  <td class="mono">8</td>
                  <td class="mono">13</td>
                  <td class="mono">10</td>
                  <td class="mono">15</td>
                  <td class="mono">2</td>
                  <td><span class="badge-glass badge-cyan">Slack (2d)</span></td>
                </tr>
                <tr class="critical-row">
                  <td class="mono">6</td>
                  <td class="mono"><strong>#6</strong></td>
                  <td>System Integration & Testing</td>
                  <td>4 days</td>
                  <td class="mono">15</td>
                  <td class="mono">19</td>
                  <td class="mono">15</td>
                  <td class="mono">19</td>
                  <td class="mono"><strong>0</strong></td>
                  <td><span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> CRITICAL</span></td>
                </tr>
              </tbody>
            </table>
          </div>

          <div style="margin-top: 1.5rem; padding: 1.25rem; background: var(--bg-tertiary); border-radius: var(--radius-sm); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <div>
              <span style="font-size: 0.85rem; color: var(--text-muted);">MINIMUM PROJECT COMPLETION TIME:</span>
              <div style="font-size: 1.4rem; font-weight: 800; color: #fff;">19 Work Days</div>
            </div>
            <div>
              <span style="font-size: 0.85rem; color: var(--text-muted);">CRITICAL PATH SEQUENCE:</span>
              <div class="mono" style="font-size: 1.05rem; font-weight: 700; color: #f87171;">
                T1 &rarr; T2 &rarr; T3 &rarr; T6
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
