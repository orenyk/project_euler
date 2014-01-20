require_relative 'euler_helper'

# not bad, only 0.00054 s
def prob6(k)
	time do
		out = 0
		for i in 1..k
			for j in i+1..k
				out = out + 2* i * j
			end
		end
		puts "#{out} is the difference between the sum of squares and square of the sum of 1 to #{k}."
	end
end

# stupid smart math people, faster: 4.05e-05 s
def prob6Mod(k)
	time do
		sum = k * (k + 1) / 2
		sum_sq = (2 * k + 1) * (k + 1) * k / 6
		out = sum**2 - sum_sq
		puts "#{out} is the answer."
	end
end