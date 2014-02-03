#!/usr/bin/env ruby

require_relative 'euler_helper'
require 'date'

class Prob19

	def initialize
		@first_sundays = 0
		@wdays = {}
		@months = [nil,3,0,3,2,3,2,3,3,2,3,2,3]
		@wdays[[1900,1]] = 1
		@outs = []
	end

	def next_month(date)
		old_year = date[0]
		old_month = date[1]

		if old_month == 12
			year = old_year + 1
			month = 1
		else
			year = old_year
			month = old_month + 1
		end

		if not @wdays[[year,month]]
			if old_month == 2
				if old_year % 4 == 0 and not (old_year % 100 == 0 and old_year % 400 != 0)
					wday = (@wdays[date] + 1) % 7
				else
					wday = @wdays[date]
				end
			else
				wday = (@wdays[date] + @months[old_month]) % 7
			end
			@wdays[[year,month]] = wday
		end
		[[year, month], @wdays[[year,month]]]
	end

	# a little slower, 0.0136 s
	def solve
		time do
			(1..12).each do |month|
				@outs = self.next_month([1900,month])
			end
			date = @outs[0]
			while date[0] < 2001
				@outs = self.next_month(date)
				date = @outs[0]
				if @outs[1] == 0
					@first_sundays += 1
				end
			end
			puts "There were #{@first_sundays} Sundays on the first of the month during the twentieth century."
		end
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
p.solve