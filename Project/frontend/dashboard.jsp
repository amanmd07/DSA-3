<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard | Project Flow Scheduling</title>
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
        <div class="sidebar-brand-icon">
          <i class="fa-solid fa-network-wired"></i>
        </div>
        <div>
          <h4 style="font-size: 1.1rem; margin: 0;">PROJECT FLOW</h4>
          <span style="font-size: 0.75rem; color: var(--text-muted);">DSA 3D Engine</span>
        </div>
      </div>

      <nav class="sidebar-nav">
        <a href="dashboard.jsp" class="nav-item-link active"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
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
        <button id="theme-toggle" class="btn-glass" style="padding: 0.4rem 0.8rem;" title="Toggle Dark/Light Mode">
          <i class="fa-solid fa-sun"></i>
        </button>
        <a href="login.jsp" class="btn-glass btn-gradient-crimson" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
          <i class="fa-solid fa-arrow-right-from-bracket"></i>
        </a>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="main-wrapper">
      <header class="top-navbar">
        <div>
          <h2 style="font-size: 1.35rem; margin: 0;">System Dashboard</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Directed Acyclic Graph & Topological Scheduling Analytics</p>
        </div>
        <div style="display: flex; gap: 0.75rem; align-items: center;">
          <form action="schedule" method="post" style="display: inline;">
            <input type="hidden" name="projectId" value="101">
            <button type="submit" class="btn-glass btn-gradient-cyan">
              <i class="fa-solid fa-rotate"></i> Recalculate CPM
            </button>
          </form>
          <a href="critical_path.jsp" class="btn-glass btn-gradient-crimson">
            <i class="fa-solid fa-eye"></i> View 3D Graph
          </a>
        </div>
      </header>

      <div class="page-content">
        <!-- KPI Stats -->
        <div class="stats-grid">
          <div class="glass-card stat-card">
            <div class="stat-icon cyan"><i class="fa-solid fa-list-check"></i></div>
            <div>
              <div class="stat-number">6</div>
              <div class="stat-label">Graph Tasks (Vertices)</div>
            </div>
          </div>

          <div class="glass-card stat-card">
            <div class="stat-icon indigo"><i class="fa-solid fa-arrow-right-arrow-left"></i></div>
            <div>
              <div class="stat-number">6</div>
              <div class="stat-label">Precedence Edges</div>
            </div>
          </div>

          <div class="glass-card stat-card">
            <div class="stat-icon crimson"><i class="fa-solid fa-fire"></i></div>
            <div>
              <div class="stat-number">19 <span style="font-size: 1rem; font-weight: 500;">Days</span></div>
              <div class="stat-label">Critical Duration</div>
            </div>
          </div>

          <div class="glass-card stat-card">
            <div class="stat-icon emerald"><i class="fa-solid fa-circle-check"></i></div>
            <div>
              <div class="stat-number">Valid</div>
              <div class="stat-label">DAG Cycle Check (DFS)</div>
            </div>
          </div>
        </div>

        <!-- Algorithmic Sequence Banner -->
        <div class="glass-card" style="margin-bottom: 2rem;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
            <div>
              <h3 style="font-size: 1.1rem; margin-bottom: 0.25rem;"><i class="fa-solid fa-network-wired" style="color: var(--accent-cyan);"></i> Kahn's Topological Sort Execution Order</h3>
              <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 0;">Linear precedence scheduling resolved in O(V + E) complexity</p>
            </div>
            <span class="badge-glass badge-cyan">In-Degree Queue Model</span>
          </div>

          <div style="display: flex; gap: 0.75rem; overflow-x: auto; padding: 0.5rem 0;">
            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center; border-color: var(--accent-critical);">
              <span class="badge-glass badge-critical" style="margin-bottom: 0.35rem;">Step 1</span>
              <div style="font-weight: 700;">T1</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">Architecture (5d)</div>
            </div>
            <div style="display: flex; align-items: center; color: var(--text-muted);"><i class="fa-solid fa-chevron-right"></i></div>

            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center; border-color: var(--accent-critical);">
              <span class="badge-glass badge-critical" style="margin-bottom: 0.35rem;">Step 2</span>
              <div style="font-weight: 700;">T2</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">Database (4d)</div>
            </div>
            <div style="display: flex; align-items: center; color: var(--text-muted);"><i class="fa-solid fa-chevron-right"></i></div>

            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center;">
              <span class="badge-glass badge-cyan" style="margin-bottom: 0.35rem;">Step 3</span>
              <div style="font-weight: 700;">T4</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">UI/UX (3d)</div>
            </div>
            <div style="display: flex; align-items: center; color: var(--text-muted);"><i class="fa-solid fa-chevron-right"></i></div>

            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center; border-color: var(--accent-critical);">
              <span class="badge-glass badge-critical" style="margin-bottom: 0.35rem;">Step 4</span>
              <div style="font-weight: 700;">T3</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">Backend API (6d)</div>
            </div>
            <div style="display: flex; align-items: center; color: var(--text-muted);"><i class="fa-solid fa-chevron-right"></i></div>

            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center;">
              <span class="badge-glass badge-cyan" style="margin-bottom: 0.35rem;">Step 5</span>
              <div style="font-weight: 700;">T5</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">3D WebGL (5d)</div>
            </div>
            <div style="display: flex; align-items: center; color: var(--text-muted);"><i class="fa-solid fa-chevron-right"></i></div>

            <div class="glass-card" style="padding: 0.85rem 1.25rem; min-width: 140px; text-align: center; border-color: var(--accent-critical);">
              <span class="badge-glass badge-critical" style="margin-bottom: 0.35rem;">Step 6</span>
              <div style="font-weight: 700;">T6</div>
              <div style="font-size: 0.78rem; color: var(--text-muted);">Testing & QA (4d)</div>
            </div>
          </div>
        </div>

        <!-- Schedule Matrix -->
        <div class="glass-card">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
            <h3 style="font-size: 1.15rem; margin: 0;">Active CPM Forward & Backward Pass Schedule</h3>
            <span class="badge-glass badge-critical"><i class="fa-solid fa-fire"></i> Critical Path: T1 -> T2 -> T3 -> T6</span>
          </div>

          <div style="overflow-x: auto;">
            <table class="table-glass">
              <thead>
                <tr>
                  <th>Task ID</th>
                  <th>Task Name</th>
                  <th>Duration</th>
                  <th>EST</th>
                  <th>EFT</th>
                  <th>LST</th>
                  <th>LFT</th>
                  <th>Total Float</th>
                  <th>Bottleneck Status</th>
                </tr>
              </thead>
              <tbody>
                <tr class="critical-row">
                  <td class="mono"><strong>#1 (T1)</strong></td>
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
                  <td class="mono"><strong>#2 (T2)</strong></td>
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
                  <td class="mono">#4 (T4)</td>
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
                  <td class="mono"><strong>#3 (T3)</strong></td>
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
                  <td class="mono">#5 (T5)</td>
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
                  <td class="mono"><strong>#6 (T6)</strong></td>
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
        </div>
      </div>
    </main>
  </div>

  <script src="js/app.js"></script>
</body>
</html>
