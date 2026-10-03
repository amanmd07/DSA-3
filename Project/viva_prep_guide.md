# Viva Voce Defense Guide: 50+ Questions & Answers

> **Project Title**: Project Scheduling System using Graph Algorithms & 3D Visualization  
> **Categories Covered**: Graph Theory, DAG, Topological Sorting, Critical Path Method (CPM), Java, JSP, Servlets, MySQL, MVC, Database Design, and Software Engineering.

---

## Category 1: Graph Theory & Directed Acyclic Graphs (DAG)

### Q1: What is a Graph in Data Structures?
**Answer**: A Graph $G = (V, E)$ is a non-linear data structure consisting of a set of vertices (nodes) $V$ and a set of edges $E$ connecting pairs of vertices. In our project, tasks are vertices ($V$) and task dependencies are directed edges ($E$).

### Q2: What is a Directed Acyclic Graph (DAG)?
**Answer**: A Directed Acyclic Graph (DAG) is a directed graph with no directed cycles. This means there is no path that starts at a vertex $u$ and follows a sequence of directed edges back to $u$.

### Q3: Why must a project scheduling network be represented as a DAG?
**Answer**: Project tasks have precedence constraints ($Task A$ must finish before $Task B$ can start). If a cycle exists ($A \rightarrow B \rightarrow A$), it creates a logical impossibility where neither task can ever start. Therefore, the network must be acyclic.

### Q4: How is a Graph represented in memory in your Java application?
**Answer**: Using an **Adjacency List** via `HashMap<Integer, List<Integer>>` where keys are Task IDs and values are lists of dependent child Task IDs. We also maintain a reverse adjacency list for predecessor lookups during CPM backward pass.

### Q5: What is the difference between Adjacency Matrix and Adjacency List?
**Answer**: 
- **Adjacency Matrix**: An $N \times N$ 2D array storing edge weights. Space complexity is $O(V^2)$.
- **Adjacency List**: Stores only existing edges per vertex. Space complexity is $O(V + E)$. Adjacency List is optimal for sparse project task graphs.

### Q6: What is the In-Degree and Out-Degree of a vertex?
**Answer**:
- **In-Degree**: The number of incoming edges directed towards a node. In project scheduling, it represents the number of prerequisite tasks.
- **Out-Degree**: The number of outgoing edges leaving a node. Represents how many tasks depend on the current task.

---

## Category 2: Topological Sorting & Kahn's Algorithm

### Q7: What is Topological Sorting?
**Answer**: A linear ordering of vertices in a DAG such that for every directed edge $u \rightarrow v$, vertex $u$ comes before vertex $v$ in the ordering.

### Q8: Can a graph with a cycle have a Topological Sort?
**Answer**: No. Topological sorting is only possible if and only if the graph is a Directed Acyclic Graph (DAG).

### Q9: Explain Kahn's Algorithm for Topological Sorting.
**Answer**: Kahn's algorithm is a Queue-based approach:
1. Compute in-degree for all vertices.
2. Enqueue all vertices with in-degree = 0.
3. While queue is not empty: Dequeue vertex $u$, add to topological list, decrement in-degree of all neighbors of $u$. If a neighbor's in-degree reaches 0, enqueue it.
4. If topological list size $< V$, a cycle exists!

### Q10: What is the Time and Space Complexity of Kahn's Algorithm?
**Answer**:
- **Time Complexity**: $O(V + E)$ because every vertex and edge is visited once.
- **Space Complexity**: $O(V)$ for the queue, in-degree map, and topological list.

### Q11: How does your system detect circular dependencies?
**Answer**: In `KahnTopologicalSorter.java`, if the number of elements in the topological output list is less than the total number of graph tasks, `CircularDependencyException` is thrown and caught by `ScheduleServlet`.

### Q12: How does Depth First Search (DFS) detect cycles?
**Answer**: By keeping track of vertices in the current recursion stack (`recStack`). If DFS encounters a node already present in `recStack`, a back-edge (cycle) exists.

### Q13: Can a DAG have multiple valid Topological Sorts?
**Answer**: Yes! If multiple tasks have an in-degree of 0 at the same time, any order among them produces a valid topological sequence.

---

## Category 3: Critical Path Method (CPM)

### Q14: What is the Critical Path Method (CPM)?
**Answer**: CPM is a project modeling technique used to calculate the minimum total project duration and identify the sequence of critical activities that cannot be delayed without delaying the entire project completion date.

