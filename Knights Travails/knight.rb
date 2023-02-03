# frozen_string_literal: true

# Knight Class
class Knight
  attr_accessor :location, :moves

  def initialize(location)
    @location = location
    @moves = possible_moves(location)
  end

  def possible_moves(location)
    result = []
    moves = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    moves.each do |move|
      x = location[0] + move[0]
      y = location[1] + move[1]
      result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    result
  end
end
