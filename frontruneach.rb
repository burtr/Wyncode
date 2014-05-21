#!/usr/local/bin/ruby

# front-running each

class Object
  def superclasses
    # your code here
    a = [self.superclass]
    a.each { |c| c.superclass and a << c.superclass }
    a
  end
end

