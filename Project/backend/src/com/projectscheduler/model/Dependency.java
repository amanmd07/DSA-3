package com.projectscheduler.model;

public class Dependency {
    private int dependencyId;
    private int projectId;
    private int parentTaskId;
    private int childTaskId;

    public Dependency() {}

    public Dependency(int dependencyId, int projectId, int parentTaskId, int childTaskId) {
        this.dependencyId = dependencyId;
        this.projectId = projectId;
        this.parentTaskId = parentTaskId;
        this.childTaskId = childTaskId;
    }

    public int getDependencyId() { return dependencyId; }
    public void setDependencyId(int dependencyId) { this.dependencyId = dependencyId; }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public int getParentTaskId() { return parentTaskId; }
    public void setParentTaskId(int parentTaskId) { this.parentTaskId = parentTaskId; }

    public int getChildTaskId() { return childTaskId; }
    public void setChildTaskId(int childTaskId) { this.childTaskId = childTaskId; }
}
