#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob13

	def initialize(filename)
		# read in numbers
		@filename = filename
		f = File.open(@filename)
		@nums = f.each_line.map(&:to_i)
		f.close
	end

	def print_nums
		s = ""
		@nums.each_with_index do |num, ind|
			s += "%03i: #{num}\n" % [ind+1]
		end
		puts s
	end

end

p = Prob13.new('prob013.txt')
p.print_nums