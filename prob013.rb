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

	def sum_of_nth_digit(n)
		@nums.map { |num| (num / 10**(n-1)) % 10}.inject(&:+)
	end

	# pretty fast, 0.0001612 s
	def brute_force
		time do
			sum = @nums.inject(&:+)
			puts "sum: #{sum}"
			num = sum
			digs = []
			while num > 9
				num, last_digit = num.divmod(10)
				digs << last_digit
			end
			digs << num
			puts "The first 10 digits are #{digs.reverse[0..9].join}."
		end
	end



end

p = Prob13.new('prob013.txt')
p.print_nums
p.brute_force