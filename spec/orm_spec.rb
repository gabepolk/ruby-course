require 'spec_helper'

describe TM::ORM do
  before(:all) do
    TM.orm.drop_tables
    TM.orm.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'task-manager-test'))
    TM.orm.create_tables
  end
  before(:each) do
    TM.orm.drop_tables
    TM.orm.create_tables
    TM.orm.add_project("test1")
    TM.orm.add_project("test2")
  end

  # after(:all) do
  #   TM.orm.drop_tables
  # end

  context "the singleton getter" do
    it "instantiates the ORM class" do
      # binding.pry
      result1 = TM.orm
      result2 = TM.orm

      expect(result1.object_id).to eq(result2.object_id)
    end
  end

  it "adds a project" do
    result = TM.orm.list_projects

    expect(result[0]).to be_a(Object)
  end

  it "lists projects" do
    result = TM.orm.list_projects
    name = result.first.name
    id = result.first.project_id.to_i

    expect(result[0]).to be_a(TM::Project)
    expect(name).to eq("test1")
    expect(id).to eq(1)
  end

  it "has a unique project_id" do
    # db.add_project("test2")
    result = TM.orm.list_projects
    id1 = result[0].project_id.to_i
    id2 = result[1].project_id.to_i

    expect(id1).to_not eq(id2)
  end
end
