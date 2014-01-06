require_relative 'euler_helper'

def prob5 # not bad, 0.7898 s
	time do
		# calculate maximum number
		maxnum = 1
		for i in 11..20
			maxnum = maxnum * i
		end
		# calculate the minimum number
		minnum = 2*3*5*7*11*13*17*19
		num = minnum*2
		sol = maxnum
		while num < sol
			if num % 19 == 0
				if num % 18 == 0
					if num % 17 == 0
						if num % 16 == 0
							if num % 15 == 0
								if num % 14 == 0
									if num % 13 == 0
										if num % 12 == 0
											if num % 11 == 0
												sol = num
												puts "The solution is #{num}."
											end
										end
									end
								end
							end
						end
					end
				end
			end
			num = num + 20
		end
		sol
	end
end

# based on solution, faster (0.00015 s)
def prob5Mod(k)
	time do
		num = 1
		# don't forget that arrays in ruby are indexed from zero!
		i = 0
		a = []
		check = true
		limit = Math.sqrt(k)
		while primes1000[i] <= k
			a[i] = 1
			if check then
				if primes1000[i] <= limit
					a[i] = (Math.log(k)/Math.log(primes1000[i])).floor
				else
					check = false
				end
			end
			num = num * primes1000[i]**a[i]
			i = i + 1
		end
		puts "The solution is #{num}"
	end
end