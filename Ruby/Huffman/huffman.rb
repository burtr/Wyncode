#!/usr/local/bin/ruby

# Huffman coding in ruby
# author: burt rosenberg
# created: may 2014

# node class and a bunch of methods to 
# print out the results

USAGE = "Usage: huffman filename"

class N
  attr_accessor :l, :r, :w, :c, :isleaf
  
  def initialize
  	yield self if block_given?
  end
  
  def codeprint
    codeprint_aux('')
  end
  
  def codeprint_aux(path)
    if isleaf then
      puts c + ": " + path
    else
      l.codeprint_aux(path+"0") # why is it understood @l.codeprint_aux?
      r.codeprint_aux(path+"1")
    end
  end
  
  def averageweight
    Float(totalweight_a(0))/Float(w)
  end

  def totalweight
    totalweight_a(0)
  end
  
  def totalweight_a(d)
    if isleaf then
      d * w
    else
      l.totalweight_a(d+1) + r.totalweight_a(d+1)
    end
  end
  
end

# parse input

leaves = []

begin
  open(ARGV[0],'r') do |f|
    f.each_line do |l|
      l.match(/(\w+)\s+(\d+)/) do |md|
        n = N.new
        n.c = md[1]
        n.w = md[2].to_i # to handle formatting errors better
        n.isleaf = true
        leaves = leaves << n
      end
    end
    f.close
  end
rescue Exception => e  
  print e
  puts
  puts USAGE
  exit
end

# the huffman algorithm
# see http://www.igvita.com/2009/03/26/ruby-algorithms-sorting-trie-heaps/ for
# improved data structure

while leaves.length>1 do
  leaves.sort! { |a,b| a.w <=> b.w } # only two of lowest weight needed
  leaves <<  N.new do |c| 
    c.l = a = leaves.shift
    c.r = b = leaves.shift
    c.w = a.w + b.w
    c.isleaf = false
  end
end

# report results

ht = leaves.shift
ht.codeprint
puts "average wieght = #{ht.averageweight}"

