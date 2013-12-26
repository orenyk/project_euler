require_relative 'euler_helper'

def prob2
		time do
		# every third fibonacci number is even starting w/ 2, so n%3 == 2
		sum = 0
		max = 4000000
		n = 1

		# ORIGINAL SOLUTION, NOT BAD
		# while fibonacci(n) < max
		# 	sum = sum + fibonacci(n)
		# 	n = n + 3
		# end

		while even_fibonacci(n) < max
			sum = sum + even_fibonacci(n)
			n = n + 1
		end

		puts "The answer is #{sum}"
	end
end