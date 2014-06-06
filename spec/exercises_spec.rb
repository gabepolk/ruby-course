require 'rubygems'
require 'rspec'
require 'pry-debugger'
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

