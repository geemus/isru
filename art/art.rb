# colors borrowed from solarized

BASE03  = "#657B83"

BASE00  = "#657B83"
BASE0   = "#839496"
BASE1   = "#93A1A1"
BASE2   = "#EEE8D5"
BASE3   = "#FDF6E3"

def shared_text_settings(text)
  text.fill         = BASE0
  text.font_family  = "Helvetica"
  text.font_weight  = Magick::BoldWeight
  text.pointsize    = 80
end

def box_top(location)
  #image = Magick::Image.read("./small-pro-box-bottom.png").first
  image = Magick::Image.new(WIDTH, HEIGHT) do
    self.background_color = BASE03
  end

  draw = Magick::Draw.new
  draw.annotate(image, 0,0, 1020, 1600, "ISRU") do
    shared_text_settings(self)
    self.fill       = BASE1
    self.pointsize  = 600
  end

  draw.annotate(image, 0,0, 575, 1145, "ISRU") do
    shared_text_settings(self)
    self.fill       = BASE1
    self.pointsize  = 200
    self.rotation   = 90
  end
  draw.annotate(image, 0,0, 2875, 1145, "ISRU") do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.fill       = BASE1
    self.pointsize  = 200
    self.rotation   = 270
  end

  image.level(0, Magick::QuantumRange, 1.5)
  image.write(location)
end

def box_bottom(location)
  #image = Magick::Image.read("./small-pro-box-bottom.png").first
  image = Magick::Image.new(WIDTH, HEIGHT) do
    self.background_color = BASE03
  end

  draw = Magick::Draw.new
  draw.annotate(image, 0,0, 1020, 1550, "ISRU") do
    shared_text_settings(self)
    self.fill       = BASE1
    self.pointsize  = 600
  end

  draw.annotate(image, 0,0, 2700, 1095, "ISRU") do
    shared_text_settings(self)
    self.fill       = BASE1
    self.pointsize  = 200
    self.rotation   = 90
  end
  draw.annotate(image, 0,0, 750, 1095, "ISRU") do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.fill       = BASE1
    self.pointsize  = 200
    self.rotation   = 270
  end

  image.level(0, Magick::QuantumRange, 1.5)
  image.write(location)
end

def card(background_color=BASE3)
  #  image = Magick::Image.read("./card_template.png").first
  Magick::Image.new(WIDTH, HEIGHT) do
    self.background_color = background_color
  end
end

def card_back(label, location)
  text = card("transparent")

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, label) do
    shared_text_settings(self)
    self.fill     = BASE1
    self.rotation = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, "ISRU") do
    shared_text_settings(self)
    self.align    = Magick::RightAlign
    self.rotation = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  composite = card(BASE03).composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.level(0, Magick::QuantumRange, 1.5)
  composite.write(location)
end

def card_back_circle(label, location)
  text = card("transparent")

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, label) do
    shared_text_settings(self)
    self.fill     = BASE1
    self.rotation = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, "ISRU") do
    shared_text_settings(self)
    self.align    = Magick::RightAlign
    self.rotation = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  composite = card.composite(texts, 0, 0, Magick::SrcOverCompositeOp)

  circles(composite, 1)

  composite.level(0, Magick::QuantumRange, 1.5)
  composite.write(location)
end

def mini_card_back(label, location)
  text = card("transparent")

  draw = Magick::Draw.new
  draw.annotate(text, 0,0, PADDING, PADDING, label) do
    shared_text_settings(self)
    self.fill       = BASE1
    self.pointsize  = 60
    self.rotation   = 90
  end
  draw.annotate(text, 0,0, PADDING, HEIGHT - PADDING, "ISRU") do
    shared_text_settings(self)
    self.align      = Magick::RightAlign
    self.pointsize  = 60
    self.rotation   = 90
  end

  flip_flop = text.dup.flip!.flop!
  texts = text.composite(flip_flop, 0, 0, Magick::SrcOverCompositeOp)

  composite = card(BASE03).composite(texts, 0, 0, Magick::SrcOverCompositeOp)
  composite.level(0, Magick::QuantumRange, 1.5)
  composite.write(location)
end

def draw_circle(image, x, y, radius)
  circle = Magick::Draw.new
  circle.fill         = "transparent"
  circle.stroke       = BASE0
  circle.stroke_width = 5
  circle.circle(x, y, x, y + radius)
  circle.draw(image)
end

def circle(image)
  circle = Magick::Draw.new
  circle.fill         = "transparent"
  circle.stroke       = BASE0
  circle.stroke_width = 5
  # 412, 562
  circle.circle(412, 562, 412, 642)
  circle.draw(image)
end

def diamond(image)
  diamond = Magick::Draw.new
  diamond.fill         = "transparent"
  diamond.stroke       = BASE0
  diamond.stroke_width = 5
  # 412, 562
  diamond.line(412, 482, 492, 562)
  diamond.line(492, 562, 412, 642)
  diamond.line(412, 642, 332, 562)
  diamond.line(332, 562, 412, 482)
  diamond.draw(image)
end

def hexagon(image)
  hexagon = Magick::Draw.new
  hexagon.fill         = "transparent"
  hexagon.stroke       = BASE0
  hexagon.stroke_width = 5
  # 412, 562
  hexagon.line(412, 482, 482, 522)
  hexagon.line(482, 522, 482, 602)
  hexagon.line(482, 602, 412, 642)
  hexagon.line(412, 642, 342, 602)
  hexagon.line(342, 602, 342, 522)
  hexagon.line(342, 522, 412, 482)
  hexagon.draw(image)
end

def octagon(image)
  octagon = Magick::Draw.new
  octagon.fill         = "transparent"
  octagon.stroke       = BASE0
  octagon.stroke_width = 5
  # 412, 562
  # 53 + 54 + 53 = 160
  # 332-492, 482-642
  octagon.line(385, 482, 439, 482)
  octagon.line(439, 482, 492, 535)
  octagon.line(492, 535, 492, 589)
  octagon.line(492, 589, 439, 642)
  octagon.line(439, 642, 385, 642)
  octagon.line(385, 642, 332, 589)
  octagon.line(332, 589, 332, 535)
  octagon.line(332, 535, 385, 482)
  octagon.draw(image)
end

def circles(image, count)
  case count
  when 1
    draw_circle(image, 412, 562, 80)
  when 2
    draw_circle(image, 412, 442, 80)
    draw_circle(image, 412, 682, 80)
  when 3
    draw_circle(image, 412, 322, 80)
    draw_circle(image, 412, 562, 80)
    draw_circle(image, 412, 802, 80)
  when 4
    draw_circle(image, 412, 202, 80)
    draw_circle(image, 412, 442, 80)
    draw_circle(image, 412, 682, 80)
    draw_circle(image, 412, 922, 80)
  end
end

def mini_circles(image, count)
  case count
  when 1
    draw_circle(image, 300, 412, 80)
  end
end
