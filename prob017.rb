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
		n_temp = [19, n].min
		if not @sums[n_temp]
			sum = 0
			@digits[0..n_temp].each do |num|
				sum += num ? num.length : 0
			end
			@sums[n_temp] = sum
		end
		@sums[n_temp]
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
			sum = (n+1)*(@digits[cen].length + @hundred.length) + (n)*@and.length + self.sum_below_100(n)
		end
		sum
	end

	def sum_below_100(n)
		n_temp = [99, n].min
		if not @sums[n_temp]
			sum = self.sum_below_twenty(n_temp)
			if n_temp >= 20
				num = n_temp
				digs = []
				while num > 9
					num, last_digit = num.divmod(10)
					digs << last_digit
				end
				digs << num
				sum += (0..digs[1]-1).map { |num| self.sum_of_decade(num, 9) }.inject(:+) + self.sum_of_decade(digs[1],digs[0])
			end
			@sums[n_temp] = sum
		end
		@sums[n_temp]
	end

	def sum_of_100
		if not @sums[100]
			@sums[100] = self.sum_below_100(99)+@digits[1].length + @hundred.length
		end
		@sums[100]
	end

	def sum_of_1000
		if not @sums[1000]
			@sums[1000] = self.sum_below_1000(999)+@digits[1].length + @thousand.length
		end
		@sums[1000]
	end

	def sum_below_1000(n)
		n_temp = [999, n].min
		if not @sums[n_temp]
			sum = self.sum_below_100(n_temp)
			if n_temp >= 100
				num = n_temp
				digs = []
				while num > 9
					num, last_digit = num.divmod(10)
					digs << last_digit
				end
				digs << num
				sum += (0..digs[2]-1).map { |num| self.sum_of_century(num, 99) }.inject(:+) + self.sum_of_century(digs[2],digs[1]*10+digs[0])
			end
			@sums[n_temp] = sum
		end
		@sums[n_temp]
	end

	def count_n(n)
		sum = 0
		if n == 1000
			return @digits[1].length + @thousand.length
		end
		num_temp = [999, n].min
		num = num_temp
		digs = []
		while num > 9
			num, last_digit = num.divmod(10)
			digs << last_digit
		end
		digs << num
		if digs[2]
			# print @digits[digs[2]]+" #{@hundred}"
			sum += @digits[digs[2]].length+@hundred.length
			# puts "hundreds: #{sum}"
			if digs[1] > 0 or digs[0] > 0
				# print " "+@and+" "
				sum += @and.length
				# puts "and: #{sum}"
			end
		end
		if digs[1] and digs[1] > 1
			# print @tens[digs[1]]+" #{@digits[digs[0]]}\n"
			sum += (@tens[digs[1]] ? @tens[digs[1]].length : 0) + (@digits[digs[0]] ? @digits[digs[0]].length : 0)
			# puts "double digits: #{sum}"
		elsif digs[1]
			tweens = digs[1]*10+digs[0]
			# print @digits[tweens]
			# print "\n"
			sum += @digits[tweens] ? @digits[tweens].length : 0
			# puts "below twenty: #{sum}"
		else
			sum += @digits[digs[0]] ? @digits[digs[0]].length : 0
			# puts "single digits: #{sum}"
		end
		sum
	end

	# not working... play with all the algorithms until they make sense
	# I suspect the issue is in the sum_of_century or sum_below_1000 methods...
	def count_chars
		time do
			ans = 0
			# much faster, 0.000126 s (order of magnitude reduction!)
			ans += self.sum_below_1000(@max)
			ans += @max == 1000 ? self.count_n(@max) : 0

			# brute force works, and pretty quickly, 0.00204 s
			# (1..@max).each do |num|
			# 	ans += self.count_n(num)
			# end
			puts "The sum of characters of the numbers 1 to #{@max} is #{ans}."
		end
	end

end

p = Prob17.new(1000) # the answer is 21124
puts p.count_chars