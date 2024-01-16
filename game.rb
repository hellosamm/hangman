require_relative 'computer_select'



class Game
  def initialize
    @computer = Computer.new
    @computer_word = nil
  end 

  def play
    instructions
  end

  def play_round
    start_guessing
  end


  def instructions
    puts "would you like to play hangman? you have 8 guesses to guess my word. y/n "
    play_game = gets.chomp.downcase 

    if play_game == "y"
      @computer_word = @computer.make_selection
      play_round
    else 
      puts "see you later"
      exit
    end
  end

  def start_guessing
    loop do
      puts "guess a letter: "
      user_input = gets.chomp.downcase
      check_guess(user_input)
    end
  end

  def check_guess (user_input)
    if @computer_word.include?(user_input)
      puts "yes"
      else 
      puts "no"
    end
  end
end



