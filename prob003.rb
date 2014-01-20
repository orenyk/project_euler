require_relative 'euler_helper'

def prob3
	time do
		n = 600851475143
		# we know the number is not prime, so we can stick w/ odd factors
		
		# OLD SOLUTION... SLOW 0.0586s
		# fs = odd_factors(n).sort! { |x, y| y <=> x }
		# for fact in fs do
		# 	if isPrime(fact)
		# 		puts "The largest prime factor is #{fact}"
		# 		break
		# 	end
		# end

		# NEW SOLUTION 0.000144s, still not quite as fast as Mod (0.000108s) - this is probably because we're storing all of the prime factors instead of just the last one
		fs = prime_factors(n)
		puts "The largest prime factor is #{fs.last}"
	end
end

# function based on explanation from site
def prob3Mod
	time do
		n = 600851475143
		# use the method from the explanation, dividing out factors as many times as possible
		if n % 2 == 0
			n = n.div(2)
			lastFact = 2
			while n % 2 == 0
				n = n.div(2)
			end
		else
			lastFact = 1
		end
		fact = 3
		factMax = Math.sqrt(n)
		while n > 1 && fact < factMax
			if n % fact == 0
				n = n.div(fact)
				lastFact = fact
				while n % fact == 0
					n = n.div(fact)
				end
				factMax = Math.sqrt(n)
			end
			fact = fact + 2
		end
		if n == 1
			sol = lastFact
		else
			sol = n
		end
		puts "The largest prime factor is #{sol}"
	end
end