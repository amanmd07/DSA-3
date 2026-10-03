-- ============================================================================
-- Project Scheduling System using Graph Algorithms (DAG, Topological Sort & CPM)
-- Database Schema Script for MySQL
-- Database Name: project_scheduler_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS `project_scheduler_db`;
USE `project_scheduler_db`;

-- Disable Foreign Key checks for clean re-creation
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `activity_logs`;
DROP TABLE IF EXISTS `reports`;
DROP TABLE IF EXISTS `dependencies`;
DROP TABLE IF EXISTS `tasks`;
DROP TABLE IF EXISTS `projects`;
DROP TABLE IF EXISTS `employees`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- 1. USERS Table (Authentication & System Roles)
-- ----------------------------------------------------------------------------
CREATE TABLE `users` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `role` ENUM('ADMIN', 'PROJECT_MANAGER', 'EMPLOYEE') NOT NULL DEFAULT 'EMPLOYEE',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 2. EMPLOYEES Table (User Profile & Departmental Info)
-- ----------------------------------------------------------------------------
CREATE TABLE `employees` (
    `employee_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `department` VARCHAR(100) NOT NULL,
    `designation` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20),
    CONSTRAINT `fk_employees_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 3. PROJECTS Table (Project Containers)
-- ----------------------------------------------------------------------------
CREATE TABLE `projects` (
    `project_id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(150) NOT NULL,
    `description` TEXT,
    `start_date` DATE NOT NULL,
    `target_end_date` DATE NOT NULL,
    `created_by` INT NOT NULL,
    `status` ENUM('PLANNING', 'ACTIVE', 'COMPLETED', 'ON_HOLD') DEFAULT 'PLANNING',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_projects_created_by` FOREIGN KEY (`created_by`) 
        REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 4. TASKS Table (Nodes in DAG & CPM Schedule Metrics)
-- ----------------------------------------------------------------------------
CREATE TABLE `tasks` (
    `task_id` INT AUTO_INCREMENT PRIMARY KEY,
    `project_id` INT NOT NULL,
    `task_name` VARCHAR(150) NOT NULL,
    `description` TEXT,
    `duration_days` INT NOT NULL DEFAULT 1,
    `assigned_to` INT DEFAULT NULL,
    `es` INT DEFAULT 0 COMMENT 'Earliest Start Time',
    `ef` INT DEFAULT 0 COMMENT 'Earliest Finish Time',
    `ls` INT DEFAULT 0 COMMENT 'Latest Start Time',
    `lf` INT DEFAULT 0 COMMENT 'Latest Finish Time',
    `float_time` INT DEFAULT 0 COMMENT 'Total Float / Slack Time (LS - ES)',
    `is_critical` TINYINT(1) DEFAULT 0 COMMENT '1 if Float == 0',
    `status` ENUM('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED') DEFAULT 'NOT_STARTED',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_tasks_project` FOREIGN KEY (`project_id`) 
        REFERENCES `projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_tasks_assigned_to` FOREIGN KEY (`assigned_to`) 
        REFERENCES `employees` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 5. DEPENDENCIES Table (Directed Edges in DAG: parent_task -> child_task)
-- ----------------------------------------------------------------------------
CREATE TABLE `dependencies` (
    `dependency_id` INT AUTO_INCREMENT PRIMARY KEY,
    `project_id` INT NOT NULL,
    `parent_task_id` INT NOT NULL COMMENT 'Prerequisite Task (Must finish first)',
    `child_task_id` INT NOT NULL COMMENT 'Dependent Task (Starts after parent)',
    CONSTRAINT `fk_dep_project` FOREIGN KEY (`project_id`) 
        REFERENCES `projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_dep_parent` FOREIGN KEY (`parent_task_id`) 
        REFERENCES `tasks` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_dep_child` FOREIGN KEY (`child_task_id`) 
        REFERENCES `tasks` (`task_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `unique_dependency_pair` UNIQUE (`parent_task_id`, `child_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 6. REPORTS Table (Generated Schedule Summary Artifacts)
-- ----------------------------------------------------------------------------
CREATE TABLE `reports` (
    `report_id` INT AUTO_INCREMENT PRIMARY KEY,
    `project_id` INT NOT NULL,
    `report_type` VARCHAR(50) NOT NULL DEFAULT 'CPM_SCHEDULE',
    `file_path` VARCHAR(255) DEFAULT NULL,
    `generated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_reports_project` FOREIGN KEY (`project_id`) 
        REFERENCES `projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 7. ACTIVITY_LOGS Table (Audit Trail)
-- ----------------------------------------------------------------------------
CREATE TABLE `activity_logs` (
    `log_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `action` VARCHAR(100) NOT NULL,
    `details` TEXT,
    `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================================
-- SAMPLE DATA INSERTION SCRIPT
-- ============================================================================

-- 1. Insert Users (Pass: 'admin123', 'manager123', 'emp123' hashed with SHA-256 for demo)
INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role`) VALUES
(1, 'admin', 'admin@projectscheduler.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'ADMIN'),
(2, 'manager1', 'sarah.manager@projectscheduler.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'PROJECT_MANAGER'),
(3, 'dev_john', 'john.doe@company.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'EMPLOYEE'),
(4, 'dev_alice', 'alice.smith@company.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'EMPLOYEE'),
(5, 'tester_bob', 'bob.jones@company.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'EMPLOYEE');

-- 2. Insert Employees
INSERT INTO `employees` (`employee_id`, `user_id`, `full_name`, `department`, `designation`, `phone`) VALUES
(1, 3, 'John Doe', 'Software Engineering', 'Senior Java Developer', '+1-555-0192'),
(2, 4, 'Alice Smith', 'UI/UX Design', 'Lead Frontend Engineer', '+1-555-0143'),
(3, 5, 'Bob Jones', 'Quality Assurance', 'QA Automation Engineer', '+1-555-0188');

-- 3. Insert Sample Project
INSERT INTO `projects` (`project_id`, `title`, `description`, `start_date`, `target_end_date`, `created_by`, `status`) VALUES
(1, 'E-Commerce Platform Redesign', 'Enterprise web application overhaul including dynamic graph scheduler and 3D UI.', '2026-08-01', '2026-10-15', 2, 'ACTIVE');

-- 4. Insert Tasks for Project 1 (Sample Software Engineering Workflow)
-- Tasks:
-- T1: Requirement Analysis & Architecture (5 days)
-- T2: Database Schema & Setup (3 days) [Depends on T1]
-- T3: Backend API & Servlet Development (7 days) [Depends on T2]
-- T4: Frontend UI & 3D Visualizer (6 days) [Depends on T1]
-- T5: Integration & CPM Engine Setup (4 days) [Depends on T3, T4]
-- T6: System Testing & QA (4 days) [Depends on T5]
-- T7: Final Deployment & Documentation (2 days) [Depends on T6]

INSERT INTO `tasks` (`task_id`, `project_id`, `task_name`, `description`, `duration_days`, `assigned_to`, `es`, `ef`, `ls`, `lf`, `float_time`, `is_critical`, `status`) VALUES
(101, 1, 'Requirement Analysis & Architecture', 'Finalize system specifications and graph algorithm design', 5, 1, 0, 5, 0, 5, 0, 1, 'COMPLETED'),
(102, 1, 'Database Schema & Setup', 'Create MySQL tables, indexes, and JDBC connection pool', 3, 1, 5, 8, 5, 8, 0, 1, 'IN_PROGRESS'),
(103, 1, 'Backend API & Servlet Development', 'Implement JSP, Servlets, and Graph DAO controllers', 7, 1, 8, 15, 8, 15, 0, 1, 'NOT_STARTED'),
(104, 1, 'Frontend UI & 3D Visualizer', 'Design Bootstrap 5 templates and Three.js 3D WebGL graph', 6, 2, 5, 11, 9, 15, 4, 0, 'IN_PROGRESS'),
(105, 1, 'Integration & CPM Engine Setup', 'Connect Servlets with Kahn Topological Sort & CPM engine', 4, 1, 15, 19, 15, 19, 0, 1, 'NOT_STARTED'),
(106, 1, 'System Testing & QA', 'Perform unit, integration, and performance load tests', 4, 3, 19, 23, 19, 23, 0, 1, 'NOT_STARTED'),
(107, 1, 'Final Deployment & Documentation', 'Deploy WAR to Tomcat server and generate user manual', 2, 1, 23, 25, 23, 25, 0, 1, 'NOT_STARTED');

-- 5. Insert Dependencies (Directed Edges in DAG)
-- T101 -> T102
-- T101 -> T104
-- T102 -> T103
-- T103 -> T105
-- T104 -> T105
-- T105 -> T106
-- T106 -> T107

INSERT INTO `dependencies` (`dependency_id`, `project_id`, `parent_task_id`, `child_task_id`) VALUES
(1, 1, 101, 102),
(2, 1, 101, 104),
(3, 1, 102, 103),
(4, 1, 103, 105),
(5, 1, 104, 105),
(6, 1, 105, 106),
(7, 1, 106, 107);

-- 6. Insert Initial Report Entry
INSERT INTO `reports` (`report_id`, `project_id`, `report_type`, `file_path`) VALUES
(1, 1, 'CPM_SCHEDULE_SUMMARY', '/reports/project_1_cpm_schedule.pdf');

-- 7. Insert Activity Log Entries
INSERT INTO `activity_logs` (`log_id`, `user_id`, `action`, `details`) VALUES
(1, 2, 'PROJECT_CREATED', 'Project [E-Commerce Platform Redesign] created by sarah.manager'),
(2, 2, 'SCHEDULE_GENERATED', 'Kahn Topological Sort & CPM Engine calculated critical path duration = 25 days.');
