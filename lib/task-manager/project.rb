
class TM::Project

  attr_accessor :project_id, :name

  def initialize(project_id, name)
    @name = name
    @project_id = project_id
  end

  def self.add_project(name)
    TM.orm.add_project(name)
  end

  def self.list_projects
    TM.orm.list_projects
  end

  def self.list_tasks(target_project_id)
    TM.orm.list_tasks.select { |t| t.project_id == target_project_id.to_s }
  end

  def add_task(description, priority, project_id, complete=false)
    TM.orm.add_task(description, priority, project_id, complete)
  end

  def self.complete_task(project_id, task_id)
    TM.orm.complete_task_orm(project_id, task_id)
  end

  def self.select_project(id)
    TM::Project.list_projects.select { |p| p.project_id == id }
  end

  def self.list_complete(target_project_id)
    tasks = TM::Project.list_tasks(target_project_id)
    complete_tasks_arr = tasks.select { |t| t.complete == "t" }
    complete_tasks_arr.sort_by! { |task| task.creation_time }
    complete_tasks_arr.reverse!
  end

  # Add sort by creation date if same priority
  def self.list_incomplete(target_project_id)
    tasks = TM::Project.list_tasks(target_project_id)
    incomplete_tasks_arr = tasks.select { |t| t.complete == "f" }
    incomplete_tasks_arr.sort_by! { |task| task.priority }
    incomplete_tasks_arr.reverse!
  end

end
