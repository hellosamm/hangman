require_relative 'game'
require "json"

class Computer
  def initialize
    @computer_array = []
    @computer_word = nil
    @file_path = "google-10000-english-no-swears.txt"
    @file_data = File.read(@file_path).split
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

  def save_game
    game_data = {
      computer_word: @computer_word,
      computer_array: @computer_array,
      guess_count: @guess_count,
      guess_array: @guess_array
    }
  

    File.write("save_game.json", JSON.generate(game_data))

    puts "game saved successfully"
  end

  def open_game
    if File.exist?("save_game.json")
      save_game = JSON.parse(File.read("save_game.json"))
      @computer_word = save_game["computer_word"]
      @computer_array = save_game["computer_array"]
      @guess_count = save_game["guess_count"]
      @guess_array = save_game["guess_array"]

      puts "game loaded successfully"
      # @game.start_guessing
    else 
      puts "no game found"
      @game.options
    end
  end
end
