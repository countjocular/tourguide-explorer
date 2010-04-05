#!/bin/ruby
require 'rubygems'

require 'RMagick'

filename = ARGV[0]

out   = File.new("output/#{filename}.out", "w")
canvas = Magick::Image.new(600, 600, Magick::HatchFill.new('white','lightcyan2'))
gc = Magick::Draw.new

f = File.open("#{filename}.in")
a = f.readlines
a.delete(a.last)
@previous = a.last
@start = a.first
a.each do |original|
  temp = original.split(' (')
  ptemp = @previous.split(' (')
  name = temp[0]
  pname = ptemp[0]
  coords = temp[1]
  pcoords = ptemp[1]
  coords = coords[0..-1]
  pcoords = pcoords[0..-1]
  coords.gsub!(/\n/,"")
  pcoords.gsub!(/\n/,"")
  x = coords[0..1]
  y = coords[4..5]
  px = pcoords[0..1]
  py = pcoords[4..5]
  x = Integer(x)*5
  y = Integer(y)*5
  px = Integer(px)*5
  py = Integer(py)*5
  gc.text(x, y, name)
  gc.text(x+3, y+10, "(#{x/5}, #{y/5})")
  gc.circle(x,y,x+2,y) unless original==@start
  gc.circle(x,y,x+4,y) if original==@start
  gc.line(px,py,x,y)
  @previous = original

  out << "R #{name} |N|(#{coords}|\n"
end

gc.draw(canvas)
canvas.write("../maps/#{filename}.gif")

