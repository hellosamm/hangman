require_relative 'computer_select'



class Game
  def initialize
    @computer = Computer.new(self)
    @guess_array = []
    @guess_count = 0
    @computer_word = nil
    @computer_array = nil

  end 

  

  def play
    instructions

  end

  def play_round
    start_guessing
  end


  def instructions
    puts "would you like to play hangman? you have 8 guesses to guess my word."
    puts "select one:"
    puts "1. start a new game"
    puts "2. load a saved game"
    puts "3. exit"
    play_game = gets.chomp.to_i 

    case play_game
    when 1 
      @computer_word, @computer_array = @computer.make_selection
      start_guessing
    when 2
      open_game
      # start_guessing
    when 3
      exit
    end
  end

  def start_guessing
    loop do
      puts "guess a letter: "
      user_input = gets.chomp.downcase
      check_guess(user_input)
      options
    end
  end

  def options
    loop do
      puts "select one"
      puts "1. make a guess"
      puts "2. save your game"
      puts "3. load saved game"
      puts "4. exit"
      choice = gets.chomp.to_i

      case choice
      when 1
        start_guessing
        break
      when 2
        save_game
        exit
      when 3
        open_game
        start_guessing
      when 4
        exit
      else 
        puts "invalid choice"
      end
      end
  end

  def check_guess (user_input)
    # puts "computer word: #{@computer_word}"
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
    puts "incorrect guesses: #{@guess_array.join(", ")}"
    puts @computer_array.join(" ")
  end

  def update_guess_count
    @guess_count += 1
    # puts @guess_count

    check_guess_count
  end

  def check_guess_count
    if @guess_count == 8 
      puts "you used all 8 guesses & couldn't guess the word"
      exit
      # user_input = gets.chomp.downcase
      # play_again (user_input)
    end
  end

  def check_for_correct_answer
    if @computer_array.join == @computer_word
      puts "you guessed it, nice job"
      exit
      # user_input = gets.chomp.downcase
      # play_again(user_input)
    end
  end

 
  # def play_again(user_input)
  #   if user_input == "y"
  #     @guess_count = 0
  #     @computer_word = @computer.make_selection
  #     play_round
  #   else 
  #     puts "see you later"
  #     exit
  #   end
  # end

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
      puts @computer_array.join(" ")
      puts "incorrect guesses: #{@guess_array.join(", ")}"
      start_guessing
      # return @computer_word, @computer_array, @guess_count, @guess_array
    
      # @game.start_guessing
    else 
      puts "no game found"
      options
    end
  end
  
end



