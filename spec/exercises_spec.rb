require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../exercises.rb'

describe 'Exercise 0' do
  it "triples the provided str" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if 'str' is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end
