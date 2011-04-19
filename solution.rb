#!/usr/bin/env ruby
# 
# require 'rubygems'
# require 'ruby-debug'

def count_impacts(north_laser_array, south_laser_array, direction)
  robot_moves = (0..(north_laser_array.size - 1) ).to_a  #left to right
  robot_moves.reverse! if direction == :west #right to left
  impacts = 0
  robot_moves.each_with_index do |robot_position, tick|
    if(tick % 2 == 0) #even tick
      impacts += 1 if north_laser_array[robot_position] == "|"
    else #odd
      impacts += 1 if south_laser_array[robot_position] == "|"
    end
  end
  return impacts
end

def solve(factory_floor)
  north, conveyor, south, space = factory_floor.collect { |line| line.chomp.chars.to_a }
  rsp = robot_starting_position = conveyor.find_index("X")
  north_west, north_east = north[0..rsp], north[rsp..north.size]
  south_west, south_east = south[0..rsp], south[rsp..south.size]   
  # debugger
  puts count_impacts(north_west, south_west, :west ) <= count_impacts(north_east, south_east, :east) ? "GO WEST" : "GO EAST"
end 

input = File.read(ARGV[0]).lines.to_a
while (input.size > 0) do
  solve(input.slice!(0..3))
end


