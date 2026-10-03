package com.projectscheduler.dao;

import com.projectscheduler.config.DBConnectionPool;
import com.projectscheduler.model.Dependency;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DependencyDAO {

    public boolean addDependency(Dependency dep) {
        String sql = "INSERT INTO dependencies (project_id, parent_task_id, child_task_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, dep.getProjectId());
            pstmt.setInt(2, dep.getParentTaskId());
            pstmt.setInt(3, dep.getChildTaskId());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) dep.setDependencyId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Dependency> getDependenciesByProject(int projectId) {
        List<Dependency> list = new ArrayList<>();
        String sql = "SELECT * FROM dependencies WHERE project_id = ?";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, projectId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Dependency(
                        rs.getInt("dependency_id"),
                        rs.getInt("project_id"),
                        rs.getInt("parent_task_id"),
                        rs.getInt("child_task_id")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
