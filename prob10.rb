require_relative 'euler_helper'

# based on problem 7, 4.5836 s
def prob10(max_prime)
	time do
		sum = 5 # 2 and 3 are known
		candidate = 5
		while candidate <= max_prime
			if isPrimeMod(candidate)
				sum += candidate
			end
			candidate += 2
			if isPrimeMod(candidate)
				sum += candidate
			end
			candidate += 4
		end
		puts "The sum of all primes below #{max_prime} is #{sum}."
	end
end

# based on fancy math!
def prob10Mod(max_prime)
	time do
		puts "stuff"
	end
end