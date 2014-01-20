require_relative 'euler_helper'

# we can brute force this and just go through numbers... 7.1064 s
# down to 5.674 s if we limit our search to sqrt(n)
def prob7(n)
	time do
		primes = [2,3]
		while primes.length < n
			primes = next_prime(primes)
		end
		puts "Prime \##{n} is #{primes.last}"
	end
end

# let's see how much faster this is... damn, 0.107 s
def prob7Mod(n)
	time do
		count = 1
		candidate = 1
		while count < n
			candidate += 2
			if isPrimeMod(candidate)
				count += 1
			end
		end
		puts "Prime \##{n} is #{candidate}"
	end
end