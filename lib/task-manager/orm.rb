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

    def add_project(name)
      command = <<-SQL
        INSERT INTO projects (name)
        VALUES('#{name}')
        RETURNING *;
      SQL

      result = @db_adapter.exec(command).values
      TM::Project.new(result[0][0], result[0][1])
    end

    def add_task(description, priority, complete, project_id)
      command = <<-SQL
        INSERT INTO tasks (description, priority, complete, project_id)
        VALUES('#{description}', '#{priority}', '#{complete}', '#{project_id}')
        RETURNING *;
      SQL
      # binding.pry

      result = @db_adapter.exec(command).values.first
      TM::Task.new(result[0].to_i, result[1], result[2].to_i, convert_boolean(result[3]), result[4], result[5].to_i)
    end

    def convert_boolean(boolean)
      if boolean == "f"
        false
      elsif boolean == "t"
        true
      end
    end

    def drop_tables
      command = <<-SQL
        DROP TABLE tasks;
        DROP TABLE projects;
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
        CREATE TABLE tasks(
          id SERIAL,
          description TEXT,
          priority INTEGER,
          complete BOOLEAN,
          creation_time timestamp default current_timestamp,
          PRIMARY KEY( id ),
          project_id INTEGER REFERENCES projects( id )
        );
      SQL
        # CREATE TABLE employees(
        #   id SERIAL,
        #   name TEXT,
        #   PRIMARY KEY( id ),
        # );

      @db_adapter.exec(command)
    end
  end

  def self.orm
    @__orm_instance ||= ORM.new
  end

end
