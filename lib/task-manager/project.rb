
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

  def add_task(description, priority, project_id)
    TM.orm.add_task(description, priority, project_id)
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

  def list_complete
    @completed_tasks = @tasks.select { |task| task.complete == true }
    @completed_tasks.sort_by! { |task| task.creation_time }
  end

  def list_incomplete
    @incompleted_tasks = @tasks.select { |task| task.complete == false }
    @incompleted_tasks.sort_by! { |task| task.priority }
    @incompleted_tasks.reverse!
  end

end
