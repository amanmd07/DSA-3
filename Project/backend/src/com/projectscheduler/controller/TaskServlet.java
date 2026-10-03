package com.projectscheduler.controller;

import com.projectscheduler.dao.TaskDAO;
import com.projectscheduler.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/task")
public class TaskServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("CREATE".equals(action)) {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            String taskName = request.getParameter("taskName");
            String description = request.getParameter("description");
            int duration = Integer.parseInt(request.getParameter("duration"));
            String assignedToRaw = request.getParameter("assignedTo");
            Integer assignedTo = (assignedToRaw != null && !assignedToRaw.isEmpty()) ? Integer.parseInt(assignedToRaw) : null;

            Task task = new Task(0, projectId, taskName, description, duration);
            task.setAssignedTo(assignedTo);
            taskDAO.createTask(task);
        }
        response.sendRedirect("tasks.jsp");
    }
}
