#!/usr/local/bin/ruby

# Counting Sort
# author: burt rosenberg
# created: may 2014

numbers = (ARGF.read.split.collect { |s| s.to_i }).select { |i| i>= 0 }

counting = []
numbers.each { |n| counting[n] = (counting[n]==nil) ? 1 : counting[n]+1 }

counting.each_index { |i| if i==0 then 
      counting[0] = (counting[0]==nil) ? 0 : counting[0]
    else 
      counting[i] = (counting[i]==nil) ?  counting[i-1] : counting[i-1] + counting[i] 
    end 
}
    
sortednumbers = []
numbers.each { |n| counting[n] -= 1 ; sortednumbers[counting[n]] = n  }

sortednumbers.each { |n| print "#{n} " }
puts

# end of code
