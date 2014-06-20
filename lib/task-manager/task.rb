
class TM::Task
  attr_reader :description, :priority, :task_id, :project_id
  attr_accessor :complete, :creation_time

  def initialize(task_id, description, priority, complete=false, creation_time, project_id)
    @task_id = task_id
    @description = description
    @priority = priority
    @complete = complete
    @creation_time = Time.parse(creation_time)
    @project_id
  end

end
