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
