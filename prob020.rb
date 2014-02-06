#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob20

	def initialize(num)
		@num = num
	end

	# pretty good, pretty fast 0.000367 s
	def solve
		time do
			sum = digitArray((1..@num).reduce(:*) || 1).reduce(:+)
			puts "The sum of the digits of #{@num}! is #{sum}."
		end
	end

end

p = Prob20.new(100)
p.solve