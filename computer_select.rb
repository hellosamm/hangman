require_relative 'game'
require "json"

class Computer
  def initialize(game_instance = nil)
    @computer_array = []
    @computer_word = nil
    @file_path = "google-10000-english-no-swears.txt"
    @file_data = File.read(@file_path).split
    @game = game_instance
  end

  def make_selection

    loop do
      @computer_word = @file_data.sample
      break if (5..12).cover?(@computer_word.length)
    end
    
    puts @computer_word

    @computer_word.each_char do |char|
      @computer_array << "_"
    end

    puts @computer_array.join(" ")

    return @computer_word, @computer_array
  end

  def get_computer_array
    @computer_array
  end

end
