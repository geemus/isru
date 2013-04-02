# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 2700
PADDING   = 90
WIDTH     = 3450

require File.expand_path(File.join(DIRECTORY, 'art'))

# Top

box_top("#{DIRECTORY}/../assets/box/top.png")

# Bottom

box_bottom("#{DIRECTORY}/../assets/box/bottom.png")
