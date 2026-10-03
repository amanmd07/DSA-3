package com.projectscheduler.algo;

import com.projectscheduler.model.Task;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Unit Test Suite for Critical Path Method (CPM) Forward/Backward Pass Engine.
 */
public class CPMEngineTest {

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("Running Unit Tests for CPMEngine...");
        System.out.println("==================================================");

        testCPMCalculation();
    }

    public static void testCPMCalculation() {
        System.out.print("[TEST 3] CPM Forward/Backward Pass & Critical Path Detection: ");
        try {
            Task t1 = new Task(1, 1, "T1", "Task 1", 5);
            Task t2 = new Task(2, 1, "T2", "Task 2", 3);
            Task t3 = new Task(3, 1, "T3", "Task 3", 2);

            List<Task> tasks = new ArrayList<>(Arrays.asList(t1, t2, t3));
            Graph g = new Graph(Arrays.asList(1, 2, 3));
            g.addEdge(1, 2);
            g.addEdge(2, 3);

            CPMEngine cpm = new CPMEngine();
            cpm.calculateCPM(tasks, g);

            // T1: ES=0, EF=5, LS=0, LF=5, Float=0, Critical=true
            // T2: ES=5, EF=8, LS=5, LF=8, Float=0, Critical=true
            // T3: ES=8, EF=10, LS=8, LF=10, Float=0, Critical=true
            if (t1.isCritical() && t2.isCritical() && t3.isCritical() && t3.getEf() == 10) {
                System.out.println("PASSED! Critical Duration = 10 days.");
            } else {
                System.out.println("FAILED! Calculated Duration: " + t3.getEf());
            }
        } catch (Exception e) {
            System.out.println("FAILED with Exception: " + e.getMessage());
        }
    }
}
