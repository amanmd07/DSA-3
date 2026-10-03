package com.projectscheduler.algo;

import com.projectscheduler.model.Task;

import java.util.*;

public class CPMEngine {

    /**
     * Executes Critical Path Method (CPM) Forward Pass & Backward Pass.
     * Time Complexity: O(V + E)
     * Space Complexity: O(V)
     */
    public void calculateCPM(List<Task> tasksInTopologicalOrder, Graph graph) {
        Map<Integer, Task> taskMap = new HashMap<>();
        for (Task t : tasksInTopologicalOrder) {
            taskMap.put(t.getTaskId(), t);
        }

        // 1. FORWARD PASS: Calculate ES (Earliest Start) & EF (Earliest Finish)
        int projectDuration = 0;
        for (Task u : tasksInTopologicalOrder) {
            int uId = u.getTaskId();
            int maxPrevEF = 0;

            // ES[u] = max(EF[p]) for all predecessors p
            List<Integer> predecessors = graph.getReverseAdjList().getOrDefault(uId, Collections.emptyList());
            for (int pId : predecessors) {
                Task p = taskMap.get(pId);
                if (p != null) {
                    maxPrevEF = Math.max(maxPrevEF, p.getEf());
                }
            }

            u.setEs(maxPrevEF);
            u.setEf(maxPrevEF + u.getDurationDays());
            projectDuration = Math.max(projectDuration, u.getEf());
        }

        // 2. BACKWARD PASS: Calculate LF (Latest Finish) & LS (Latest Start)
        // Process in Reverse Topological Order
        List<Task> reverseOrder = new ArrayList<>(tasksInTopologicalOrder);
        Collections.reverse(reverseOrder);

        for (Task u : reverseOrder) {
            int uId = u.getTaskId();
            List<Integer> successors = graph.getAdjList().getOrDefault(uId, Collections.emptyList());

            int minNextLS = projectDuration;
            if (!successors.isEmpty()) {
                minNextLS = Integer.MAX_VALUE;
                for (int sId : successors) {
                    Task s = taskMap.get(sId);
                    if (s != null) {
                        minNextLS = Math.min(minNextLS, s.getLs());
                    }
                }
            }

            u.setLf(minNextLS);
            u.setLs(minNextLS - u.getDurationDays());

            // 3. SLACK / FLOAT & CRITICAL PATH DETERMINATION
            int floatTime = u.getLs() - u.getEs();
            u.setFloatTime(floatTime);
            u.setCritical(floatTime == 0);
        }
    }
}
