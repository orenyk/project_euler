def prob1(max)
	# ORIGINAL ANSWER... SLOW
	# sum = 0
	# for num in 1..max-1 do
	# 	if num % 3 == 0 || num % 5 == 0
	# 		sum = sum + num
	# 		puts "#{num}, #{sum}"
	# 	end
	# end
	# sum

	# NEW ANSWER... MUCH BETTER
	sumDivisibleBy(max, 3) + sumDivisibleBy(max, 5) - sumDivisibleBy(max, 15)
	# it would be cool to write a function taking in a list of factors and correctly subtracting the shared numbers
end

def sumDivisibleBy(max, factor)
	p = max.div(factor)
	factor*(p*(p+1)).div(2)
end
