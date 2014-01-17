$num = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450
# $nums = [12345, 23456, 34567, 45678, 56789]

# this is definitely not elegant, 0.00263 s
def prob8(set_l)
	time do
		num_s = $num.to_s
		num_l = num_s.length
		sol_s = ""
		prod = 0
		i = 0
		while i < (num_l - set_l)
			test_s = num_s[i..i+set_l-1]
			test_prod = 1
			for j in 0..set_l-1
				test_prod *= test_s[j].to_i
			end
			if test_prod > prod
				prod = test_prod
				sol_s = test_s
			end
			i += 1
		end
		puts "The greatest product is #{prod} for #{sol_s}."
		# this was based on a false premise :-P
		# # calculate the products
		# prods = []
		# for set in $nums
		# 	set_s = set.to_s
		# 	for split in 0..3
		# 		n1 = set_s[0..0+split].to_i
		# 		n2 = set_s[split+1..4].to_i
		# 		prods.push(n1*n2)
		# 	end
		# end
		# prods.sort! { |x,y| y <=> x }
		# puts prods
		# num_s = $num.to_s
		# num_l = num_s.length
		# sol = nil
		# for prod in prods
		# 	prod_s = prod.to_s
		# 	prod_l = prod_s.length
		# 	i = 0
		# 	while i < (num_l - prod_l)
		# 		puts "#{num_s[i..i+prod_l-1]} - #{prod_s}"
		# 		if prod_s == num_s[i..i+prod_l-1]
		# 			sol = prod
		# 			puts "The largest product is #{sol}"
		# 			return
		# 		end
		# 		i += 1
		# 	end
		# end
	end
end