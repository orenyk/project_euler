#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob15

	def initialize(size)
		@size = size
		@routes = {}
		@routes[0] = 0
		@routes[1] = 2
		@routes_2 = {}
		@routes_2[[1,0]] = 1
	end

	def calc_routes(n)
		if !@routes[n]
			# not quite right, we need to take into account all the paths that go along the sides for some period of time... keep pushing
			# the key was probably not assuming only square boards, i.e. generalizing to all rectangular boards, see below
			@routes[n] = 2*self.calc_routes(n-1) + 2*(self.calc_routes(n-1)-1)
			puts "#{n}x#{n} : #{@routes[n]}"
		end
		@routes[n]
	end

	def solve
		time do
			ans = self.calc_routes(@size)
			puts "The number of routes through a #{@size}x#{@size} grid is #{ans}."
		end
	end

	def solve_biro
		time do
			#some answer involving combinatorics
		end
	end

	# pretty fast, 0.00253 s
	def solve_biro_recursion
		time do
			ans = self.biro_recursion(@size, @size)
			puts "The number of routes through a #{@size}x#{@size} grid is #{ans}."
		end
	end

	def biro_recursion(m, n)
		if m == 0 or n == 0
			return 1
		elsif !@routes_2[[m, n]] && !@routes_2[[n, m]]
			@routes_2[[m, n]] = self.biro_recursion(m-1, n) + self.biro_recursion(m, n-1)
		end
		@routes_2[[m, n]] ? @routes_2[[m, n]] : @routes_2[[n, m]]
	end

end

p = Prob15.new(20)
p.solve_biro_recursion
