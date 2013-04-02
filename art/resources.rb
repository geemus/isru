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
  "Copper"    => 1,
  "Silver"    => 2,
  "Gold"      => 3,
  "Platinum"  => 4
}.each do |type,value|
  text = card('transparent')

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, type) do
    shared_text_settings(self)
    self.gravity = Magick::NorthWestGravity
  end
  draw.annotate(text, 0,0, PADDING, PADDING, value.to_s) do
    shared_text_settings(self)
    self.gravity = Magick::NorthEastGravity
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.write("#{DIRECTORY}/../assets/resources/#{type}_#{value}.png")
end

# Back
card_back('Resources', "#{DIRECTORY}/../assets/resources/Resources.png")
