
require_relative 'lib/task-manager.rb'
require 'pry-debugger'
require 'time'

class TM::TerminalClient

  attr_accessor :input_arr

  def initialize
    @input_arr = nil
  end

  def self.start
    input = gets.chomp
    @input_arr = input.split
    self.options_list(@input_arr[0..1].join(" "))
  end

  def self.options_list(user_response)
    case user_response
    when "help"
      self.help
    when "project list"
      self.list_projects_client
    when "project create"
      self.create_project_client
    when "project show"
      self.show_project_tasks_client
    when "project history"
      self.history_complete_tasks_client
    when "project employees"
      self.show_project_employees_participating_client
    when "project recruit"
      self.project_recruit_employee_client
    when "task create"
      self.create_task_client
    when "task assign"
      self.assign_task_client
    when "task mark"
      self.complete_task_client
    when "emp list"
      self.list_employees_client
    when "emp create"
      self.create_employee_client
    when "emp show"
      self.projects_employee_belongs_client
    when "emp details"
      self.employee_tasks_incomplete_client
    when "emp history"
      self.employee_tasks_completed_client
    when "exit"
      self.exit
    end
  end

  def self.help
    puts "\n"
    puts "Welcome to Project Manager Pro®. What can I do for you today?"
    puts "\nAvailable Commands:"
    puts "  help - Show these commands again"
    puts "  project list - List all projects"
    puts "  project create NAME - Create a new project"
    puts "  project show PID - Show remaining tasks for project PID"
    puts "  project history PID - Show completed tasks for project PID"
    puts "  project employees PID - Show employees participating in this project"
    puts "  project recruit PID EID - Adds employee EID to participate in project PID"
    puts "  task create PID PRIORITY DESC - Add a new task to project PID"
    puts "  task assign TID EID - Assign task to employee"
    puts "  task mark PID TID - Mark task TID as complete"
    puts "  emp list - List all employees"
    puts "  emp create NAME - Create a new employee"
    puts "  emp show EID - Show employee EID and all participating projects"
    puts "  emp details EID - Show all remaining tasks assigned to employee EID,"
    puts "                    along with the project name next to each task"
    puts "  emp history EID - Show completed tasks for employee with id=EID"
    puts "  exit – Exits Project Manager Pro®"
    puts "\n"
    self.start
  end

  def self.list_projects_client
    TM::Project.list_projects.each do |proj|
      puts "\n"
      puts "  Project Name: #{proj.name}"
      puts "  Project ID: #{proj.project_id}"
      puts "\n"
    end
    self.start
  end

  def self.create_project_client
    TM::Project.add_project(@input_arr[2])
    self.start
  end

  def self.show_project_tasks_client
    input_project_id = @input_arr[2].to_i

    incomplete_tasks_arr = TM::Project.list_incomplete(input_project_id)
    incomplete_tasks_arr.each do |task|
      puts "\n"
      puts "  Description: #{task.description}"
      puts "  Priority: #{task.priority}"
      puts "  Created: #{task.creation_time}"
      puts "  Task ID: #{task.task_id}"
      puts "\n"
    end
    self.start
  end

  def self.history_complete_tasks_client
    input_project_id = @input_arr[2].to_i

    complete_tasks_arr = TM::Project.list_complete(input_project_id)
    complete_tasks_arr.each do |task|
      puts "\n"
      puts "  Description: #{task.description}"
      puts "  Priority: #{task.priority}"
      puts "  Created: #{task.creation_time}"
      puts "  Task ID: #{task.task_id}"
      puts "\n"
    end
    self.start
  end

  def self.show_project_employees_client(project_id)
    self.start
  end

  def self.project_recruit_employee_client(project_id, employee_id)
    self.start
  end

  def self.create_task_client
    input_description = @input_arr[4..-1].join(" ")
    input_priority = @input_arr[3].to_i
    input_project_id = @input_arr[2]

    proj = TM::Project.select_project(input_project_id)
    proj[0].add_task(input_description, input_priority, input_project_id)
    self.start
  end

  def assign_task_client(task_id, employee_id)
    self.start
  end

  def self.complete_task_client
    project_id = @input_arr[2].to_i
    task_id = @input_arr[3].to_i

    TM::Project.complete_task(project_id, task_id)
    puts "  Task complete!"
    puts "\n"
    self.start
  end

  def list_employees_client
    self.start
  end

  def create_employee_client(employee_name)
    self.start
  end

  def projects_employee_belongs_client(employee_id)
    self.start
  end

  def employee_tasks_incomplete_client(employee_id)
    self.start
  end

  def employee_tasks_completed_client(employee_id)
    self.start
  end

  def self.exit
    puts "Goodbye!"
  end

end

TM::TerminalClient.help
TM::TerminalClient.start

# TO DO:
# Fix list_incomplete sorting (by date + priority)
# Fix @inputs +1 index in array

