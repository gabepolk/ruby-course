require 'time'

class TM::Task
  attr_reader :task_id, :description, :priority, :project_id
  attr_accessor :complete, :creation_time

  # reconcile argument differences between client add task and Task.add_task

  def initialize(task_id, description, priority, complete=false, creation_time, project_id)
    @task_id = task_id
    @description = description
    @priority = priority
    @complete = complete
    @creation_time = Time.parse(creation_time) if creation_time
    @project_id = project_id
  end

end
