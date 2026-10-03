package com.projectscheduler.dao;

import com.projectscheduler.config.DBConnectionPool;
import com.projectscheduler.model.Project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public boolean createProject(Project project) {
        String sql = "INSERT INTO projects (title, description, start_date, target_end_date, created_by, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, project.getTitle());
            pstmt.setString(2, project.getDescription());
            pstmt.setDate(3, project.getStartDate());
            pstmt.setDate(4, project.getTargetEndDate());
            pstmt.setInt(5, project.getCreatedBy());
            pstmt.setString(6, project.getStatus());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        project.setProjectId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Project> getAllProjects() {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT * FROM projects ORDER BY created_at DESC";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Project(
                    rs.getInt("project_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getDate("start_date"),
                    rs.getDate("target_end_date"),
                    rs.getInt("created_by"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
