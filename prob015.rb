#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob15

	def initialize(size)
		@size = size
		@routes = {}
		@routes[0] = 0
		@routes[1] = 2
	end

	def calc_routes(n)
		if !@routes[n]
			# not quite right, we need to take into account all the paths that go along the sides for some period of time... keep pushing
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

end

p = Prob15.new(20)
p.solve