#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob12

	def initialize(num_divisors)
		@num_divisors = num_divisors
		@sol = 1
		@prime_list = [2]
	end

	def generate_primes(max_prime)
		candidate = 1
		while candidate <= max_prime
			if isPrimeMod(candidate)
				@prime_list.push(candidate)
			end
			candidate += 2
		end
	end

	def find_solution
		time do
			last_count = 2
			n = 2
			while last_count <= @num_divisors
				t = Triangle.new(n)
				new_count = t.count_divisors
				last_count = last_count < new_count ? new_count : last_count
				n += 1
			end
			@sol = t.val
			puts "The first triangle number with more than #{@num_divisors} divisors is #{@sol}."
		end
	end
	
	# damn, 9.755 s!  Prime list is way faster
	def find_solution_mod
		time do
			self.generate_primes(65500)
			last_count = 2
			n = 2
			while last_count <= @num_divisors
				t = Triangle.new(n)
				new_count = t.count_divisors_mod(@prime_list)
				last_count = last_count < new_count ? new_count : last_count
				n += 1
			end
			@sol = t.val
			puts "The first triangle number with more than #{@num_divisors} divisors is #{@sol}."
		end
	end

	# holy crap! 0.03838 s
	def find_solution_mod2
		time do
			self.generate_primes(1000)
			n = 3
			divs_n = 2
			count = 0

			while count <= 500
				n = n+1
				n1 = n
				if n1 % 2 == 0
					n1 = n/2
				end
				divs_n1 = 1
				@prime_list.each do |prime|
					if prime*prime > n1
						divs_n1 = 2*divs_n1
						break
					end
					exp = 1
					while n1 % prime == 0
						exp += 1
						n1 = n1/prime
					end
					if exp > 1
						divs_n1 *= exp
					end
					if n1 == 1
						break
					end
				end
				count = divs_n*divs_n1
				divs_n = divs_n1
			end
			@sol = n*(n-1)/2
			puts "The first triangle number with more than #{@num_divisors} divisors is #{@sol}."
		end
	end

end

class Triangle

	def initialize(n)
		@n = n
		@val = (@n*(@n+1))/2
		@prime_factors = {}
		@divisor_count = 0
	end

	# too slow, we don't need to check all numbers, just primes
	def count_divisors
		# factor out all the 2s
		num = @val
		if num % 2 == 0
			@prime_factors[2] = 0
			while num % 2 == 0
				@prime_factors[2] += 1
				num = num.div(2)
			end
		end
		# num is now the product of the remaining factors, now we can step through odd factors similarly
		fact = 3
		while fact <= Math.sqrt(@val).div(1)
			if isPrimeMod(fact) and num % fact == 0
				@prime_factors[fact] = 0
				while num % fact == 0
					@prime_factors[fact] += 1
					num = num.div(fact)
				end
			end
			fact += 2
		end
		if @prime_factors.empty?
			@prime_factors[num] = 1
		elsif num > @prime_factors.sort.last[0]
			@prime_factors[num] = 1
		end
		# use prime factor counts to evaluate divisor count
		exps_plus_one = []
		@prime_factors.each do |key, val|
			exps_plus_one.push(val + 1)
		end
		@divisor_count = exps_plus_one.reduce(1, :*)
		@divisor_count
	end

	def count_divisors_mod(prime_list)
		if prime_list.include?(@val)
			@prime_factors[@val] = 1
		else
			num = @val
			prime_list.each do |prime|
				if prime > Math.sqrt(@val).div(1)
					break
				elsif num % prime == 0
					@prime_factors[prime] = 0
					while num % prime == 0
						@prime_factors[prime] += 1
						num = num.div(prime)
					end
				end
			end
			if @prime_factors.empty?
				@prime_factors[num] = 1
			elsif num > @prime_factors.sort.last[0]
				@prime_factors[num] = 1
			end
		end
		# use prime factor counts to evaluate divisor count
		exps_plus_one = []
		@prime_factors.each do |key, val|
			exps_plus_one.push(val + 1)
		end
		@divisor_count = exps_plus_one.reduce(1, :*)
		@divisor_count
	end

	def print_prime_factorization
		s = ""
		@prime_factors.sort.each do |key, val|
			s += "#{key}^#{val}*"
		end
		puts s.chop!
	end

	def val
		@val
	end

end

# t = Triangle.new(5)
# puts t.val
# puts t.count_divisors
# t.print_prime_factorization
p0 = Prob12.new(500)
p0.find_solution
p1 = Prob12.new(500)
p1.find_solution_mod
p2 = Prob12.new(500)
p2.find_solution_mod2