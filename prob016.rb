#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob16

	def initialize(base, exp)
		@base = base
		@exp = exp
	end

	# pretty straightforward, 0.000269 s
	def sum_digits
		time do
			num = @base**@exp
			digs = []
			while num > 9
				num, last_digit = num.divmod(10)
				digs << last_digit
			end
			digs << num
			ans = digs.inject(:+)
			puts "The sum of the digits of #{@base}^#{@exp} is #{ans}."
		end
	end
end

p = Prob16.new(2,15)
p.sum_digits

p2 = Prob16.new(2,1000)
p2.sum_digits