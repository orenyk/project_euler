require_relative 'euler_helper'

# old and slow ==> 0.458 s to check down to 555
def prob4(mult_min2)
	time do
		mult_max = 999
		mult_min = 100
		# mult_min2 = 666

		nums = []

		for i in mult_max.downto(mult_min2)
			for j in i.downto(mult_min2)
				nums.push(i*j)
			end
		end

		nums.sort! { |x,y| y <=> x }

		for num in nums
			pal = true
			num_str = num.to_s
			num_len = num_str.length
			num_mid = num_len / 2
			dig = 0
			while dig <= num_mid.floor
				if num_str[dig] != num_str[num_len - dig - 1]
					pal = false
				end
				dig = dig + 1
			end
			if pal
				sol = num
			end
		end

		if sol
			sol
		else
			nil
		end
	end
end

# based on faster answer ==> 0.0045 s
def prob4Mod
	time do
		sol = 0
		m1 = 999
		while m1 >= 100
			if m1 % 11 == 0
				m2 = 999
				dm2 = 1
			else
				m2 = 990 # largest multiple of 11
				dm2 = 11
			end
			while m2 >= m1
				num_test = m1 * m2
				if num_test <= sol
					break
				end
				if isPalindrome(num_test)
					sol = num_test
				end

				m2 = m2 - dm2
			end

			m1 = m1 - 1
		end

		puts "The solution is " + sol.to_s
	end
end