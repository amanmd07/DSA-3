package com.projectscheduler.service;

import com.projectscheduler.algo.*;
import com.projectscheduler.dao.DependencyDAO;
import com.projectscheduler.dao.TaskDAO;
import com.projectscheduler.model.Dependency;
import com.projectscheduler.model.Task;

import java.util.*;

public class ScheduleService {

    private TaskDAO taskDAO = new TaskDAO();
    private DependencyDAO dependencyDAO = new DependencyDAO();
    private KahnTopologicalSorter sorter = new KahnTopologicalSorter();
    private CPMEngine cpmEngine = new CPMEngine();

    public List<Task> generateScheduleAndCriticalPath(int projectId) throws KahnTopologicalSorter.CircularDependencyException {
        List<Task> tasks = taskDAO.getTasksByProject(projectId);
        List<Dependency> dependencies = dependencyDAO.getDependenciesByProject(projectId);

        if (tasks.isEmpty()) return tasks;

        // 1. Build Node ID List & Graph
        List<Integer> nodeIds = new ArrayList<>();
        Map<Integer, Task> taskMap = new HashMap<>();
        for (Task t : tasks) {
            nodeIds.add(t.getTaskId());
            taskMap.put(t.getTaskId(), t);
        }

        Graph graph = new Graph(nodeIds);
        for (Dependency dep : dependencies) {
            graph.addEdge(dep.getParentTaskId(), dep.getChildTaskId());
        }

        // 2. Kahn's Topological Sort
        List<Integer> topologicalNodeIds = sorter.sort(graph);

        List<Task> topologicalTasks = new ArrayList<>();
        for (int id : topologicalNodeIds) {
            topologicalTasks.add(taskMap.get(id));
        }

        // 3. CPM Calculation
        cpmEngine.calculateCPM(topologicalTasks, graph);

        // 4. Save computed metrics to Database
        taskDAO.updateCPMMetrics(topologicalTasks);

        return topologicalTasks;
    }
}
