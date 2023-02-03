# frozen_string_literal: true

# Class to make node of reverse tree
class Node
  attr_accessor :data, :nxt

  def initialize(data = nil, nxt = nil)
    @data = data
    @nxt = nxt
  end
end

# Board Class
class Board
  def initialize
    @queue = []
  end

  def knight_moves(start, destination)
    puts 'Incorrect input!' if check_error?(start) || check_error?(destination)
    print_moves([start]) if start == destination
    path = traveling(Node.new(start), destination)
    result = []
    while path
      result << path.data
      path = path.nxt
    end
    @queue = []
    print_moves(result.reverse, start, destination)
  end

  private

  def traveling(cur_node, destination)
    @queue << cur_node
    visited = { cur_node.data => true }
    while @queue
      cur_node = @queue.shift
      knight = Knight.new(cur_node.data)
      moves = knight.moves
      moves.each do |cord|
        return Node.new(cord, cur_node) if cord == destination

        next if visited.key?(cord)

        @queue << Node.new(cord, cur_node)
        visited[cord] = true
      end
    end
  end

  def print_moves(path, start, destination)
    puts "You made it in #{path.length - 1} moves! Here's your path from #{start} to #{destination}"
    path.each { |cord| p cord }
  end

  def check_error?(cord)
    !(cord[0].between?(0, 7) && cord[1].between?(0, 7))
  end
end
