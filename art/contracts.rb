# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 1125
PADDING   = 120
WIDTH     = 825

require File.expand_path(File.join(DIRECTORY, 'art'))

COLORS = %w{
  Black
  Grey
  White
}

CONTRACTS = %w{
  500
  111
  301
  021
  320
  040
  003
  321
}

SUITS = %w{
  circle
  diamond
  hexagon
}

CONTRACTS.each do |contract|
  text, value = [], 0
  contract.split('').each_with_index do |count, index|
    next if count == "0"
    text << "#{count} #{COLORS[index]}"
    case COLORS[index]
    when "Black"
      value += count.to_i * 1.333
    when "Grey"
      value += count.to_i * 2.5
    when "White"
      value += count.to_i * 4
    end
  end
  text = text.join (' + ')
  value = value.ceil
  value = value.to_s

  SUITS.each do |suit|
    name = "#{contract}#{suit[0,1]}=#{value}"

    image = card('transparent')

    draw = Magick::Draw.new
    draw.annotate(image, 0,0, PADDING, PADDING, text) do
      shared_text_settings(self)
      self.pointsize  = 60
      self.rotation   = 90
    end
    draw.annotate(image, 0,0, PADDING, HEIGHT - PADDING, value) do
      shared_text_settings(self)
      self.align      = Magick::RightAlign
      self.pointsize  = 60
      self.rotation   = 90
    end

    flip_flop = image.dup.flip!.flop!
    image = image.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

    send(suit.to_sym, image)

    composite = card.composite(image, 0, 0, Magick::SrcOverCompositeOp)
    composite.level(0, Magick::QuantumRange, 1.5)
    composite.write("#{DIRECTORY}/../assets/contracts/#{name}.png")
  end
end

card_back('Contracts', "#{DIRECTORY}/../assets/contracts/back.png")
