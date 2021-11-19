# frozen_string_literal: true

# Contains the chess board in which the knight will travail.
class Board
  attr_reader :squares

  def initialize
    @squares = create_squares
    @knight_square = nil
  end

  def create_squares
    coord_arr = [0, 1, 2, 3, 4, 5, 6, 7].repeated_permutation(2).to_a
    square_arr = []
    coord_arr.each do |coord|
      new_square = Square.new(coord)
      square_arr.push(new_square)
    end
    square_arr
  end

  def find(coord1, coord2)
    coord = [coord1, coord2]
    @squares.each do |square|
      return square if square.coordinates == coord
    end
    nil
  end

  def place_knight(coord1, coord2)
    find(coord1, coord2).value = 'K'
    @knight_square = find(coord1, coord2)
  end

  def build_graph
    # iterate through all squares
    @squares.each do |square|
      # assign other squares to each square for which a knight move is legal
    end
    # check if the target vertex already has an edge with the current vertex, if so do not create another edge.
  end

  def check_legal_moves(square)
    moves = %w[up_left up_right right_up right_down down_right down_left left_down left_up]
    legal_moves = []
    moves.each do |move|
      target = knight_move(square, move)
      legal_moves.push(find(target[0], target[1])) if target[0].between?(0, 7) && target[1].between?(0, 7)
    end
    legal_moves
  end

  def knight_move(square, move)
    case move
    when 'up_left' then [square.coordinates[0] - 2, square.coordinates[1] - 1]
    when 'up_right' then [square.coordinates[0] - 2, square.coordinates[1] + 1]
    when 'right_up' then [square.coordinates[0] - 1, square.coordinates[1] + 2]
    when 'right_down' then [square.coordinates[0] + 1, square.coordinates[1] + 2]
    when 'down_right' then [square.coordinates[0] + 2, square.coordinates[1] + 1]
    when 'down_left' then [square.coordinates[0] + 2, square.coordinates[1] - 1]
    when 'left_down' then [square.coordinates[0] + 1, square.coordinates[1] - 2]
    when 'left_up' then [square.coordinates[0] - 1, square.coordinates[1] - 2]
    end
  end

  def change_square_value(square, value)
    square.value = value
  end

  def print_board # rubocop:disable Metrics/AbcSize
    puts "8 #{find(0, 0).value} #{find(0, 1).value} #{find(0, 2).value} #{find(0, 3).value} #{find(0, 4).value} #{find(0, 5).value} #{find(0, 6).value} #{find(0, 7).value}" # rubocop:disable Layout/LineLength
    puts "7 #{find(1, 0).value} #{find(1, 1).value} #{find(1, 2).value} #{find(1, 3).value} #{find(1, 4).value} #{find(1, 5).value} #{find(1, 6).value} #{find(1, 7).value}" # rubocop:disable Layout/LineLength
    puts "6 #{find(2, 0).value} #{find(2, 1).value} #{find(2, 2).value} #{find(2, 3).value} #{find(2, 4).value} #{find(2, 5).value} #{find(2, 6).value} #{find(2, 7).value}" # rubocop:disable Layout/LineLength
    puts "5 #{find(3, 0).value} #{find(3, 1).value} #{find(3, 2).value} #{find(3, 3).value} #{find(3, 4).value} #{find(3, 5).value} #{find(3, 6).value} #{find(3, 7).value}" # rubocop:disable Layout/LineLength
    puts "4 #{find(4, 0).value} #{find(4, 1).value} #{find(4, 2).value} #{find(4, 3).value} #{find(4, 4).value} #{find(4, 5).value} #{find(4, 6).value} #{find(4, 7).value}" # rubocop:disable Layout/LineLength
    puts "3 #{find(5, 0).value} #{find(5, 1).value} #{find(5, 2).value} #{find(5, 3).value} #{find(5, 4).value} #{find(5, 5).value} #{find(5, 6).value} #{find(5, 7).value}" # rubocop:disable Layout/LineLength
    puts "2 #{find(6, 0).value} #{find(6, 1).value} #{find(6, 2).value} #{find(6, 3).value} #{find(6, 4).value} #{find(6, 5).value} #{find(6, 6).value} #{find(6, 7).value}" # rubocop:disable Layout/LineLength
    puts "1 #{find(7, 0).value} #{find(7, 1).value} #{find(7, 2).value} #{find(7, 3).value} #{find(7, 4).value} #{find(7, 5).value} #{find(7, 6).value} #{find(7, 7).value}" # rubocop:disable Layout/LineLength
    puts '  A B C D E F G H'
  end
end

# Represents each individual square on the chess board
class Square
  attr_reader :coordinates
  attr_accessor :value

  def initialize(coordinates, value = '#')
    @coordinates = coordinates
    @value = value
  end
end

test_board = Board.new
test_board.place_knight(3, 7)
p test_arr = test_board.check_legal_moves(test_board.find(3, 7))
test_arr.each do |coord|
  test_board.change_square_value(test_board.find(coord[0], coord[1]), 'X')
end
test_board.print_board