### Q15: Define Earliest Start (ES) and Earliest Finish (EF).
**Answer**:
- **Earliest Start (ES)**: The earliest possible time a task can begin after all predecessors are finished. $ES[v] = \max(EF[predecessors])$.
- **Earliest Finish (EF)**: $EF[v] = ES[v] + \text{Duration}[v]$.

### Q16: Define Latest Start (LS) and Latest Finish (LF).
**Answer**:
- **Latest Finish (LF)**: The latest possible time a task can finish without delaying project completion. $LF[u] = \min(LS[successors])$.
- **Latest Start (LS)**: $LS[u] = LF[u] - \text{Duration}[u]$.

### Q17: What is Total Float (Slack Time)?
**Answer**: Total Float is the amount of time a task can be delayed without delaying the project completion date. Formula: $\text{Float}[u] = LS[u] - ES[u] = LF[u] - EF[u]$.

### Q18: What is a Critical Task?
**Answer**: A task with **zero Total Float** ($\text{Float} = 0$). Any delay in a critical task directly increases total project completion time.

### Q19: What is the Forward Pass vs. Backward Pass in CPM?
**Answer**:
- **Forward Pass**: Iterates from start to finish in Topological Order to calculate $ES$ and $EF$.
- **Backward Pass**: Iterates from finish to start in Reverse Topological Order to calculate $LF$ and $LS$.

### Q20: What is the difference between PERT and CPM?
**Answer**:
- **CPM**: Deterministic (assumes single fixed duration per task).
- **PERT**: Probabilistic (uses 3 duration estimates: Optimistic, Most Likely, Pessimistic).

---

## Category 4: Java & Object-Oriented Programming

### Q21: What Java features are used in the backend?
**Answer**: Java Collections Framework (`HashMap`, `ArrayList`, `LinkedList`, `HashSet`), Exception Handling, Multithreading, Prepared Statements, and Object-Oriented principles (Encapsulation, Polymorphism).

### Q22: Why use `LinkedList` for the Queue in Kahn's Algorithm?
**Answer**: `LinkedList` implements the `Queue` interface in Java, offering $O(1)$ constant time operations for `add()` (enqueue) and `poll()` (dequeue).

### Q23: What is the difference between `PreparedStatement` and `Statement` in JDBC?
**Answer**:
- **PreparedStatement**: Precompiled SQL query, prevents SQL Injection attacks, faster for repeated queries.
- **Statement**: Compiled every time, vulnerable to SQL Injection.

### Q24: What is JDBC Connection Pooling?
**Answer**: A technique of creating a pool of reusable database connections rather than opening and closing a new physical connection for every HTTP request, drastically improving performance.

### Q25: Why is password hashing important, and what algorithm did you use?
**Answer**: To protect user accounts in case of database breach. We used **SHA-256** cryptographic hashing in `PasswordUtil.java`.

### Q26: What is a Servlet Exception?
**Answer**: An exception thrown by a Servlet when it encounters a failure during HTTP request processing (`doGet` or `doPost`).

---

## Category 5: JSP & Servlet Web Architecture

### Q27: What is a Servlet?
**Answer**: A Java class that runs on a Java-enabled Web Server (like Apache Tomcat) to handle client HTTP requests and generate dynamic web responses.

### Q28: Describe the Servlet Lifecycle.
**Answer**:
1. `init()`: Called once when Servlet is loaded.
2. `service()` / `doGet()` / `doPost()`: Called for every incoming HTTP request.
3. `destroy()`: Called when the server shuts down.

### Q29: What is JSP (JavaServer Pages)?
**Answer**: A server-side technology used to create dynamic web pages by embedding Java code inside HTML using tags. Tomcat compiles JSPs into Servlets automatically.

### Q30: What is the difference between `sendRedirect()` and `forward()`?
**Answer**:
- **`forward()`**: Performed on server-side, URL does not change, request attributes are preserved.
- **`sendRedirect()`**: Client-side redirect (HTTP 302), URL changes in browser, creates a brand new HTTP request.

### Q31: How do you maintain user session state in JSP/Servlet?
**Answer**: Using `HttpSession` (`request.getSession()`), which stores session attributes (`user`, `role`) on the server indexed by a `JSESSIONID` cookie in the browser.

### Q32: What is the purpose of `web.xml`?
**Answer**: The deployment descriptor file that maps URL patterns to Servlet classes, sets welcome pages, and configures session timeouts.

