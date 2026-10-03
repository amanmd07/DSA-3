# Project Scheduling System using Graph Algorithms & 3D Visualization

> **B.Tech Computer Science Engineering Semester Project**  
> **Algorithms Implemented**: Directed Acyclic Graph (DAG), Kahn's Topological Sorting Algorithm, Depth First Search (DFS) Cycle Detection, Critical Path Method (CPM).  
> **Frontend Stack**: HTML5, Vanilla CSS3 (Glassmorphism & Dark Mode), Bootstrap 5, JavaScript ES6, Three.js (WebGL 3D Engine).  
> **Backend Stack**: Java EE (JSP & Servlets), MySQL Relational Database, JDBC Connection Pooling.

---

## Table of Contents
1. [Project Overview & Key Features](#1-project-overview--key-features)
2. [Software Architecture & Tech Stack](#2-software-architecture--tech-stack)
3. [Installation Guide](#3-installation-guide)
4. [User Manual](#4-user-manual)
5. [Developer Guide](#5-developer-guide)
6. [Deployment Manual](#6-deployment-manual)

---

## 1. Project Overview & Key Features

The **Project Scheduling System** is an enterprise web application designed to solve complex activity scheduling, precedence validation, bottleneck detection, and slack time calculation in software and construction engineering projects.

### Key Capabilities:
- **Graph-Based Task Modeling**: Represents project tasks as nodes (vertices) and precedence constraints as directed edges in a **Directed Acyclic Graph (DAG)**.
- **Automated Cycle Detection**: Utilizes Kahn's Algorithm and DFS recursion stacks to detect circular dependencies ($Task A \rightarrow Task B \rightarrow Task A$) and prevent invalid schedules.
- **Topological Sorting**: Computes valid linear task execution sequences in $O(V + E)$ time.
- **CPM Engine**: Performs Forward Pass (Earliest Start/Finish) and Backward Pass (Latest Start/Finish) to identify the **Critical Path** ($Float = 0$) and total project completion time.
- **Interactive Three.js 3D Visualizer**: Renders task dependency trees in full 3D WebGL space with glowing neon red halos on critical path nodes.
- **Role-Based Access Control (RBAC)**: Dedicated portals for **Admin**, **Project Manager**, and **Employee**.
- **Gantt Chart & Calendar Views**: Proportional progress bars and monthly milestone mapping.
- **PDF & Excel Exporters**: Generate downloadable project schedule reports and task spreadsheets.

---

## 2. Software Architecture & Tech Stack

```
PROJECT/
├── backend/                    # Backend Algorithmic Engine & Java Services
│   ├── src/com/projectscheduler/
│   │   ├── algo/               # Graph & Algorithmic Core (DAG, Kahn, DFS, CPM)
│   │   ├── config/             # JDBC Connection Pool
│   │   ├── controller/         # Servlet MVC Controllers
│   │   ├── dao/                # Data Access Objects (UserDAO, TaskDAO, etc.)
│   │   ├── filter/             # Auth & RBAC Security Filter
│   │   ├── model/              # Data Entity Models
│   │   ├── service/            # ScheduleService
│   │   └── Main.java           # Standalone Algorithmic Test & Benchmark Entry Point
│   ├── lib/                    # Servlet & JDBC Dependencies
│   ├── bin/                    # Compiled JVM Bytecode
│   ├── schema.sql              # MySQL Database Schema & Sample Data
│   └── run.bat                 # Backend Execution Script
├── frontend/                   # Frontend Presentation & 3D WebGL Layer
│   ├── css/
│   │   └── style.css           # Glassmorphism Design System & Theme Styles
│   ├── js/
│   │   ├── graph3d.js          # Three.js 3D WebGL Engine with Glowing Halos
│   │   └── app.js              # Theme Toggle & Interactivity Manager
│   ├── WEB-INF/
│   │   └── web.xml             # Servlet Dispatcher & Welcome List Configuration
│   ├── login.jsp               # Authentication View
│   ├── dashboard.jsp           # KPI Analytics & Kahn Sequence Pipeline
│   ├── projects.jsp            # Project Workspace Repositories
│   ├── tasks.jsp               # Graph Vertices Directory
│   ├── dependencies.jsp        # Directed Precedence Constraints
│   ├── scheduler.jsp           # CPM Forward/Backward Pass Schedule Matrix
│   ├── critical_path.jsp       # Interactive 3D WebGL Visualizer
│   ├── calendar.jsp            # Milestone & Gantt Timeline
│   ├── reports.jsp             # Formal PDF & Excel CSV Exporters
│   ├── profile.jsp             # Employee Workspace
│   ├── settings.jsp            # Algorithmic & System Settings
│   └── admin_users.jsp         # Role-Based Access Control (RBAC) Portal
├── run_backend.bat             # Root Quick Launch Script
├── run_backend.ps1             # PowerShell Launch Script
├── viva_prep_guide.md          # 50+ Technical Viva Questions & Answers
└── README.md
```

---

## 3. Installation Guide

### Prerequisites:
- **Java Development Kit (JDK)**: JDK 11 or JDK 17 installed.
- **Web Server**: Apache Tomcat 9.0 or Tomcat 10.0.
- **Database**: MySQL Server 8.0+.
- **IDE**: Eclipse IDE for Enterprise Java Developers or IntelliJ IDEA Ultimate.

### Step-by-Step Installation:

1. **Clone / Download Project**:
   Place the project folder into your workspace directory.

2. **Database Setup**:
   - Open MySQL Command Line Client or MySQL Workbench.
   - Run the provided schema script:
     ```bash
     mysql -u root -p < schema.sql
     ```
   - Verify that the database `project_scheduler_db` and all 7 tables (`users`, `projects`, `tasks`, `dependencies`, etc.) are created.

3. **Configure Database Credentials**:
   - Open `src/com/projectscheduler/config/DBConnectionPool.java`.
   - Update `USER` and `PASSWORD` to match your local MySQL installation settings:
     ```java
     private static final String USER = "root";
     private static final String PASSWORD = "your_mysql_password";
     ```

4. **Import into IDE & Configure Tomcat**:
   - In Eclipse: `File -> Import -> Existing Projects into Workspace`.
   - Add Apache Tomcat Server under Server runtime environments.
   - Right-click Project $\rightarrow$ `Run As -> Run on Server`.

5. **Access Application**:
   Open browser at: `http://localhost:8080/PROJECT/`

---

## 4. User Manual

### Demo User Accounts:
| Role | Username | Password | Default Portal |
| :--- | :--- | :--- | :--- |
| **System Admin** | `admin` | `admin123` | `admin_users.jsp` |
| **Project Manager** | `manager1` | `admin123` | `dashboard.jsp` |
| **Employee** | `dev_john` | `admin123` | `profile.jsp` |

### Step-by-Step Workflow:

1. **Login**: Navigate to `login.jsp`, select your role, and sign in.
2. **Create Project**: Go to **Projects**, click **Create New Project**, enter title and start date.
3. **Add Task Nodes**: Go to **Tasks**, click **Add Task Node**, specify duration in days and assign an employee.
4. **Link Dependency Edges**: Go to **Dependencies**, select Prerequisite (Parent Task) and Dependent Task (Child Task).
5. **Run Kahn Scheduler**: Go to **Kahn Scheduler**, click **Run Kahn Topological Sorter**. If a cycle is present, a warning toast will alert you.
6. **View 3D Critical Path**: Go to **Critical Path 3D**. Click and drag to rotate the 3D WebGL network in space. Critical tasks with zero float will glow with neon red energy halos.
7. **Export Reports**: Go to **Reports**, click **Download PDF Report** or **Download Excel (.csv)**.

---

## 5. Developer Guide

### Algorithmic Class Breakdown:
- **`Graph.java`**: Maintains `Map<Integer, List<Integer>> adjList` for forward edges and `reverseAdjList` for predecessor lookup.
- **`KahnTopologicalSorter.java`**: Implements Queue-based topological sort in $O(V + E)$ time.
- **`CPMEngine.java`**: Computes $ES[u] = \max(EF[prev])$, $EF[u] = ES[u] + Dur[u]$, $LF[u] = \min(LS[next])$, $LS[u] = LF[u] - Dur[u]$, and $Float[u] = LS[u] - ES[u]$.
- **`graph3d.js`**: Uses Three.js WebGL `PerspectiveCamera`, `DirectionalLight`, `SphereGeometry`, and `CylinderGeometry` to render directed graph arrow meshes.

### Adding New Features:
To add a new graph algorithm (e.g., PERT 3-estimate calculation):
1. Add new fields (`optimisticTime`, `pessimisticTime`) to `Task.java` and `tasks` MySQL table.
2. Create `PERTEngine.java` in `com.projectscheduler.algo`.
3. Create a new servlet controller `PERTServlet.java` and bind to a button in `scheduler.jsp`.

---

## 6. Deployment Manual

### Packaging WAR File:
1. In Eclipse / IntelliJ: Right-click Project $\rightarrow$ `Export -> WAR File`.
2. Name the file `PROJECT.war`.

### Tomcat Server Deployment:
1. Copy `PROJECT.war` into your Tomcat `webapps/` directory (`C:\Program Files\Apache Software Foundation\Tomcat 10.0\webapps\`).
2. Start the Tomcat service:
   ```cmd
   bin\startup.bat
   ```
3. Tomcat will automatically extract `PROJECT.war` and deploy the web application.
4. Access the live production instance at `http://your-server-ip:8080/PROJECT/`.

---

## License & Credits
- **Project Type**: B.Tech CSE Semester Project
- **Design System**: Bootstrap 5 + Three.js 3D WebGL
- **Backend Architecture**: Java EE (JSP/Servlet) MVC
