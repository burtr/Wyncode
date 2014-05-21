#!/usr/local/bin/ruby

# reversible array implementation
# author: burt rosenberg
# created: may 2014



class ReversableArray < Array

	def initialize
		@a = Array.new
		@is_reversed = false
	end

	def reverse_array
		@is_reversed = not(@is_reversed)
	end
	
	def get(i)
		len = @a.length
		@is_reversed ? @a[len-i-1] : @a[i]
	end
	
	def set(i,v)
		len = @a.length
		i = @is_reversed ? len-i-1 : i
		@a[i] = v	
	end

end


ra = ReversableArray.new
(0..4).each { |i| ra.set(i,i) }
(0..4).each { |i| print " #{ra.get(i)}" }
puts
ra.reverse_array
(0..4).each { |i| print " #{ra.get(i)}" }
puts
(0..4).each { |i| ra.set(i,i) }
(0..4).each { |i| print " #{ra.get(i)}" }
puts
ra.reverse_array
(0..4).each { |i| print " #{ra.get(i)}" }
puts



