require 'rubygems'
require 'rspec'
require 'pry-debugger'
require 'stringio'
require_relative '../exercises.rb'

describe "Exercise 0" do
  it "triples the provided str" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if 'str' is 'wishes'" do
    result = Exercises.ex0('wishes')
    expect(result).to eq('nope')
  end
end

describe "Exercise 1" do
  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex1([])
    expect(result).to eq("The array is empty")
  end

  it "returns the number of elements in an array" do
    result = Exercises.ex1([1,2,3,4,5])
    expect(result).to eq(5)
  end
end

describe "Exercise 2" do
  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex2([])
    expect(result).to eq("The array is empty")
  end

  it "returns the second element in an array" do
    result = Exercises.ex2([1,2,3,4,5])
    expect(result).to eq(2)
  end
end

describe "Exercise 3" do
  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex3([])
    expect(result).to eq("The array is empty")
  end

  it "returns the sum of an array" do
    result = Exercises.ex3([1,2,3,4,5])
    expect(result).to eq(15)
  end
end

describe "Exercise 4" do
  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex4([])
    expect(result).to eq("The array is empty")
  end
  it "returns the max number of the given array" do
    result = Exercises.ex4([2,33,91,5])
    expect(result).to eq(91)
  end
end

describe "Exercise 5" do
  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex5([])
    expect(result).to eq("The array is empty")
  end

  it "should iterate through an array and puts each element" do
    Exercises.ex5(["this", "is", "an", "array", "of", "strings"])
    expect($stdout.string).to match(/this\nis\nan\narray\nof\nstrings\n/)
  end
end

describe "Exercise 6" do
  it "should update the last item of an array to 'panda'" do
    result = Exercises.ex6(["dog", "cat", "mouse", "squirrel"])
    expect(result).to eq("panda")
  end

  it "if last item is already 'panda' update it to 'GODZILLA'" do
    result = Exercises.ex6(["dog", "cat", "mouse", "panda"])
    expect(result).to eq("GODZILLA")
  end
end

describe "Exercise 7" do
  context "If the given string doesn't exist in the array" do
    it "returns 'String not found in the array'" do
      result = Exercises.ex7(["dog", "cat", "mouse", "squirrel"], "panda")
      expect(result).to eq("String not found in the array")
    end
  end

  context "Checks if a given string 'str' exists, " do
    it "adds 'str' to the end of the array" do
      result = Exercises.ex7(["dog", "cat", "mouse", "squirrel"], "cat")
      expect(result).to eq(["dog", "mouse", "squirrel", "cat"])
    end
  end
end

describe "Exercise 8" do
  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it "returns 'The array is empty' if the array is empty" do
    result = Exercises.ex8([])
    expect(result).to eq("The array is empty")
  end

  it "iterates through an array and prints out 'name' and 'occupation'" do
    people = [
      { name: 'Bob', occupation: 'Builder' },
      { name: 'John', occupation: 'Plumber' }
    ]
    Exercises.ex8(people)
    expect($stdout.string).to match(/Bob\nBuilder\nJohn\nPlumber\n/)
  end
end

describe "Exercise 9" do
  it "determines if a leap year returns true" do
    result = Exercises.ex9(2012)
    expect(result).to eq("Leap year!")
  end

  it "determines if a non-leap year returns false" do
    result = Exercises.ex9(2014)
    expect(result).to eq("Not a leap year.")
  end
end








