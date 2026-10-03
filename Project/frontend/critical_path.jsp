<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>3D Critical Path | Project Flow Scheduling</title>
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
        <a href="dashboard.jsp" class="nav-item-link"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        <a href="projects.jsp" class="nav-item-link"><i class="fa-solid fa-folder-tree"></i> Projects</a>
        <a href="tasks.jsp" class="nav-item-link"><i class="fa-solid fa-list-check"></i> Tasks</a>
        <a href="dependencies.jsp" class="nav-item-link"><i class="fa-solid fa-diagram-project"></i> Dependencies</a>
        <a href="scheduler.jsp" class="nav-item-link"><i class="fa-solid fa-calculator"></i> CPM Scheduler</a>
        <a href="critical_path.jsp" class="nav-item-link active"><i class="fa-solid fa-cube"></i> 3D Critical Path</a>
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
          <h2 style="font-size: 1.35rem; margin: 0;">Interactive 3D WebGL Graph Visualizer</h2>
          <p style="font-size: 0.82rem; color: var(--text-secondary); margin: 0;">Topological DAG rendering with glowing Critical Path halos</p>
        </div>
        <div style="display: flex; gap: 0.75rem;">
          <button id="reset-cam" class="btn-glass"><i class="fa-solid fa-arrows-rotate"></i> Reset Camera</button>
          <a href="scheduler.jsp" class="btn-glass btn-gradient-cyan"><i class="fa-solid fa-table"></i> CPM Schedule Table</a>
        </div>
      </header>

      <div class="page-content">
        <!-- 3D Canvas Box -->
        <div class="glass-card" style="padding: 0; overflow: hidden; margin-bottom: 2rem;">
          <div class="webgl-container" id="webgl-viewport">
            <div class="webgl-hud">
              <div><i class="fa-solid fa-mouse"></i> <strong>Controls:</strong> Left Click + Drag to Rotate | Scroll to Zoom | Right Click to Pan</div>
              <div style="margin-top: 0.35rem;">
                <span style="color: #ef4444; font-weight: 700;">● Glowing Red Nodes:</span> Critical Path (Float = 0) &nbsp;|&nbsp;
                <span style="color: #06b6d4; font-weight: 700;">● Cyan Nodes:</span> Non-Critical (Slack &gt; 0)
              </div>
            </div>
          </div>
        </div>

        <!-- Legend and Algorithmic Explanation Cards -->
        <div class="stats-grid">
          <div class="glass-card">
            <h4 style="font-size: 1rem; margin-bottom: 0.5rem; color: var(--accent-critical);">
              <i class="fa-solid fa-fire"></i> Critical Path Bottlenecks
            </h4>
            <p style="font-size: 0.85rem; color: var(--text-secondary); line-height: 1.6;">
              Tasks <strong>T1 &rarr; T2 &rarr; T3 &rarr; T6</strong> have zero float (slack). Any delay on these tasks directly extends total project completion time (19 days).
            </p>
          </div>

          <div class="glass-card">
            <h4 style="font-size: 1rem; margin-bottom: 0.5rem; color: var(--accent-cyan);">
              <i class="fa-solid fa-clock"></i> Slack Time Flexibility
            </h4>
            <p style="font-size: 0.85rem; color: var(--text-secondary); line-height: 1.6;">
              Tasks <strong>T4</strong> and <strong>T5</strong> carry 2 days of float. They can start between Day 5 and Day 7 without altering the project delivery deadline.
            </p>
          </div>

          <div class="glass-card">
            <h4 style="font-size: 1rem; margin-bottom: 0.5rem; color: var(--accent-success);">
              <i class="fa-solid fa-shield-halved"></i> Cycle-Free Guarantee
            </h4>
            <p style="font-size: 0.85rem; color: var(--text-secondary); line-height: 1.6;">
              DFS Recursion Stack and Kahn's in-degree algorithms verified zero circular loops ($u \to v \to u$) across the graph structure.
            </p>
          </div>
        </div>
      </div>
    </main>
  </div>

  <!-- Three.js CDN & OrbitControls -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
  <script src="js/graph3d.js"></script>
  <script src="js/app.js"></script>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
      const visualizer = new Graph3DVisualizer('webgl-viewport');

      // Sample Nodes matching Main.java
      const nodes = [
        { id: 1, label: 'T1: Architecture', duration: 5, es: 0, isCritical: true },
        { id: 2, label: 'T2: Database', duration: 4, es: 5, isCritical: true },
        { id: 4, label: 'T4: UI/UX Design', duration: 3, es: 5, isCritical: false },
        { id: 3, label: 'T3: Backend API', duration: 6, es: 9, isCritical: true },
        { id: 5, label: 'T5: 3D Visualizer', duration: 5, es: 8, isCritical: false },
        { id: 6, label: 'T6: Testing & QA', duration: 4, es: 15, isCritical: true }
      ];

      // Sample Edges matching Main.java
      const edges = [
        { from: 1, to: 2, isCritical: true },
        { from: 1, to: 4, isCritical: false },
        { from: 2, to: 3, isCritical: true },
        { from: 4, to: 5, isCritical: false },
        { from: 3, to: 6, isCritical: true },
        { from: 5, to: 6, isCritical: false }
      ];

      visualizer.loadGraphData(nodes, edges);

      const resetBtn = document.getElementById('reset-cam');
      if (resetBtn) {
        resetBtn.addEventListener('click', () => {
          visualizer.camera.position.set(0, 25, 75);
          if (visualizer.controls) visualizer.controls.target.set(0, 0, 0);
        });
      }
    });
  </script>
</body>
</html>
