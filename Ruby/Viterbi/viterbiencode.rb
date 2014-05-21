#!/usr/local/bin/ruby

# convolutional encoder
# author: burt rosenberg
# created: may 2014

USAGE = "Usage: viterbiencode filename"
CODE_SEPARATOR = ' '
INTEXT_CLASS = /[^01]/

class P
  attr_accessor :poly
  
  def initialize
    yield self if block_given?
  end
  
  def convolve(x)
    # x is written with "most recent" bit rightmost
    # poly is written with "most recent" bit leftmost
    # normally, poly.length<=x.length, meaning all the history might not be used
    # we allow poly.length>x.length by effectively setting the history to 0
    
    z = false
    (0..[x.length,poly.length].min).each do |i|
      if poly[i]=='1' and x[-(i+1)]=='1' then
        z ^= true
      end
    end
    z ? '1' : '0'
  end
  
end


intext_a = []
poly_a = []
parsing = ''
codesep = ''

begin
  open(ARGV[0],'r') do |f|
    f.each_line do |l|
      case l

      when /^#/
        next
        
      when /^poly:/
        parsing = 'poly'
        
      when /^input:/ 
        parsing = 'input'
        
      when /^\s*-/
        case parsing  
        when 'poly'
          poly_a << l.gsub(INTEXT_CLASS,'')
        when 'input'
          intext_a << l.gsub(INTEXT_CLASS,'')
        end
      
      when /^\s+\S/
        case parsing
        when 'poly'
          poly_a.last << l.gsub(INTEXT_CLASS,'')
        when 'input'
          intext_a.last << l.gsub(INTEXT_CLASS,'')
        end

      when /^codesep: [Yy]/
        codesep = CODE_SEPARATOR
      
      when /^codesep: [Nn]/
        codesep = ''
      
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

polys = []
poly_a.each do |ps|
  polys << P.new { |p| p.poly = ps }
end

# force codesep true, because I'm lazy writing the code below
codesep = CODE_SEPARATOR

order = (polys.map { |p| p.poly.length } ).max

outtext_a = []
intext_a.each do |intext|

  # convolutional encoding 
  intext = '0'*(order-1) + intext
  outtext = ''
  (0..(intext.length-order)).each do |i|
     polys.each do |p|
       outtext << p.convolve(intext[i,order])
     end
     outtext << codesep
  end
  
  outtext_a << outtext
end

# viterbi decoding

class VT
  attr_accessor :distance, :order, :backtrace

  def s_to_s(o,s)
    "%0#{o-1}b"%s
  end
  
  def initialize(order)
    @distance = Hash.new
    @backtrace = Hash.new
    @order = order
  end
  
  def firststate
    distance[s_to_s(order,0)] = 0
    backtrace[s_to_s(order,0)] = ''
    self
  end
  
  def hamming(s1,s2)
    j = 0 
    (0...s1.length).each { |i| 
      if s1[i]!=s2[i]  
        j += 1 
      end }
    j
  end
  
  def parity(s,polys)
    pp = ''
    polys.each { |p| pp << p.convolve(s) }
    pp
  end
  
  def advance(code,polys)
    vt_n = VT.new(order)
    distance.each_key do |k|
      ['0','1'].each do |b|
        es = k + b
        ns = es[1..-1]
        pp = parity(es,polys)
        d = hamming(pp,code) + distance[k]
        if (not vt_n.distance.has_key?(ns)) or (vt_n.distance[ns] > d)
          vt_n.distance[ns] = d
          vt_n.backtrace[ns] = k
        end
      end
    end
    vt_n
  end

  def self.backtraceit(vt_a)
    s = ''
    i = -1
    vt = vt_a[i]
    k = vt.distance.keys.min_by{ |k| vt.distance[k] }
    while vt.backtrace[k]!='' do
      s << k[-1]
      k = vt.backtrace[k]
      i -= 1
      vt = vt_a[i]
    end
    s.reverse
  end
  
  def self.solve(codedtext,polys,order)
    codes = codedtext.split
    vt_a = []
    vt_a << (VT.new(order)).firststate
    codes.each do |code|
      vt_a << vt_a[-1].advance(code,polys)
    end
    vt_a
  end
  
end

# WARNING: only works with code separation, 
# because I'm a lazy coder

# solve for all inputs

retext_a = []
outtext_a.each do |ot|
  vt_a = VT.solve(ot,polys,order)
  retext_a << VT.backtraceit(vt_a)
end

# output section

puts "poly:"
polys.each { |p| puts " -#{p.poly}" }
puts
puts "text:"
intext_a.each { |t| puts " -#{t}" }
puts
puts "outtext:"
outtext_a.each { |t| puts " -#{t}" }
puts
puts "retext:"
retext_a.each { |t| puts " -#{t}" }

