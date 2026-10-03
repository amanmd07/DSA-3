package com.projectscheduler.dao;

import com.projectscheduler.config.DBConnectionPool;
import com.projectscheduler.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public boolean createTask(Task task) {
        String sql = "INSERT INTO tasks (project_id, task_name, description, duration_days, assigned_to) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, task.getProjectId());
            pstmt.setString(2, task.getTaskName());
            pstmt.setString(3, task.getDescription());
            pstmt.setInt(4, task.getDurationDays());
            if (task.getAssignedTo() != null) {
                pstmt.setInt(5, task.getAssignedTo());
            } else {
                pstmt.setNull(5, Types.INTEGER);
            }

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        task.setTaskId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Task> getTasksByProject(int projectId) {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE project_id = ? ORDER BY task_id ASC";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, projectId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Task t = new Task(
                        rs.getInt("task_id"),
                        rs.getInt("project_id"),
                        rs.getString("task_name"),
                        rs.getString("description"),
                        rs.getInt("duration_days")
                    );
                    t.setAssignedTo((Integer) rs.getObject("assigned_to"));
                    t.setEs(rs.getInt("es"));
                    t.setEf(rs.getInt("ef"));
                    t.setLs(rs.getInt("ls"));
                    t.setLf(rs.getInt("lf"));
                    t.setFloatTime(rs.getInt("float_time"));
                    t.setCritical(rs.getBoolean("is_critical"));
                    t.setStatus(rs.getString("status"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateCPMMetrics(List<Task> scheduledTasks) {
        String sql = "UPDATE tasks SET es = ?, ef = ?, ls = ?, lf = ?, float_time = ?, is_critical = ? WHERE task_id = ?";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (Task t : scheduledTasks) {
                pstmt.setInt(1, t.getEs());
                pstmt.setInt(2, t.getEf());
                pstmt.setInt(3, t.getLs());
                pstmt.setInt(4, t.getLf());
                pstmt.setInt(5, t.getFloatTime());
                pstmt.setBoolean(6, t.isCritical());
                pstmt.setInt(7, t.getTaskId());
                pstmt.addBatch();
            }
            pstmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
