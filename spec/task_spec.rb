require 'spec_helper'

describe 'Task' do
  # before(:all) do
  #   TM.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
  #   TM.orm.create_tables
  # end
  # before(:each) do
  #   TM.orm.drop_tables
  #   TM.orm.create_tables
  #   TM.orm.add_project("test1")
  #   TM.orm.add_project("test2")
  # end

  # after(:all) do
  #   TM.orm.drop_tables
  # end

  let(:task) {TM::Task.new("This is a description", 5, false, 1)}

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    xit "is a Task" do
      expect(task).to be_a(TM::Task)
    end
    xit "create a task id" do
      expect(task.task_id).to eq(1)
    end
    xit "has a description" do
      expect(task.description).to eq("Design a wireframe")
    end
    xit "has a priority number" do
      expect(task.priority).to eq(5)
    end
    xit "has a default complete status of 'false'" do
      expect(task.complete).to eq(false)
    end
    xit "has a creation date" do
      expect(task.creation_time).not_to eq(nil)
    end
  end

end
