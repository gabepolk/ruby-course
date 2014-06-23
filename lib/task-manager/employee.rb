
class TM::Employee

  attr_reader :name, :employee_id

  def initialize(employee_id, name)
    @employee_id = employee_id
    @name = name
  end

end
