# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 1125
PADDING   = 120
WIDTH     = 825

require File.expand_path(File.join(DIRECTORY, 'art'))

# Faces

{
  "1" => 1,
  "2" => 2,
  "3" => 2,
  "4" => 2,
  "5" => 3
}.each do |goal, circles|
  text = card('transparent')

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, "Asteroids") do
    shared_text_settings(self)
    self.rotation = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, goal) do
    shared_text_settings(self)
    self.align    = Magick::RightAlign
    self.rotation = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  circles(texts, circles)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.level(0, Magick::QuantumRange, 1.5)
  composite.write("#{DIRECTORY}/../assets/locations/Asteroids_#{goal}.png")
end

# Lounge
text = card('transparent')

draw = Magick::Draw.new
draw.annotate(text, 0,0, PADDING, PADDING, "Lounge") do
  shared_text_settings(self)
  self.rotation = 90
end

flip_flop = text.dup.flip!.flop!
texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

circles(texts, 4)

composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
composite.level(0, Magick::QuantumRange, 1.5)
composite.write("#{DIRECTORY}/../assets/locations/Lounge.png")

# Back
card_back('Locations', "#{DIRECTORY}/../assets/locations/Locations.png")
