package com.projectscheduler.algo;

import java.util.*;

public class KahnTopologicalSorter {

    public static class CircularDependencyException extends Exception {
        public CircularDependencyException(String msg) { super(msg); }
    }

    /**
     * Executes Kahn's Algorithm for Topological Sorting & Cycle Detection.
     * Time Complexity: O(V + E)
     * Space Complexity: O(V)
     */
    public List<Integer> sort(Graph graph) throws CircularDependencyException {
        Map<Integer, Integer> inDegreeCopy = new HashMap<>(graph.getInDegree());
        Queue<Integer> queue = new LinkedList<>();
        List<Integer> topologicalOrder = new ArrayList<>();

        // Enqueue all nodes with In-Degree = 0
        for (Map.Entry<Integer, Integer> entry : inDegreeCopy.entrySet()) {
            if (entry.getValue() == 0) {
                queue.add(entry.getKey());
            }
        }

        while (!queue.isEmpty()) {
            int u = queue.poll();
            topologicalOrder.add(u);

            for (int v : graph.getAdjList().getOrDefault(u, Collections.emptyList())) {
                inDegreeCopy.put(v, inDegreeCopy.get(v) - 1);
                if (inDegreeCopy.get(v) == 0) {
                    queue.add(v);
                }
            }
        }

        // Cycle Check
        if (topologicalOrder.size() != graph.getAllNodes().size()) {
            throw new CircularDependencyException("Circular Dependency Cycle Detected! The network is not a valid DAG.");
        }

        return topologicalOrder;
    }
}
