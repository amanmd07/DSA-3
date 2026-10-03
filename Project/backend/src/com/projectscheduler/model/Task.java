package com.projectscheduler.model;

public class Task {
    private int taskId;
    private int projectId;
    private String taskName;
    private String description;
    private int durationDays;
    private Integer assignedTo;
    
    // Algorithmic CPM Fields
    private int es; // Earliest Start
    private int ef; // Earliest Finish
    private int ls; // Latest Start
    private int lf; // Latest Finish
    private int floatTime; // Total Float / Slack Time (LS - ES)
    private boolean isCritical;
    
    private String status; // NOT_STARTED, IN_PROGRESS, COMPLETED

    public Task() {}

    public Task(int taskId, int projectId, String taskName, String description, int durationDays) {
        this.taskId = taskId;
        this.projectId = projectId;
        this.taskName = taskName;
        this.description = description;
        this.durationDays = durationDays;
    }

    public int getTaskId() { return taskId; }
    public void setTaskId(int taskId) { this.taskId = taskId; }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getTaskName() { return taskName; }
    public void setTaskName(String taskName) { this.taskName = taskName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public Integer getAssignedTo() { return assignedTo; }
    public void setAssignedTo(Integer assignedTo) { this.assignedTo = assignedTo; }

    public int getEs() { return es; }
    public void setEs(int es) { this.es = es; }

    public int getEf() { return ef; }
    public void setEf(int ef) { this.ef = ef; }

    public int getLs() { return ls; }
    public void setLs(int ls) { this.ls = ls; }

    public int getLf() { return lf; }
    public void setLf(int lf) { this.lf = lf; }

    public int getFloatTime() { return floatTime; }
    public void setFloatTime(int floatTime) { this.floatTime = floatTime; }

    public boolean isCritical() { return isCritical; }
    public void setCritical(boolean critical) { isCritical = critical; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
