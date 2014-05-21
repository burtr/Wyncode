#!/usr/local/bin/ruby


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



# closures

def a
  i = 1 
  yield 
  return "from a #{i}"
end

def b
  i = 2 
  a { return "from b #{i}" }
end
 
def al(l)
  puts "l.call in al returns #{l.call}"
  return "from al"
end
 
#puts b

class C
  
  def initialize
    @c = 0
    @l = lambda { return @c } 
  end
  
  def inc_c
    @c = @c+1
  end
  
  def c
    a { return "from c #{@c}" }
  end

  def d
    al @l
  end
    
end

puts a {}
puts b
puts al(lambda { 6 })

c = C.new
puts c.c  # 0
c.inc_c
puts c.c # 1
c.inc_c
puts c.c # 2
puts "c.d = #{c.d}"
c.inc_c
puts "c.d = #{c.d}"

=begin
puts "puts self is: #{self}"
puts "puts self.class is: #{self.class}"
puts "puts (self.methods - self.class.methods)"
puts (self.methods - self.class.methods)
puts
puts "puts (self.class.methods - self.methods)"
puts (self.class.methods - self.methods)
puts
=end

=begin
o = Object.new 
puts "puts (self.class.methods - self.methods)"
puts (o.methods - self.methods)
puts
puts "puts (self.methods - o.methods)"
puts (self.methods - o.methods)
puts

#check out self.class.methods and Object.methods
puts self.class.methods == Object.methods # returns true
# check out of self has a new
puts self.respond_to? :new  # returns false

=end


# front-running each

class Object
  def superclasses
    # your code here
    a = [self.superclass]
    a.each { |c| c.superclass and a << c.superclass }
    a
  end
end


# how Ruby does classes

class C
  @@i = 1
end

C.object_id # gives an object_id
C.class # gives "class"
C.class_variables # => [:@@i]

# the class def (1) creates a constant C, (2) loads C with reference to an object
# (3) that object of type Class, (4) which represents the class always

C.new.class.object_id == C.object_id # => true


