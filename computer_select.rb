

class Computer
  def initialize
    @computer_array = []
    @file_path = "google-10000-english-no-swears.txt"
    @file_data = File.read(@file_path).split
  end

  def make_selection
    selected_word = nil

    loop do
      selected_word = @file_data.sample
      break if (5..12).cover?(selected_word.length)
    end
    
    puts selected_word

    selected_word.each_char do |char|
      @computer_array << "_"
    end

    puts @computer_array.join(" ")

    return selected_word
  end

  def get_computer_array
    @computer_array
  end
  
end
