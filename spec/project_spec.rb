require 'spec_helper'

describe 'Project' do
  # before block to reset id_generator
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

  describe '#add_task' do
    xit "adds a task to the db" do
      project1.add_task("Design a wireframe", 5)

      expect(project1.tasks.count).to eq(1)
    end
  end

  describe '#list_complete' do
    context "when all tasks are complete" do
      xit "sorts by creation time" do
        project1.add_task("Use foundation for framework", 4, 987654321)
        project1.add_task("Design a wireframe", 5, 123456789)
        project1.tasks.select { |task| task.complete = true }
        project1.list_complete

        expect(project1.completed_tasks.first.description).to eq("Use foundation for framework")
      end
    end
  end

  describe '#list_incomplete' do
    context "when all tasks are incomplete" do
      xit "sorts by priority" do
        project1.add_task("Use foundation for framework", 4, 0)
        project1.add_task("Design a wireframe", 3, 0)
        project1.add_task("Begin building", 5, 0)
        project1.list_incomplete

        expect(project1.incompleted_tasks.first.description).to eq("Begin building")
      end
    end
  end

  describe '.mark task' do
    xit "marks a task as complete" do
      project_test = TM::Project.list_projects.first
      project_test.add_task("This is a description", 5)
      project_test.add_task("This is another description", 4)
      TM::Project.complete_task(0, 0)

      expect(project_test.tasks[0].complete).to eq(true)
    end
  end

end
