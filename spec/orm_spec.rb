require 'spec_helper'

describe TM::ORM do
  before(:all) do
    TM.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
    TM.orm.create_tables
  end
  before(:each) do
    TM.orm.drop_tables
    TM.orm.create_tables
    TM.orm.add_project("test1")
    TM.orm.add_project("test2")
  end

  after(:all) do
    TM.orm.drop_tables
  end

  context "the singleton getter" do
    it "instantiates the ORM class" do
      result1 = TM.orm
      result2 = TM.orm

      expect(result1.object_id).to eq(result2.object_id)
    end
  end

  it "adds a project" do
    TM.orm.add_project("test3")
    result = TM.orm.list_projects

    expect(result[2]).to be_a(Object)
    expect(result[2].project_id).to eq(3.to_s)
    expect(result[2].name).to eq("test3")
  end

  it "marks a task as complete" do
    TM.orm.add_task("This is a description", 5, 1, false)
    TM.orm.add_task("This is a description", 4, 1, false)
    TM.orm.add_task("This is a description", 1, 1, false)
    TM.orm.complete_task_orm(1, 1)
    result = TM::Project.list_complete(1)

    expect(result.count).to eq(1)
  end

  it "adds a task" do
    result = TM.orm.add_task("This is a description", 5, 1, false)

    expect(result).to be_a(Object)
    expect(result.description).to eq("This is a description")
    expect(result.priority).to eq(5)
    expect(result.complete).to eq(false)
    expect(result.creation_time).to be_a(Time)
  end

  it "lists projects" do
    result = TM.orm.list_projects
    name = result.first.name
    project_id = result.first.project_id.to_i

    expect(result[0]).to be_a(TM::Project)
    expect(name).to eq("test1")
    expect(project_id).to eq(1)
  end

  it "lists tasks" do
    TM.orm.add_task("This is a description", 5, 1, false)

    result = TM.orm.list_tasks[0]
    task_id = result.task_id.to_i
    description = result.description
    priority = result.priority.to_i
    complete = result.complete
    project_id = result.project_id.to_i

    expect(result).to be_a(TM::Task)
    expect(description).to eq("This is a description")
    expect(task_id).to eq(1)
    expect(complete).to eq("f")
    expect(project_id).to eq(1)
    expect(priority).to eq(5)
  end

  it "has a unique project_id" do
    result = TM.orm.list_projects
    id1 = result[0].project_id.to_i
    id2 = result[1].project_id.to_i

    expect(id1).to_not eq(id2)
  end
end
