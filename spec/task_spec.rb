require 'spec_helper'

describe 'Task' do
  xit "exists" do
    expect(TM::Task).to be_a(Class)
  end

  let(:task) {TM::Task.new("Design a wireframe", 5, 1)}

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
