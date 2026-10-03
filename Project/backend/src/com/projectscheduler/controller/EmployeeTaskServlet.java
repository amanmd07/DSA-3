package com.projectscheduler.controller;

import com.projectscheduler.config.DBConnectionPool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/employeeTask")
public class EmployeeTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("UPDATE_STATUS".equals(action)) {
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            String status = request.getParameter("status"); // NOT_STARTED, IN_PROGRESS, COMPLETED

            String sql = "UPDATE tasks SET status = ? WHERE task_id = ?";
            try (Connection conn = DBConnectionPool.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, status);
                pstmt.setInt(2, taskId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("profile.jsp");
    }
}
