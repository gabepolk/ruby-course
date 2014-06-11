
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    str != "wishes" ? str * 3 : "nope"
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    array.count >= 1 ? array.count : "The array is empty"
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    array.count >= 1 ? array[1] : "The array is empty"
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    if array.count == 0
      return "The array is empty"
    else
      array.inject(0) { |sum, x| sum += x }
    end
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    if array.count == 0
      return "The array is empty"
    else
      array.sort.last
    end
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    if array.count == 0
      return "The array is empty"
    else
      array.each { |x| puts x }
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array.last == "panda"
      array.pop
      array.push("GODZILLA")
      array.last
    else
      array.pop
      array.push("panda")
      array.last
    end
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include?(str)
      array.delete(str)
      array.push(str)
    else
      return "String not found in the array"
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    if people.count == 0
      return "The array is empty"
    else
      people.each_with_index do |item, index|
        puts people[index][:name]
        puts people[index][:occupation]
      end
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # year = Time.now.strftime("%Y")
    if time % 4 == 0
      return "Leap year!"
    else
      return "Not a leap year."
    end
  end
end

class RPS

  attr_reader :player_1, :player_2, :rules
  attr_accessor :winning_move, :play_count, :winners

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @rules = {
      :rock     => {:rock => :draw, :paper => :paper, :scissors => :rock},
      :paper    => {:rock => :paper, :paper => :draw, :scissors => :scissors},
      :scissors => {:rock => :rock, :paper => :scissors, :scissors => :draw}
    }
    @winning_move = nil
    @winners = Hash.new(0)
  end

  def play(player_1_move, player_2_move)

    @winning_move = @rules[player_1_move][player_2_move]
    if @winning_move == :draw
      puts "It was a draw!"
    elsif @winning_move == player_1_move
      puts "#{player_1} wins!"
      @winners[player_1] += 1
      return player_1
    elsif @winning_move == player_2_move
      puts "#{player_2} wins!"
      @winners[player_2] += 1
      return player_2
    end
  end

end

require 'io/console'
class RPSPlayer

  def self.start

    puts "Player 1, please enter your name."
    player_1 = gets.chomp
    puts "Player 2, please enter your name."
    player_2 = gets.chomp

    @game = RPS.new(player_1, player_2)

    while @game.winners[player_1] < 2 && @game.winners[player_2] < 2
      puts "New game beginning!"

      puts "#{player_1}, please enter your move: Rock, Paper, or Scissors."
      player_1_move = STDIN.noecho(&:gets).chomp.to_sym
      puts "#{player_2}, please enter your move: Rock, Paper, or Scissors."
      player_2_move = STDIN.noecho(&:gets).chomp.to_sym

      @game.play(player_1_move, player_2_move)
    end

    puts "Game over."
    @game.winning_move = nil

  end
end

module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
  end
end
