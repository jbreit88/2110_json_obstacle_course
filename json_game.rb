require 'matrix'

class JasonGame
  attr_accessor :jasons_board_array
  attr_reader :grid_size, :box_length

  def initialize
    @grid_size = 4
    @jasons_board_array = make_board
    @box_length = @jasons_board_array.max_by(&:length).length + 2
  end

  def make_board
    # List of available Jasons. If expanding board add a ton more Jasons
    jasons = ["mraz", "sudeikis", "alexander", "derulo", "momoa", "bateman", "aldean", "statham", "biggs", "red ranger", "the murderer guy", '.parse', 'json', 'waterfalls', 'judakiss', 'and the argonauts']

    # Shuffle list, every person gets random shuffling
    shuffled = jasons.shuffle
    sliced = shuffled.slice(0, @grid_size.to_i * @grid_size.to_i - 1)

    if @grid_size.odd?
      sliced.insert((sliced.length / 2), 'free')
    else
      sliced << 'free'
      sliced.shuffle
    end
  end

  # Renders an ASCII grid based on a 2D array
  def drawgrid(args, boxlen=@grid_size)
    #Define box drawing characters
    side = '│'
    topbot = '─'
    tl = '┌'
    tr = '┐'
    bl = '└'
    br = '┘'
    lc = '├'
    rc = '┤'
    tc = '┬'
    bc = '┴'
    crs = '┼'
    ##############################
    draw = []
    args.each_with_index do |row, rowindex|
      # TOP OF ROW Upper borders
      row.each_with_index do |col, colindex|
        if rowindex == 0
          colindex == 0 ? start = tl : start = tc
          draw << start + (topbot*boxlen)
          colindex == row.length - 1 ? draw << tr : ""
        end
      end
      draw << "\n" if rowindex == 0

      # MIDDLE OF ROW: DATA
      row.each do |col|
        draw << side + col.to_s.center(boxlen)
      end
      draw << side + "\n"

      # END OF ROW
      row.each_with_index do |col, colindex|
        if colindex == 0
          rowindex == args.length - 1 ? draw << bl : draw << lc
          draw << (topbot*boxlen)
        else
          rowindex == args.length - 1 ? draw << bc : draw << crs
          draw << (topbot*boxlen)
        end
        endchar = rowindex == args.length - 1 ? br : rc

        #Overhang elimination if the next row is shorter
        if args[rowindex+1]
          if args[rowindex+1].length < args[rowindex].length
            endchar = br
          end
        end
        colindex == row.length - 1 ? draw << endchar : ""
      end
      draw << "\n"
    end

    draw.each do |char|
      print char
    end
    return true
  end

  def start_game
    puts "Welcome to JSON Quiz!"

    puts "Enter P to play. Enter Q to quit."
    player_input = gets.chomp.downcase

    until ["p", "q"].include?(player_input)
      puts "Not a valid selection, Please try again:"
      player_input = gets.chomp.downcase
    end

    if player_input == "p"
      puts "Game On!"
      play_game
    elsif player_input == "q"
      puts "Whatever, we're going to play anyways..."
      puts "Game on!"
      play_game
    end
  end

  def player_input
    $stdin.gets.chomp
  end

  def change_jason_to_x(input)
    new_board_array = []
    @jasons_board_array.each do |jason|
      if jason.downcase.strip == input.downcase.strip
        new_board_array << jason = 'X'
      else
        new_board_array << jason
      end
    end
    @jasons_board_array = new_board_array
  end

  def render
    titleized = []

    @jasons_board_array.each do |element|
      titleized << element.split(/ |\_/).map(&:capitalize).join(" ")
    end

    board_array = titleized.each_slice(@grid_size).to_a

    drawgrid(board_array, boxlen=@box_length)
  end

  def check_end_game?
    matrix_array = []
    # convert board array to 1's (the X's) and 0's (anything else)
    @jasons_board_array.each do |jason|
      if jason == 'X'
        matrix_array << jason = 1
      else
        matrix_array << jason = 0
      end
    end

    board_array = matrix_array.each_slice(@grid_size).to_a

    win = false

    array_position = 0

    board_array.length.times do
      # sum row and check if @grid_size
      if board_array[array_position].reduce(:+) == @grid_size
        win = true
      end

      # transpost array and re-run above check
      check_column = board_array.transpose[array_position]
      if check_column.reduce(:+) == @grid_size
        win = true
      end

      array_position += 1
    end

    board_matrix = Matrix[*board_array]

    reverse_board_array = board_array.map do |array|
                            array.reverse
                          end

    reverse_board_matrix = Matrix[*reverse_board_array]


    # check diagonals
    if board_matrix.trace == @grid_size || reverse_board_matrix.trace == @grid_size
      win = true
    end

    return win
  end

  def play_game

    puts "This is your board."
    render
    puts "To mark a space type the word you see in the box"
    puts "Let's put a check on the free space. Type 'free' below."

    input = player_input
    until 'free' == input.downcase
      puts 'I said type free. Please try again:'
      input = player_input
    end

    change_jason_to_x(input)

    loop do
      puts "This is your board:"
      render
      puts "If you see a Jason that is on your board, type their name below:"
      input = player_input
      until @jasons_board_array.include?(input.downcase.strip)
        puts 'Not a valid JaSON. Please try again:'
        input = player_input
      end
      change_jason_to_x(input)
      break if check_end_game?
    end

    render
    puts "You connected #{@grid_size} JaSONs! Quick! Raise your hand and say something!"
  end
end
