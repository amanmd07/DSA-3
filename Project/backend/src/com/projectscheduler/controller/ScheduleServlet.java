package com.projectscheduler.controller;

import com.projectscheduler.algo.KahnTopologicalSorter;
import com.projectscheduler.model.Task;
import com.projectscheduler.service.ScheduleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {

    private ScheduleService scheduleService = new ScheduleService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectIdRaw = request.getParameter("projectId");
        int projectId = (projectIdRaw != null && !projectIdRaw.isEmpty()) ? Integer.parseInt(projectIdRaw) : 1;

        try {
            List<Task> scheduledTasks = scheduleService.generateScheduleAndCriticalPath(projectId);
            request.setAttribute("scheduledTasks", scheduledTasks);
            request.setAttribute("successMessage", "Topological Schedule and Critical Path recalculated successfully!");
            request.getRequestDispatcher("scheduler.jsp").forward(request, response);
        } catch (KahnTopologicalSorter.CircularDependencyException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("scheduler.jsp").forward(request, response);
        }
    }
}
