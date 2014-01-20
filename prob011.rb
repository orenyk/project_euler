#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob11

	# arbitrary grids and product lengths, oh my!
	def initialize(filename, len)
		# read in grid
		@filename = filename
		f = File.open(@filename)
		@grid = f.each_line.map { |line|
			line.split(' ').map(&:to_i)
		}
		f.close
		@rows = @grid.length
		@cols = @grid[0].length

		# store some solution information
		@max_prod = 0
		@len = len
		@nums = []
		@points = []
	end

	# let's just make sure things are happy
	def print_grid
		s = ""
		@grid.each do |row|
			row.each do |cell|
				s += "%02i " % cell
			end
			s += "\n"
		end
		puts s
	end

	# print out grid with only solutions... wish there was a way to do complex formatting or colors
	def print_sol_grid
		s = ""
		@grid.each_with_index do |row, r_ind|
			row.each_with_index do |cell, c_ind|
				if @points.include?([r_ind, c_ind])
					s += "|%02i|" % cell
				else
					s += " %02i " % cell
				end
			end
			s += "\n"
		end
		puts s
	end

	# check for a product in a given direction (using vectors, effectively)
	def check_product(pos, dir)
		nums = [@grid[pos[0]][pos[1]]]
		points = [pos]
		(1..@len-1).each do |i|
			new_pos = pos.zip(dir.map{ |x| x*i }).map { |z|
				z.inject(&:+)
			}
			nums.push(@grid[new_pos[0]][new_pos[1]])
			points.push(new_pos)
		end
		prod = nums.reduce(1, :*)
		if prod > @max_prod
			@max_prod = prod
			@nums = nums
			@points = points
		end
	end

	# not bad!  0.1575 s
	def find_max_prod
		time do
			(0..@rows-1).each do |row|
				(0..@cols-1).each do |col|
					pos = [row, col]
					[[0,1],[1,0],[1,1],[1,-1]].each do |dir|
						check_product(pos, dir) unless !(0..@rows-1).include?(row+(@len-1)*dir[0]) || !(0..@cols-1).include?(col+(@len-1)*dir[1])
					end
				end
			end
			puts "The maximum product is equal to #{@max_prod} from elements #{@nums}."
			self.print_sol_grid
		end
	end

end

p = Prob11.new('prob011.txt', ARGV[0].to_i)
p.find_max_prod