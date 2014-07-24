puts <<EOF

Notes for the Ruby language
Wyncode cohort 2, July-September 2014
burt rosenberg

created: 23 Jul 2014
last-update: 23 Jul 2014
EOF

puts
puts "How many spaces are in a tab?"

def te()
  printf "%s", "123412341234\n"
  printf "%s", "1234\t1234\n"
  printf "%s", "12341\t1234\n"
  printf "%s", "123412\t1234\n"
  printf "%s", "1234123\t1234\n"
end
te

puts
puts "White space gotcha's"

a = 4
b = 2
def c(x)
  4
end
t1 = c (a)/b
t2 = c(a)/b
t3 = c (a) /b
printf "c (a)/b = #{t1}, c(a)/b = #{t2}, c (a) /b = #{t3}\n"


puts
puts "Even standard classes are monkey patched (singleton's)"
def sd(s1,s2)
  (s1-s2) | (s2-s1)
end
print "The symmetric difference between Symbol.methods and Object methods is #{sd Symbol.methods, Object.methods}\n" # => [:all_symbols, :new] 
print "Symbol.respond_to? :new = #{Symbol.respond_to? :new}, Symbol.respond_to? :all_symbols = #{Symbol.respond_to? :all_symbols}\n"
print "Object.respond_to? :new = #{Object.respond_to? :new}, Object.respond_to? :all_symbols = #{Object.respond_to? :all_symbols}\n"

puts
puts "Without the parenthesis this does not compile (thanks to Ed Toro for the example)."
puts ({a:'a'})  #puts {a:'a'} => syntax error, unexpected ':', expecting '}'puts {a:^'a'}

puts
puts "Wrong way (but common way) to write the hash override"
class A
  attr_accessor :b, :c
  def hash()
    b.hash ^ c.hash
  end
  def eql?(oo)
    self.hash == oo.hash
  end
  
  # a questionable proposal, don't thing the double shift and xor is invertible
  def hash_x()
    bh = b.hash
    ch = c.hash
    (bh<<1)^(bh>>1)^(ch<<2)^(ch>>2)
  end
end

a1 = A.new
a2 = A.new
a1.b = 1
a1.c = 2
a2.b = 2
a2.c = 1
print "a1.hash = #{a1.hash}, a2.hash = #{a2.hash}\n"
print "a1 == a2 is #{a1==a2}\n"
print "a1.eql? a2 is #{a1.eql? a2}\n"
print "[a1,a2].uniq => #{[a1,a2].uniq}\n"

puts
puts "next is not the same as the ascii successor"
c = 'A'
40.times { |i| 
  print "#{c} "
  c = c.next
}
puts

puts
puts "ranges don't seem to be consistent"
def r_next(a)
  (a..a.next).count
end

def r_succ(a)
  (a..a.succ).count
end


[:a,:z,:aa,"a","z","aa"].each do |t|
  puts "range of #{t}(type #{t.class}) to #{t}.next has #{r_next t} items\n"
  if ( (r_next t) != (r_succ t) )
    puts "ASSERT FAIL: #next and #succ aren't equal"
  end
end
puts "Sometimes you can get range to be consistent with character mapping"
p ("\0".."~").to_a # in this range they use codepoints, not all do they use codepoints
puts "Sometimes you can get range to use the lexi ordering"
p ("z".."za").to_a # this works using the #next ordering, not codepoints




