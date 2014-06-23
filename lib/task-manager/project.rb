
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

  def self.complete_task(proj_id_find, task_id_find)
    @@project_list.each do |proj|
      if proj.project_id == proj_id_find
        proj.tasks.each do |task|
          if task.task_id == task_id_find
            task.complete = true
          end
        end
      end
    end

    # project = TM::Project.list_projects.select { |proj| proj.project_id == proj_id_find }
    # task = project[0].tasks.select { |task| task.task_id == task_id_find }
    # task[0].complete = true
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
