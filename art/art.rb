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
  composite.write(location)
end

def circle(image, x, y, radius)
  circle = Magick::Draw.new
  circle.fill         = "transparent"
  circle.stroke       = BASE0
  circle.stroke_width = 5
  circle.circle(x, y, x, y + radius)
  circle.draw(image)
end

def circles(image, count)
  case count
  when 1
    circle(image, 412, 562, 80)
  when 2
    circle(image, 412, 442, 80)
    circle(image, 412, 682, 80)
  when 3
    circle(image, 412, 322, 80)
    circle(image, 412, 562, 80)
    circle(image, 412, 802, 80)
  when 4
    circle(image, 412, 202, 80)
    circle(image, 412, 442, 80)
    circle(image, 412, 682, 80)
    circle(image, 412, 922, 80)
  end
end

def mini_circles(image, count)
  case count
  when 1
    circle(image, 300, 412, 80)
  end
end
