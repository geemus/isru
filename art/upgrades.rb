# encoding: UTF-8
# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 825
PADDING   = 90
WIDTH     = 600

require File.expand_path(File.join(DIRECTORY, 'art'))

# Faces

{
  "Armor"   => [1, 2, 3, 4],
  "Mining"  => [0, 2, 4, 6],
  "Crew"    => [0, 0, 4, 8]
}.each do |upgrade, costs|
  text = card('transparent')

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, upgrade) do
    shared_text_settings(self)
    self.pointsize  = 60
    self.rotation   = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, costs.join(' ¤ ')) do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.pointsize  = 60
    self.rotation   = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  mini_circles(texts, 1)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.write("#{DIRECTORY}/../assets/upgrades/#{upgrade}.png")
end

# Back
mini_card_back('Upgrades', "#{DIRECTORY}/../assets/upgrades/Upgrades.png")
