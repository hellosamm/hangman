require_relative 'computer_select'



class Game
  def initialize
    @computer = Computer.new
    @computer_word = nil
    @guess_array = []
    @guess_count = 0
    @computer_array = @computer.get_computer_array
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
      update_board(user_input)
      check_for_correct_answer
      else 
      update_incorrect_guess_list(user_input)
      update_guess_count
    end   
    
  end

  def update_board(user_input)
    # computer_array = @computer.get_computer_array
    
    @computer_word.each_char.with_index do |char, index|
      @computer_array[index] = user_input if char == user_input
    end

    puts @computer_array.join(" ")
  end

  def update_incorrect_guess_list(user_input)
    @guess_array << user_input
    puts @guess_array.join(", ")
  end

  def update_guess_count
    @guess_count += 1
    puts @guess_count

    check_guess_count
  end

  def check_guess_count
    if @guess_count == 8 
      puts "you couldn't guess the word, want to try again? y/n"
      user_input = gets.chomp.downcase
      play_again (user_input)
    end
  end

  def check_for_correct_answer
    if @computer_array.join == @computer_word
      puts "nice job, you won. want to play again? y/n"
      user_input = gets.chomp.downcase
      play_again(user_input)
    end
  end

 
  def play_again(user_input)
    if user_input == "y"
      @guess_count = 0
      @computer_word = @computer.make_selection
      play_round
    else 
      puts "see you later"
      exit
    end
  end
  
end



