require 'pg'

module TM
  class ORM
    def initialize
      @db_adapter = PG.connect(host: 'localhost', dbname: 'task-manager-db')
    end

    def list_projects
      command = <<-SQL
        SELECT * FROM projects;
      SQL

      result = @db_adapter.exec(command).values
      projects = []
      result.each do |project|
        projects << TM::Project.new(project[0], project[1])
      end
      projects
    end

    def list_tasks
      command = <<-SQL
        SELECT * FROM tasks;
      SQL

      result = @db_adapter.exec(command).values
      tasks = []
      result.each do |task|
        tasks << TM::Task.new(task[0], task[1], task[2], task[3], task[4], task[5])
      end
      tasks
    end

    def list_employees_orm
      command = <<-SQL
        SELECT * FROM employees;
      SQL

      result = @db_adapter.exec(command).values
      employees = []
      result.each do |employee|
        employees << TM::Employee.new(employee[0], employee[1])
      end
      employees
    end

    def add_project(name)
      command = <<-SQL
        INSERT INTO projects (name)
        VALUES('#{name}')
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).values
      TM::Project.new(result[0][0], result[0][1])
    end

    def add_task(description, priority, project_id, complete)
      command = <<-SQL
        INSERT INTO tasks (description, priority, project_id, complete)
        VALUES('#{description}', '#{priority}', '#{project_id}', '#{complete}')
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).values.first
      TM::Task.new(result[0].to_i, result[1], result[2].to_i, convert_to_boolean(result[3]), result[4], result[5].to_i)
    end

    def add_employee(name)
      command = <<-SQL
        INSERT INTO employees (name)
        VALUES('#{name}')
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).values
      TM::Employee.new(result[0][0], result[0][1])
    end

    def convert_to_boolean(boolean)
      if boolean == "f"
        false
      elsif boolean == "t"
        true
      end
    end

    def complete_task_orm(proj_id, task_id)
      command = <<-SQL
        UPDATE tasks
        SET complete = true
        WHERE tasks.id = '#{task_id}'
        AND tasks.project_id = '#{proj_id}';
      SQL

      @db_adapter.exec(command)
    end

    def drop_tables
      command = <<-SQL
        DROP TABLE tasks;
        DROP TABLE projects_employees;
        DROP TABLE projects;
        DROP TABLE employees;
      SQL

      @db_adapter.exec(command)
    end

    def create_tables
      command = <<-SQL
        CREATE TABLE projects(
          id SERIAL,
          name TEXT,
          PRIMARY KEY( id )
        );
        CREATE TABLE employees(
          id SERIAL,
          name TEXT,
          PRIMARY KEY( id )
        );
        CREATE TABLE tasks(
          id SERIAL,
          description TEXT,
          priority INTEGER,
          complete BOOLEAN,
          creation_time timestamp default current_timestamp,
          PRIMARY KEY( id ),
          project_id INTEGER REFERENCES projects( id ),
          employee_id INTEGER REFERENCES employees( id )
        );
        CREATE TABLE projects_employees(
          id SERIAL,
          PRIMARY KEY( id ),
          project_id INTEGER REFERENCES projects( id ),
          employee_id INTEGER REFERENCES employees( id )
        );
      SQL

      @db_adapter.exec(command)
    end
  end

  def self.orm
    @__orm_instance ||= ORM.new
  end

end
