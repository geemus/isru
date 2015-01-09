# see: http://www.imagemagick.org/RMagick/doc/index.html

require "rubygems"
require "RMagick"

DIRECTORY = File.dirname(__FILE__)
HEIGHT    = 1125
PADDING   = 120
WIDTH     = 825

require File.expand_path(File.join(DIRECTORY, 'art'))

COLORS = %w{
  Carbon
  Water
  Ore
}

CONTRACTS = %w{
  111
  021
  301
  320
  003
  321
  060
  900
  222
  042
  602
  640
  333
  642
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
    count = count.to_i(16)
    next if count == 0
    text << "#{count} #{COLORS[index]}"
    #value += 0.5
    value += 0.5 * count
    case COLORS[index]
    when "Carbon"
      value += count * 1.0   # value
    when "Water"
      value += count * 1.5   # value
    when "Ore"
      value += count * 3.0   # value
    end
  end
  text = text.join (' + ')
  value = value.round
  total += value

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
    draw.annotate(image, 0,0, PADDING, HEIGHT - PADDING, value.to_s) do
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
puts "AVERAGE: #{total.to_f / CONTRACTS.length}"
