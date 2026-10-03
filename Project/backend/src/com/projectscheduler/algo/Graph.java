package com.projectscheduler.algo;

import java.util.*;

/**
 * Directed Acyclic Graph (DAG) using Adjacency List Representation.
 */
public class Graph {
    private final Map<Integer, List<Integer>> adjList = new HashMap<>();
    private final Map<Integer, Integer> inDegree = new HashMap<>();
    private final Map<Integer, List<Integer>> reverseAdjList = new HashMap<>(); // For CPM Backward Pass

    public Graph(List<Integer> nodeIds) {
        for (int id : nodeIds) {
            adjList.put(id, new ArrayList<>());
            reverseAdjList.put(id, new ArrayList<>());
            inDegree.put(id, 0);
        }
    }

    public void addEdge(int u, int v) {
        if (adjList.containsKey(u) && adjList.containsKey(v)) {
            adjList.get(u).add(v);
            reverseAdjList.get(v).add(u);
            inDegree.put(v, inDegree.get(v) + 1);
        }
    }

    public Map<Integer, List<Integer>> getAdjList() { return adjList; }
    public Map<Integer, List<Integer>> getReverseAdjList() { return reverseAdjList; }
    public Map<Integer, Integer> getInDegree() { return inDegree; }
    public Set<Integer> getAllNodes() { return adjList.keySet(); }
}
