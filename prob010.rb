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
# take 1 = 0.756273318 s
def prob10Mod(max_prime)
	time do
		crosslimit = Math.sqrt(max_prime).div(1)
		sieve = Array.new(crosslimit, false)
		n = 4
		while n < max_prime
			sieve[n] = true
			n += 2
		end
		n = 3
		while n < max_prime
			if not sieve[n]
				m = n**2
				while m < max_prime
					sieve[m] = true
					m += 2*n
				end
			end
			n += 2
		end
		sum = 0
		for num in 2..max_prime
			if not sieve[num]
				sum += num
			end
		end
		puts "The sum of all primes below #{max_prime} is #{sum}."
	end
end

# based on fancy math and ignoring even numbers
# take 1 = 0.646775978 s
def prob10Mod2(max_prime)
	time do
		bound = (max_prime-1).div(2)
		sieve = Array.new(bound, false)
		crosslimit = (Math.sqrt(max_prime).div(1)-1).div(2)
		for i in 1..crosslimit
			if not sieve[i]
				for j in 2*i*(i+1)..bound
					sieve[j] = true
				end
			end
		end
		sum = 2
		for i in 1..bound
			if not sieve[i]
				sum += (2*i+1)
			end
		end
		puts "The sum of all primes below #{max_prime} is #{sum}."
	end
end