#!/bin/ruby
require 'rubygems'

require 'RMagick'

canvas = Magick::Image.new(600, 600,
              Magick::HatchFill.new('white','lightcyan2'))
gc = Magick::Draw.new

f = File.open('locations.in')
a = f.readlines
a.delete(a.last)
@previous = a.last
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
  gc.circle(x,y,x+3,y)
  gc.line(px,py,x,y)
  @previous = original
end

gc.draw(canvas)
canvas.write('map.gif')

