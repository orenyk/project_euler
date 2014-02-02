#!/usr/bin/env ruby

require_relative 'euler_helper'

class Prob18

	# arbitrary triangle initialization
	def initialize(filename)
		# read in triangle, we're assuming it's valid
		@filename = filename
		f = File.open(@filename)
		@tri = f.each_line.map { |line|
			line.split(' ').map(&:to_i)
		}
		f.close
		@rows = @tri.length

		# store some solution information
		@max_sol = 0
		@sols_in_progress = {}
		@sols_completed = {}
	end

	def print_triangle
		s = ""
		@tri.each do |line|
			line.each do |cell|
				s += "%02d " % cell
			end
			s += "\n"
		end
		puts s
	end

	def next_step(path)
		old_row = path.length - 1
		old_pos = path[path.length - 1]

		# select new row
		new_row = old_row + 1
		# extract possible next values
		new_vals = [@tri[new_row][old_pos], @tri[new_row][old_pos + 1]]
		# find best next choice
		max_new_val = new_vals.max
		# select next position
		best_new_pos = new_vals[0] == max_new_val ? old_pos : old_pos + 1
		best_new_path = path + [best_new_pos]
		other_new_pos = new_vals[0] == max_new_val ? old_pos + 1 : old_pos
		other_new_path = path + [other_new_pos]
		# check for existing solution
		# first, if best path has already been checked
		if @sols_in_progress[best_new_path]
			# see if alternative path has been checked
			if not @sols_in_progress[other_new_path]
				# save alternative path
				new_path = other_new_path
			else
				# clear current path point
				@sols_in_progress[path] = 0
				return nil
			end
		else
			# save best path
			new_path = best_new_path
		end
		# if we're at the end, store the final path sum and clear the route in the progress hash
		if new_path.length == @rows
			@sols_completed[new_path] = @sols_in_progress[path] + @tri[new_row][new_path[new_row]]
			@sols_in_progress[new_path] = 0
			# if new path is greatest, update max_sol
			if new_path == @sols_completed.max_by { |k, v| v }.first
				@max_sol = @sols_completed[new_path]
				puts "#{@max_sol}"
			end
			return nil
		# otherwise, just move foreward
		else
			new_sum = @sols_in_progress[path] + @tri[new_row][new_path[new_row]]
			if @max_sol > 0 and @max_sol-new_sum < (@rows - new_path.length)*70
				@sols_in_progress[new_path] = 0
			else
				@sols_in_progress[new_path] = new_sum
			end
		end
		# return new path
		new_path
	end

	# def find_max_path
	# 	time do
	# 		first_path = [0]
	# 		row = 0
	# 		@sols_in_progress[first_path] = @tri[row][first_path[row]]
	# 		sol_found = false
	# 		cur_path = first_path
	# 		while not sol_found
	# 			# find next best path
	# 			cur_path = @sols_in_progress.max_by { |k, v| v }.first
	# 			# evaluate next step
	# 			self.next_step(cur_path)

	# 			# if we have 10 completed paths
	# 			if @sols_completed.length == 3000
	# 				# check best path for viability
	# 				viability = {}
	# 				@sols_in_progress.keys.each do |temp_path|
	# 					if @max_sol - @sols_in_progress[temp_path] > (@rows - temp_path.length)*70
	# 						viability[temp_path] = false
	# 					end
	# 					viable = viability.values.inject { |log, v| log or v }
	# 					sol_found = ! viable
	# 				end
	# 			end
	# 		end

	# 		puts "#{@sols_completed.max_by {|k, v| v }.first}"
	# 		puts "The maximum total of the given triangle is #{@max_sol}."
	# 	end
	# end

	# super fast, makes way more sense, 0.000139 s
	# inspired by http://algorithmsbyme.wordpress.com/2012/05/31/maximum-sum-from-top-to-bottom-path-of-a-given-triangle/
	def find_max_path
		time do
			# we have to end at one of the bottom nodes, so work bottom-up
			(@rows-2).step(0, -1) do |row|
				(0..row).each do |pos|
					@tri[row][pos] += [@tri[row+1][pos], @tri[row+1][pos+1]].max
				end
			end
			puts "the maximum sum is #{@tri[0][0]}."
		end
	end
end

p = Prob18.new('prob018.txt')
p.find_max_path