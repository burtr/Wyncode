
# program to test the use of self
#
# author: burt rosenberg
# created: may 2014

module SomeMethods
    
    def f
        "hello " + self
    end
    
end

include SomeMethods

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

