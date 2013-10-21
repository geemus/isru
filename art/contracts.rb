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
  "Copper + Silver"           => 10,
  "Silver + Gold"             => 14,
  "Silver + Platinum"         => 18,
  "Copper + Gold + Platinum"  => 19,
  "Silver + Gold + Platinum"  => 20,
  "Two Gold"                  => 21,
  "Three Copper"              => 22,
  "Three Silver"              => 26,
  "Four Copper"               => 30
}.each do |type,value|
  text = card('transparent')

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, type) do
    shared_text_settings(self)
    self.pointsize  = 60
    self.rotation   = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, value.to_s) do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.pointsize  = 60
    self.rotation   = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  circles(texts, 1)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.level(0, Magick::QuantumRange, 1.5)
  composite.write("#{DIRECTORY}/../assets/contracts/#{type.gsub(' ', '')}_#{value}.png")
end

# Back
card_back_circle('Contracts', "#{DIRECTORY}/../assets/contracts/Contracts.png")
