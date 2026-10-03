<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Project Scheduling System</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600&family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    .login-wrapper {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 1.5rem;
    }
    .login-box {
      width: 100%;
      max-width: 440px;
    }
  </style>
</head>
<body>
  <div class="login-wrapper">
    <div class="glass-card login-box">
      <div style="text-align: center; margin-bottom: 2rem;">
        <div style="width: 56px; height: 56px; border-radius: 14px; background: linear-gradient(135deg, var(--accent-cyan), var(--accent-indigo)); display: inline-flex; align-items: center; justify-content: center; color: #fff; font-size: 1.6rem; box-shadow: 0 0 20px var(--accent-cyan-glow); margin-bottom: 1rem;">
          <i class="fa-solid fa-network-wired"></i>
        </div>
        <h2 style="font-size: 1.6rem; margin-bottom: 0.35rem;">Project Flow</h2>
        <p style="color: var(--text-secondary); font-size: 0.88rem;">DAG Scheduling & 3D CPM Analysis</p>
      </div>

      <% if (request.getAttribute("errorMessage") != null) { %>
        <div style="background: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171; padding: 0.75rem 1rem; border-radius: 8px; margin-bottom: 1.5rem; font-size: 0.88rem; display: flex; align-items: center; gap: 0.65rem;">
          <i class="fa-solid fa-triangle-exclamation"></i>
          <span><%= request.getAttribute("errorMessage") %></span>
        </div>
      <% } %>

      <form action="login" method="post">
        <div style="margin-bottom: 1.25rem;">
          <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.4rem;">Username</label>
          <input type="text" name="username" class="form-control-glass" placeholder="admin / manager / employee" required autofocus>
        </div>

        <div style="margin-bottom: 1.75rem;">
          <label style="display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-secondary); margin-bottom: 0.4rem;">Password</label>
          <input type="password" name="password" class="form-control-glass" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn-glass btn-gradient-cyan" style="width: 100%; justify-content: center; padding: 0.75rem;">
          Sign In <i class="fa-solid fa-arrow-right"></i>
        </button>
      </form>

      <div style="margin-top: 2rem; padding-top: 1.25rem; border-top: 1px solid var(--border-glass); font-size: 0.82rem; color: var(--text-muted); text-align: center;">
        <p>Demo accounts (password: <strong>admin123</strong> / <strong>pass123</strong>):</p>
        <span class="mono badge-glass badge-cyan" style="margin: 0.2rem;">admin</span>
        <span class="mono badge-glass badge-cyan" style="margin: 0.2rem;">manager1</span>
        <span class="mono badge-glass badge-cyan" style="margin: 0.2rem;">emp1</span>
      </div>
    </div>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
