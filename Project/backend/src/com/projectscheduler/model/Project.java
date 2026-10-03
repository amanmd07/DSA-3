package com.projectscheduler.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Project {
    private int projectId;
    private String title;
    private String description;
    private Date startDate;
    private Date targetEndDate;
    private int createdBy;
    private String status; // PLANNING, ACTIVE, COMPLETED, ON_HOLD
    private Timestamp createdAt;

    public Project() {}

    public Project(int projectId, String title, String description, Date startDate, Date targetEndDate, int createdBy, String status) {
        this.projectId = projectId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.targetEndDate = targetEndDate;
        this.createdBy = createdBy;
        this.status = status;
    }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getTargetEndDate() { return targetEndDate; }
    public void setTargetEndDate(Date targetEndDate) { this.targetEndDate = targetEndDate; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
