package com.projectscheduler.algo;

import java.util.Arrays;
import java.util.List;

/**
 * Unit Test Suite for Kahn's Topological Sorting Algorithm & Cycle Detector.
 */
public class KahnTopologicalSorterTest {

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("Running Unit Tests for KahnTopologicalSorter...");
        System.out.println("==================================================");

        testValidDAG();
        testCircularDependencyCycle();

        System.out.println("All Unit Tests Executed Successfully!");
    }

    public static void testValidDAG() {
        System.out.print("[TEST 1] Valid DAG Topological Ordering: ");
        try {
            List<Integer> nodeIds = Arrays.asList(1, 2, 3, 4);
            Graph g = new Graph(nodeIds);
            g.addEdge(1, 2);
            g.addEdge(2, 3);
            g.addEdge(1, 4);
            g.addEdge(3, 4);

            KahnTopologicalSorter sorter = new KahnTopologicalSorter();
            List<Integer> order = sorter.sort(g);

            if (order.size() == 4 && order.indexOf(1) < order.indexOf(2) && order.indexOf(2) < order.indexOf(3)) {
                System.out.println("PASSED! Order: " + order);
            } else {
                System.out.println("FAILED! Invalid order: " + order);
            }
        } catch (IllegalArgumentException | IllegalStateException | KahnTopologicalSorter.CircularDependencyException e) {
            System.out.println("FAILED with Exception: " + e.getMessage());
        }
    }

    public static void testCircularDependencyCycle() {
        System.out.print("[TEST 2] Circular Dependency Cycle Detection: ");
        try {
            List<Integer> nodeIds = Arrays.asList(1, 2, 3);
            Graph g = new Graph(nodeIds);
            g.addEdge(1, 2);
            g.addEdge(2, 3);
            g.addEdge(3, 1); // Creating Cycle 1 -> 2 -> 3 -> 1

            KahnTopologicalSorter sorter = new KahnTopologicalSorter();
            sorter.sort(g);
            System.out.println("FAILED! Cycle was not detected!");
        } catch (KahnTopologicalSorter.CircularDependencyException e) {
            System.out.println("PASSED! Caught expected Exception: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("FAILED with unexpected Exception: " + e.getMessage());
        }
    }
}
