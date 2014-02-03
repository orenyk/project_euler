#!/usr/bin/env ruby

require_relative 'euler_helper'
require 'date'

class Prob19

	def initialize
		@start = Date.new(1901,1,1)
		@end = Date.new(2000,12,31)
		@first_sundays = 0
	end

	def first_sunday?
	end

	# not bad, 0.00232 s
	def solve_ruby
		time do
			(1901..2000).each do |year|
				(1..12).each do |month|
					if Date.new(year,month,1).wday == 0
						@first_sundays += 1
					end
				end
			end
			puts "There were #{@first_sundays} Sundays on the first of the month during the twentieth century."
		end
	end
end

p = Prob19.new
p.solve_ruby