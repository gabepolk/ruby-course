require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

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

  let(:project1) {TM::Project.add_project("Portfolio")}
  let(:project2) {TM::Project.add_project("Website")}

  describe '#initialize' do
    it "is a Project" do
      expect(project1).to be_a(TM::Project)
    end
    it "accepts a name argument" do
      expect(project1.name).to eq("Portfolio")
    end
    it "accepts an id argument" do
      expect(project1.project_id).to eq(3.to_s)
    end
  end

  describe '.list_projects' do
    it "lists all projects" do
      expect(TM::Project.list_projects.count).to eq(2)
    end
  end

  describe '.list_tasks' do
    it "lists all tasks for a given project" do
      TM.orm.add_task("This is a description", 5, 1, false)

      expect(TM::Project.list_tasks(1).count).to eq(1)
    end
  end

  describe '#add_task' do
    xit "adds a task to the db" do
      project1.add_task("This is a description", 5, false, 1)

      expect(project1.tasks.count).to eq(1)
    end
  end

  describe '.list_complete' do
    context "when all tasks are complete" do
      it "sorts by creation time" do
        TM.orm.add_task("This is a description", 2, 1, false)
        TM.orm.add_task("This is a description", 1, 1, true)
        TM.orm.add_task("This is a description", 5, 1, false)
        TM.orm.add_task("This is a description", 4, 1, true)
        TM.orm.add_task("This is a description", 4, 1, false)
        complete_tasks_arr = TM::Project.list_complete(1)

        expect(complete_tasks_arr.count).to eq(2)
        expect(complete_tasks_arr[0].priority.to_i).to eq(4)
        expect(complete_tasks_arr[1].priority.to_i).to eq(1)
      end
    end
  end

  describe '.list_incomplete' do
    context "when all tasks are incomplete" do
      it "sorts by priority" do
        TM.orm.add_task("This is a description", 2, 1, false)
        TM.orm.add_task("This is a description", 1, 1, true)
        TM.orm.add_task("This is a description", 5, 1, false)
        TM.orm.add_task("This is a description", 4, 1, false)
        incomplete_tasks_arr = TM::Project.list_incomplete(1)

        expect(incomplete_tasks_arr.count).to eq(3)
      end
    end
  end

  describe '.mark task' do
    it "marks a task as complete" do
      project_test = TM::Project.list_projects.first
      project_test.add_task("This is a description", 5, 1)
      project_test.add_task("This is another description", 4, 1)
      TM::Project.complete_task(1, 1)

      expect(TM::Project.list_complete(1).count).to eq(1)
    end
  end

end
