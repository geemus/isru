# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 1125
PADDING   = 120
WIDTH     = 825

require File.expand_path(File.join(DIRECTORY, 'art'))

# Faces

contracts = {
  "CS"    => 10,
  "SG"    => 14,
  "SP"    => 18,
  "CGP"   => 19,
  "SGP"   => 20,
  "GG"    => 21,
  "CCC"   => 22,
  "SSS"   => 26,
  "CCCC"  => 30
}.each do |type,value|
  text = card('transparent')

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, type) do
    shared_text_settings(self)
    self.rotation   = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, value.to_s) do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.rotation   = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  circles(texts, 1)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.write("#{DIRECTORY}/../assets/contracts/#{type.gsub(' ', '_')}_#{value}.png")
end

# Back
card_back_circle('Contracts', "#{DIRECTORY}/../assets/contracts/Contracts.png")
