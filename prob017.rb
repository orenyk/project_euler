#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob17

	def initialize(max)
		@max = max < 1000000 ? max : nil
		@digits = [nil, "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
		@tens = [nil, nil, "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
		@hundred = "hundred"
		@thousand = "thousand"
		@and = "and"
		@sums = {}
	end

	def sum_below_twenty(n)
		if not @sums[n]
			sum = 0
			@digits[0..n].each do |num|
				sum += num ? num.length : 0
			end
			@sums[n] = sum
		end
		@sums[n]
	end

	def sum_of_decade(dec, n)
		sum = 0
		if @tens[dec]
			sum = (n+1)*@tens[dec].length + @digits[0..n].map { |num| num ? num.length : 0 }.inject(:+)
		end
		sum
	end

	def sum_of_century(cen, n)
		sum = 0
		if @digits[cen]
			sum = (n+1)*(@digits[cen].length + @hundred.length) + (n-1)*@and.length + self.sum_below_100(n)
		end
		sum
	end

	def sum_below_100(n)
		if not @sums[n]
			sum = self.sum_below_twenty(n)
			if n >= 20 and n < 100
				num = n
				digs = []
				while num > 9
					num, last_digit = num.divmod(10)
					digs << last_digit
				end
				digs << num
				sum += (2..digs[1]-1).map { |num| self.sum_of_decade(num, 10) }.inject(:+) + self.sum_of_decade(digs[1],digs[0])
			end
			@sums[n] = sum
		end
		@sums[n]
	end

	def sum_of_100
		if not @sums[100]
			@sums[100] = self.sum_below_100(99)+@hundred.length
		end
		@sums[100]
	end

	def sum_of_1000
		if not @sums[1000]
			@sums[1000] = self.sum_below_1000(999)+@thousand.length
		end
		@sums[1000]
	end

	def sum_below_1000(n)
		if not @sums[n]
			if n < 100
				sum = self.sum_below_100(n)
			elsif n < 1000
				sum = self.sum_of_100
				num = n
				digs = []
				while num > 9
					num, last_digit = num.divmod(10)
					digs << last_digit
				end
				digs << num
				sum += (2..digs[2]-1).map { |num| self.sum_of_century(num, 100) }.inject(:+) + self.sum_of_century(digs[2],digs[1]*10+digs[0])
			end
			@sums[n] = sum
		end
		@sums[n]
	end

	# not working... play with all the algorithms until they make sense
	# I suspect the issue is in the sum_of_century or sum_below_1000 methods...
	def count_chars
		time do
			ans = self.sum_of_1000
			puts "The sum of characters of the numbers 1 to #{@max} is #{ans}."
		end
	end

end

p = Prob17.new(1000)
puts p.count_chars