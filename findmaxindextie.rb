#!/usr/local/bin/ruby

# find the max element, return the index thereof, noting if there is a tie
# author: bjr
# created: may 2014


def max_by_index_ties(a)
   return nil if (!a.is_a?(Array) || a.length<1 ) 
   i, *r = a.inject([0,a[0]-1,-1,false]) do |s,e|
       if e>s[1]
         # new max
         s[1], s[2], s[3] = e, s[0], false
       elsif e==s[1]
         s[3] = true
       end
     s[0] += 1
     s
     end
  r
end

def max_by_index_ties_alt(a)
   return nil if (!a.is_a?(Array) || a.length<1 )
   m = a[0]-1
   has_tie = false
   max_at = -1
   a.each_with_index do |e,i| 
       if e>m
         # new max
         m, max_at, has_tie = e, i, false
       elsif e==m
         has_tie = true
       end
   end
   [m,max_at,has_tie]
end




def test
	p max_by_index_ties(nil)
	p max_by_index_ties([])
	p max_by_index_ties(1)
	p max_by_index_ties("hello world")

	p max_by_index_ties([ 5,3,10,4,2,10,7,4,8,9])
	p max_by_index_ties([ 5,3,10,4,2,7,4,8,9])
	p max_by_index_ties([ 20,5,3,10,4,2,10,7,4,8,9])
	p max_by_index_ties([1])
	p max_by_index_ties([1,1])
	p max_by_index_ties([1,2])
	p max_by_index_ties([2,1])
end


def test_alt
	p max_by_index_ties_alt(nil)
	p max_by_index_ties_alt([])
	p max_by_index_ties_alt(1)
	p max_by_index_ties_alt("hello world")

	p max_by_index_ties_alt([ 5,3,10,4,2,10,7,4,8,9])
	p max_by_index_ties_alt([ 5,3,10,4,2,7,4,8,9])
	p max_by_index_ties_alt([ 20,5,3,10,4,2,10,7,4,8,9])
	p max_by_index_ties_alt([1])
	p max_by_index_ties_alt([1,1])
	p max_by_index_ties_alt([1,2])
	p max_by_index_ties_alt([2,1])
end


test
test_alt
