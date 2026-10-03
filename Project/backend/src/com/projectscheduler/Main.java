package com.projectscheduler;

import com.projectscheduler.algo.*;
import com.projectscheduler.model.Task;

import java.util.*;

/**
 * Main Entry Point for Project Scheduling System Demonstration.
 */
public class Main {

    public static void main(String[] args) {
        System.out.println("===============================================================================");
        System.out.println("   PROJECT SCHEDULING SYSTEM (DAG, Kahn's Algo, DFS Cycle, CPM Engine)   ");
        System.out.println("===============================================================================\n");

        // 1. Setup Sample Project Tasks
        System.out.println("--- 1. Creating Sample Tasks ---");
        List<Task> tasks = new ArrayList<>();
        tasks.add(new Task(1, 101, "T1", "Requirements Gathering & Architecture", 5));
        tasks.add(new Task(2, 101, "T2", "Database Schema & Entity Models", 4));
        tasks.add(new Task(3, 101, "T3", "Backend Algorithms & Servlets", 6));
        tasks.add(new Task(4, 101, "T4", "UI/UX Glassmorphism Design", 3));
        tasks.add(new Task(5, 101, "T5", "3D WebGL Three.js Visualizer", 5));
        tasks.add(new Task(6, 101, "T6", "System Integration & Testing", 4));

        for (Task t : tasks) {
            System.out.printf("  Task ID: %d | Code: %-2s | Name: %-40s | Duration: %d days%n",
                    t.getTaskId(), "T" + t.getTaskId(), t.getDescription(), t.getDurationDays());
        }

        // 2. Build DAG Edges
        System.out.println("\n--- 2. Building Project Dependency Graph (DAG) ---");
        List<Integer> nodeIds = Arrays.asList(1, 2, 3, 4, 5, 6);
        Graph graph = new Graph(nodeIds);

        // Precedence relations:
        // T1 -> T2, T1 -> T4
        // T2 -> T3
        // T4 -> T5
        // T3 -> T6, T5 -> T6
        graph.addEdge(1, 2);
        graph.addEdge(1, 4);
        graph.addEdge(2, 3);
        graph.addEdge(4, 5);
        graph.addEdge(3, 6);
        graph.addEdge(5, 6);

        System.out.println("  Edges added:");
        System.out.println("  - T1 -> T2, T1 -> T4");
        System.out.println("  - T2 -> T3");
        System.out.println("  - T4 -> T5");
        System.out.println("  - T3 -> T6, T5 -> T6");

        // 3. DFS Cycle Detection
        System.out.println("\n--- 3. Running DFS Cycle Detection ---");
        DFSCycleDetector dfsDetector = new DFSCycleDetector();
        boolean hasCycle = dfsDetector.hasCycle(graph);
        System.out.println("  DFS Cycle Detected: " + hasCycle + " (Graph is valid DAG)");

        // 4. Kahn's Topological Sorter
        System.out.println("\n--- 4. Running Kahn's Topological Sorting ---");
        KahnTopologicalSorter sorter = new KahnTopologicalSorter();
        List<Integer> topologicalOrderIds = Collections.emptyList();
        try {
            topologicalOrderIds = sorter.sort(graph);
            System.out.println("  Topological Order (Execution Sequence): " + topologicalOrderIds);
        } catch (KahnTopologicalSorter.CircularDependencyException e) {
            System.err.println("  Cycle Exception: " + e.getMessage());
            return;
        }

        // Arrange Task objects in topological order for CPM calculation
        Map<Integer, Task> taskMap = new HashMap<>();
        for (Task t : tasks) {
            taskMap.put(t.getTaskId(), t);
        }
        List<Task> sortedTasks = new ArrayList<>();
        for (int id : topologicalOrderIds) {
            sortedTasks.add(taskMap.get(id));
        }

        // 5. Critical Path Method (CPM) Forward & Backward Pass
        System.out.println("\n--- 5. Executing CPM (Critical Path Method) Engine ---");
        CPMEngine cpmEngine = new CPMEngine();
        cpmEngine.calculateCPM(sortedTasks, graph);

        System.out.println("\n-----------------------------------------------------------------------------------------");
        System.out.printf("%-6s | %-35s | %-8s | %-4s | %-4s | %-4s | %-4s | %-5s | %-10s%n",
                "ID", "Task Name", "Duration", "ES", "EF", "LS", "LF", "Float", "Critical?");
        System.out.println("-----------------------------------------------------------------------------------------");
        int projectTotalDuration = 0;
        List<String> criticalPathNames = new ArrayList<>();

        for (Task t : sortedTasks) {
            System.out.printf("%-6d | %-35s | %-8d | %-4d | %-4d | %-4d | %-4d | %-5d | %-10s%n",
                    t.getTaskId(), t.getTaskName(), t.getDurationDays(),
                    t.getEs(), t.getEf(), t.getLs(), t.getLf(),
                    t.getFloatTime(), t.isCritical() ? "[CRITICAL]" : "  -");
            if (t.getEf() > projectTotalDuration) {
                projectTotalDuration = t.getEf();
            }
            if (t.isCritical()) {
                criticalPathNames.add("T" + t.getTaskId() + " (" + t.getTaskName() + ")");
            }
        }
        System.out.println("-----------------------------------------------------------------------------------------");
        System.out.println("  TOTAL PROJECT COMPLETION TIME: " + projectTotalDuration + " days");
        System.out.println("  CRITICAL PATH: " + String.join(" -> ", criticalPathNames));
        System.out.println("===============================================================================");
    }
}
