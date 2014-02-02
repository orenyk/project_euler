#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob67

	# arbitrary triangle initialization
	def initialize(filename)
		# read in triangle, we're assuming it's valid
		@filename = filename
		f = File.open(@filename)
		@tri = f.each_line.map { |line|
			line.split(' ').map(&:to_i)
		}
		f.close
		@rows = @tri.length
	end

	def print_triangle
		s = ""
		@tri.each do |line|
			line.each do |cell|
				s += "%02d " % cell
			end
			s += "\n"
		end
		puts s
	end

	# super fast, makes way more sense, 0.000139 s
	def find_max_path
		time do
			# we have to end at one of the bottom nodes, so work bottom-up
			(@rows-2).step(0, -1) do |row|
				(0..row).each do |pos|
					@tri[row][pos] += [@tri[row+1][pos], @tri[row+1][pos+1]].max
				end
			end
			puts "the maximum sum is #{@tri[0][0]}."
		end
	end
end

p = Prob67.new('prob067.txt')
p.find_max_path