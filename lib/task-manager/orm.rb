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
      # binding.pry
      projects = []
      result.each do |project|
        projects << TM::Project.new(project[0], project[1])
      end
      projects
    end

    def add_project(name)
      command = <<-SQL
        INSERT INTO projects (name)
        VALUES('#{name}');
      SQL

      # result = @db
      #TM::Project.new(result[0], result[1], created_at)

      @db_adapter.exec(command)
    end

    def add_tasks(description, priority, complete, creation_time)
      command = <<-SQL
        INSERT INTO tasks (description, priority, complete, creation_time)
        VALUES('#{description}', '#{priority}', '#{complete}', '#{creation_time}');
      SQL

      @db_adapter.exec(command)
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
          creation_time TEXT,
          PRIMARY KEY( id ),
          project_id INTEGER REFERENCES projects( id )
        );
      SQL

      @db_adapter.exec(command)
    end
  end

  def self.orm
    @__orm_instance ||= ORM.new
  end

end
