# time wrapper for execution timing
def time
	start = Time.now
	yield
	t = Time.now - start
	puts "#{t} s elapsed"
end

# recursive function for the Fibonacci series
def fibonacci(n)
	if n == 0 || n == 1
		return 1
	else
		return fibonacci(n-1) + fibonacci(n-2)
	end
end	

# recursive function for even Fibonacci numbers
def even_fibonacci(n)
	if n == 0
		return 0
	elsif n == 1
		return 2
	else
		return 4*even_fibonacci(n-1)+even_fibonacci(n-2)
	end
end

# function to find only odd factors of a number
def odd_factors(n)
	fmax = Math.sqrt(n).div(1)
	fs = []
	i = 1
	# search for factors
	while 2*i + 1 < fmax
		fact = 2 * i + 1
		if n % fact == 0
			fs.push(fact)
			fs.push(n / fact)
		end
		i = i + 1
	end
	# check for factors
	if not fs.empty?
		fs.sort!
	else
		fs = nil
	end
	fs
end

# function to find only even factors of a number
def even_factors(n)
	fmax = Math.sqrt(n).div(1)
	i = 2
	# check for even
	if n % 2 == 1
		fs = nil
	# search for factors
	else
		fs = []
		fs.push(2)
		fs.push(n / 2)
		while 2*i < fmax
			fact = 2 * i
			if n % fact == 0
				fs.push(fact)
				fs.push(n / fact)
			end
			i = i + 1
		end
		fs.sort!
	end
	fs
end

# function to check if a number is prime by checking the factor arrays
def isPrime(n)
	# check for even
	if n % 2 == 0 && n > 2
		return false
	# check for odd factors
	else
		odd_fs = odd_factors(n)
		if odd_fs.nil?
			return true
		else
			return false
		end
	end
end

# function to divide out factors completely
def div_factor(n, fact)
	# check to make sure it's a factor
	if n % fact == 0
		while n % fact == 0
			n = n.div(fact)
		end
	end
	n
end

# function to find prime factors
def prime_factors(n)
	fps = []
	# check for even
	if n % 2 == 0
		fps.push(2)
		n = div_factor(n, 2)
	end
	# check odd factors
	fact = 3
	maxFact = Math.sqrt(n)
	while n > 1 && fact < maxFact
		if n % fact == 0
			fps.push(fact)
			n = div_factor(n, fact)
			maxFact = Math.sqrt(n)
		end
		fact = fact + 2
	end
	if n > fps.last
		fps.push(n)
	end
	fps.sort!
end