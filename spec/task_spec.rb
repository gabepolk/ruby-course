require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  let(:task) {TM::Task.new("Design a wireframe", 5, 1)}

  describe '#initialize' do
    it "is a Task" do
      expect(task).to be_a(TM::Task)
    end
    it "inherits the project id" do
      expect(task.project_id).to eq(1)
    end
    it "has a description" do
      expect(task.description).to eq("Design a wireframe")
    end
    it "has a priority number" do
      expect(task.priority).to eq(5)
    end
    it "has a default complete status of 'false'" do
      expect(task.complete).to eq(false)
    end
    it "has a creation date" do
      expect(task.creation_time).not_to eq(nil)
    end
    # binding.pry
  end

  describe '#change_complete_status'
    it "marks the task as complete" do
      task.complete_task

      expect(task.complete).to eq(true)
    end
end