### Q33: What is a Servlet Filter?
**Answer**: A component that intercepts HTTP requests before they reach a Servlet (e.g., `AuthFilter.java` enforcing session checks and RBAC role authorization).

---

## Category 6: MVC Architecture & Design Patterns

### Q34: What is MVC Architecture?
**Answer**:
- **Model**: Data entities and business algorithms (`Task.java`, `CPMEngine.java`).
- **View**: User interface JSPs (`dashboard.jsp`, `critical_path.jsp`).
- **Controller**: Servlets coordinating requests and responses (`ScheduleServlet.java`).

### Q35: What are the benefits of MVC in this project?
**Answer**: Decouples graph processing logic from UI rendering, allowing frontend redesigns (e.g., Three.js 3D visualizer) without modifying core graph algorithms.

### Q36: What is the DAO (Data Access Object) Pattern?
**Answer**: An abstraction layer between business logic and database tables (`TaskDAO.java`, `ProjectDAO.java`), encapsulating raw SQL queries.

### Q37: What is the Singleton Pattern?
**Answer**: Ensures a class has only one instance (e.g., `DBConnectionPool` providing shared database access).

### Q38: How does the 3D visualizer receive data from the Java backend?
**Answer**: Servlet fetches task metrics from DAO, serializes tasks into JSON, and passes JSON to `graph3d.js` which builds Three.js 3D WebGL meshes.

---

## Category 7: MySQL & Database Design

### Q39: What is 3NF (Third Normal Form)?
**Answer**: A database table is in 3NF if it is in 2NF and all non-key attributes are functional dependent ONLY on the primary key (no transitive dependencies).

### Q40: Explain the Foreign Keys in your schema.
**Answer**:
- `tasks.project_id` $\rightarrow$ `projects.project_id` (`ON DELETE CASCADE`)
- `dependencies.parent_task_id` $\rightarrow$ `tasks.task_id` (`ON DELETE CASCADE`)
- `dependencies.child_task_id` $\rightarrow$ `tasks.task_id` (`ON DELETE CASCADE`)

### Q41: Why is there a `UNIQUE` constraint on `(parent_task_id, child_task_id)`?
**Answer**: To prevent duplicate directed edges between the exact same pair of tasks in the graph.

### Q42: What is the difference between `DELETE CASCADE` and `SET NULL`?
**Answer**:
- **`CASCADE`**: Deleting a parent project automatically deletes all its child tasks.
- **`SET NULL`**: Deleting an employee sets `assigned_to = NULL` on assigned tasks without deleting the tasks.

### Q43: What index is automatically created on Primary Keys?
**Answer**: Clustered B-Tree index for $O(\log N)$ fast lookup.

### Q44: What SQL statement is used for batch updates in JDBC?
**Answer**: `PreparedStatement.addBatch()` and `PreparedStatement.executeBatch()`, used in `TaskDAO.updateCPMMetrics()` to save ES/EF/LS/LF metrics in a single network round-trip.

---

## Category 8: Software Engineering & 3D WebGL Visualization

### Q45: What library was used for 3D graph visualization?
**Answer**: **Three.js**, an open-source JavaScript WebGL library for rendering 3D graphics inside the browser canvas.

### Q46: How are 3D nodes positioned in space?
**Answer**: $X$-axis coordinate is derived from the topological level ($ES$), $Y$-axis spreads nodes vertically, and $Z$-axis adds depth variance.

### Q47: How are Critical Path nodes visually highlighted in 3D?
**Answer**: Critical nodes ($Float = 0$) are rendered with emissive neon red materials and rotating animated pulse rings (`RingGeometry`).

### Q48: What software development lifecycle (SDLC) model did you follow?
**Answer**: **Agile / Iterative Development Model**, building the system in modular phases (Requirements $\rightarrow$ Architecture $\rightarrow$ DB $\rightarrow$ UI $\rightarrow$ DSA Engine $\rightarrow$ QA).

### Q49: What is Unit Testing vs. Integration Testing?
**Answer**:
- **Unit Testing**: Testing individual classes in isolation (`KahnTopologicalSorterTest`).
- **Integration Testing**: Testing communication between components (Servlet $\rightarrow$ DAO $\rightarrow$ MySQL).

### Q50: How would you scale this system for 100,000+ tasks?
**Answer**:
1. Implement Graph partitioning.
2. Use Redis for in-memory graph caching.
3. Asynchronous job queues (Celery / RabbitMQ) for background CPM calculation.
