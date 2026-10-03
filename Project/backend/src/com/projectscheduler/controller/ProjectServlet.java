package com.projectscheduler.controller;

import com.projectscheduler.dao.ProjectDAO;
import com.projectscheduler.model.Project;
import com.projectscheduler.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/project")
public class ProjectServlet extends HttpServlet {

    private ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("CREATE".equals(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date targetEndDate = Date.valueOf(request.getParameter("targetEndDate"));

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int createdBy = (user != null) ? user.getUserId() : 1;

            Project p = new Project(0, title, description, startDate, targetEndDate, createdBy, "PLANNING");
            projectDAO.createProject(p);
        }
        response.sendRedirect("projects.jsp");
    }
}
