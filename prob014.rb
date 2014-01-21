#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob14

	def initialize(num_limit)
		@num_limit = num_limit
		@chain_lengths = {}
		@max_length = 0
		@max_num = 0
	end

	def collatz_length(n)
		if !@chain_lengths[n]
			if n == 1
				@chain_lengths[n] = 1
			elsif n % 2 == 0
				@chain_lengths[n] = 1+self.collatz_length(n/2)
			else
				@chain_lengths[n] = 1+self.collatz_length(3*n+1)
			end
		end
		@chain_lengths[n]
	end

	def print_chain_length(n)
		s = @chain_lengths[n] ? "The chain length for #{n} is #{@chain_lengths[n]}." : "The chain length for #{n} has not been evaluated."
		puts s
	end

	# not bad, 3.157 s
	def longest_chain
		time do
			(1..@num_limit).each do |num|
				if self.collatz_length(num) > @max_length
					@max_num = num
					@max_length = @chain_lengths[num]
				end
			end
			puts "The maximum collatz chain length starting below #{@num_limit} is #{@max_length} starting with #{@max_num}."
		end
	end

end

p = Prob14.new(1000000)
p.longest_chain