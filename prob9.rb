# not terrible, I hope => 0.02889 s
def prob9
	time do
		sol = false
		for a in 1..(1000/3).div(1)-1
			for b in a+1..((1000-a)/2).div(1)-1
				if 500000 - 1000*a - 1000*b + a*b == 0
					sol_a = a.to_s
					sol_b = b.to_s
					sol_c = (1000-a-b).to_s
					prod = a*b*(1000-a-b)
					puts "The product of #{sol_a}, #{sol_b}, and #{sol_c} is #{prod}."
					sol = true
				end
				if sol
					break
				end
			end
			if sol
				break
			end
		end
	end
end

# holy crap, 4.917e-5 s
def prob9Mod(s)
	time do
		sol = false
		s2 = s.div(2)
		mlimit = Math.sqrt(s2).div(1)
		for m in 2..mlimit
			if s2 % m == 0 then
				sm = s2.div(m)
				while sm % 2 == 0
					sm = sm.div(2)
				end
				if m % 2 == 1
					k = m + 2
				else
					k = m + 1
				end
				while k < 2*m && k <= sm
					if sm % k == 0 and k.gcd(m) == 1
						d = s2.div(k*m)
						n = k - m
						a = d*(m**2 - n**2)
						b = 2*d*m*n
						c = d*(m**2 + n**2)
						puts "The product of #{a}, #{b}, and #{c} is #{a*b*c}."
						sol = true
						break
					end
					k += 2
				end
			end
			if sol
				break
			end
		end
	end
end