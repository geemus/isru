# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 1125
PADDING   = 120
WIDTH     = 825

require File.expand_path(File.join(DIRECTORY, 'art'))

CONTRACTS = {
  "5 Black"                     => 8,
  "1 Black, 1 Grey and 1 White" => 8,
  "3 Black and 1 White"         => 9,
  "2 Grey and 1 White"          => 9,
  "3 Black and 2 Grey"          => 10,
  "4 Grey"                      => 10,
  "3 White"                     => 12,
  "3 Black, 2 Grey and 1 White" => 14
}

CONTRACTS.each do |type,value|
  [:circle, :diamond, :hexagon].each do |suit|
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

    send(suit, texts)

    composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)
    composite.level(0, Magick::QuantumRange, 1.5)
    name = "#{type.gsub(/[\s,]/, '')}-#{suit}"
    composite.write("#{DIRECTORY}/../assets/contracts/#{name}.png")
  end
end

# Back
card_back('Contracts', "#{DIRECTORY}/../assets/contracts/Contracts.png")
