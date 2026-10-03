package com.projectscheduler.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        int projectId = Integer.parseInt(request.getParameter("projectId") != null ? request.getParameter("projectId") : "1");

        if ("PDF".equalsIgnoreCase(type)) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"CPM_Schedule_Report_Project_" + projectId + ".pdf\"");
            
            // Generate sample PDF byte array / summary text
            byte[] dummyPdfContent = ("%PDF-1.4\n1 0 obj\n<< /Title (CPM Schedule Report) /Author (GraphScheduler 3D) >>\nendobj\n").getBytes();
            response.getOutputStream().write(dummyPdfContent);
        } else if ("EXCEL".equalsIgnoreCase(type)) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=\"Task_Matrix_Project_" + projectId + ".csv\"");

            PrintWriter out = response.getWriter();
            out.println("Task ID,Task Name,Duration (Days),ES,EF,LS,LF,Float (Slack),Is Critical");
            out.println("101,Requirement Analysis & Arch,5,0,5,0,5,0,YES");
            out.println("102,Database Schema & Setup,3,5,8,5,8,0,YES");
            out.println("103,Backend API & Servlets,7,8,15,8,15,0,YES");
            out.println("104,Frontend UI & 3D Visualizer,6,5,11,9,15,4,NO");
            out.println("105,Integration & CPM Engine,4,15,19,15,19,0,YES");
            out.println("106,System Testing & QA,4,19,23,19,23,0,YES");
            out.println("107,Final Deployment & Docs,2,23,25,23,25,0,YES");
            out.flush();
        } else {
            response.sendRedirect("reports.jsp");
        }
    }
}
