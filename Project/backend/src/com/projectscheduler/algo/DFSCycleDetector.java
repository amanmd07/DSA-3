package com.projectscheduler.algo;

import java.util.*;

public class DFSCycleDetector {

    /**
     * Detects cycle in a Directed Graph using Depth First Search (DFS).
     * Time Complexity: O(V + E)
     * Space Complexity: O(V) for recursion stack and visited sets
     */
    public boolean hasCycle(Graph graph) {
        Set<Integer> visited = new HashSet<>();
        Set<Integer> recStack = new HashSet<>();

        for (int node : graph.getAllNodes()) {
            if (!visited.contains(node)) {
                if (dfsCheck(node, graph, visited, recStack)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean dfsCheck(int node, Graph graph, Set<Integer> visited, Set<Integer> recStack) {
        visited.add(node);
        recStack.add(node);

        for (int neighbor : graph.getAdjList().getOrDefault(node, Collections.emptyList())) {
            if (!visited.contains(neighbor)) {
                if (dfsCheck(neighbor, graph, visited, recStack)) return true;
            } else if (recStack.contains(neighbor)) {
                return true; // Cycle detected
            }
        }

        recStack.remove(node);
        return false;
    }
}
