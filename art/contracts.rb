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
  111
  021
  301
  320
  321
  900
  060
  003
  042
  602
  640
  531
}

SUITS = %w{
  circle
  diamond
  hexagon
}

total = 0
CONTRACTS.each do |contract|
  text, value = [], 0
  contract.split('').each_with_index do |count, index|
    next if count == "0"
    text << "#{count} #{COLORS[index]}"
    case COLORS[index]
    when "Black"
      value += count.to_i(16) * 2   # value
    when "Grey"
      value += count.to_i(16) * 3   # value
    when "White"
      value += count.to_i(16) * 6   # value
    end
  end
  text = text.join (' + ')
  value = value.ceil
  total += value
  value = value.to_s

  puts "#{contract}*=#{value}"

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

puts "CONTRACTS: #{CONTRACTS.length * SUITS.length}"
puts "AVERAGE: #{total / CONTRACTS.length}"
