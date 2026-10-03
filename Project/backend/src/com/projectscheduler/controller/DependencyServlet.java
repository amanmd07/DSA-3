package com.projectscheduler.controller;

import com.projectscheduler.dao.DependencyDAO;
import com.projectscheduler.model.Dependency;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dependency")
public class DependencyServlet extends HttpServlet {

    private DependencyDAO dependencyDAO = new DependencyDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("CREATE".equals(action)) {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            int parentTaskId = Integer.parseInt(request.getParameter("parentTaskId"));
            int childTaskId = Integer.parseInt(request.getParameter("childTaskId"));

            if (parentTaskId != childTaskId) {
                Dependency dep = new Dependency(0, projectId, parentTaskId, childTaskId);
                dependencyDAO.addDependency(dep);
            }
        }
        response.sendRedirect("dependencies.jsp");
    }
}
