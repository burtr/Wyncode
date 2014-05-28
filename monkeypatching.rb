#
# Monkey patching the global object
#
# author: burt rosenberg
# created: may 2014
#

module SomeMethods
    
    def f
        "hello " + self
    end
    
end

puts

puts "Before include:"
puts "  \"hi\".respond_to?(:f) => #{"hi".respond_to?(:f)}" # prints false
puts "  Object.new.respond_to?(:f) => #{Object.new.respond_to?(:f)}" # prints false

include SomeMethods

puts "After include:"
puts "  \"hi\".respond_to?(:f) => #{"hi".respond_to?(:f)}" # prints true
puts "  Object.new.respond_to?(:f) => #{Object.new.respond_to?(:f)}" # prints true

puts
puts "Monkey patch!"
puts

class UsesMethod
    
    def initialize
        @ss = ['1','2','3']
    end
    
    def g
        @ss.each do |s|
            puts s.f
        end
    end
end

UsesMethod.new.g

# prints:

#  hello 1
#  hello 2
#  hello 3

