# encoding: utf-8

require "prawn"

def header(title)
  pad_bottom(10) do
    table(
      [[title]],
      :cell_style => {
        :border_color => "CCCCCC",
        :font_style   => :bold,
        :padding      => 10,
        :size         => 12,
        :text_color   => "CCCCCC",
        :width        => 540
      },
      :row_colors => ["666666"]
    )
  end
end

def subheader(title)
  pad_bottom(10) do
    table(
      [[title]],
      :cell_style => {
        :border_color => "666666",
        :font_style   => :bold,
        :padding      => 8,
        :size         => 10,
        :text_color   => "666666",
        :width        => 540
      },
      :row_colors => ["CCCCCC"]
    )
  end
end

def example(content)
  pad_bottom(10) do
    table(
      [[content]],
      :cell_style => {
        :border_color => "EEEEEE",
        :font_style   => :italic,
        :padding      => 8,
        :size         => 10,
        :text_color   => "999999",
        :width        => 540
      },
      :row_colors => ["EEEEEE"]
    )
  end
end

def flavor(content)
#  pad_bottom(10) do
#    table(
#      [[content]],
#      :cell_style => {
#        :border_color => "CCCCCC",
#        :font_style   => :italic,
#        :padding      => 8,
#        :size         => 10,
#        :text_color   => "CCCCCC",
#        :width        => 540
#      },
#      :row_colors => ["FFFFFF"]
#    )
#  end
end

def list(elements)
  pad_bottom(4) do
    elements.each do |li|
      if li.is_a?(Array)
        indent(16) do
          list(li)
        end
        move_up(4)
      else
        float { text "•" }
        indent(10) do
          text(
            li.gsub(/\s+/," "),
            :inline_format => true,
            :leading       => 2
          )
        end
      end
    end
  end
end

def paragraph(content)
  pad_bottom(8) do
    text(content, :inline_format => true)
  end
end

Prawn::Document.generate("#{File.dirname(__FILE__)}/../assets/isru.pdf") do

  pad_bottom(6) do
    pad_bottom(4) do
      text('<color rgb="999999">In-situ resource utilization (ISRU) is the mining and use of space resources.</color>', :align => :center, :inline_format => true, :size => 10)
    end
    pad_bottom(4) do
      text('<color rgb="999999">ISRU is an asteroid mining game for 3-4 players lasting 45-75 minutes.</color>', :align => :center, :inline_format => true, :size => 10)
    end
    pad_bottom(4) do
      text('<color rgb="999999">geemus (Wesley Beary)</color>', :align => :center, :inline_format => true, :size => 10)
    end
  end

  flavor <<-CONTENT
It was only a matter of time before somebody started snatching up them asteroids. But don't be fooled think'n they can do it safe like. Risk comes with reward though, least til MegaCorp buys the rights... Best strike while the iron's hot, welcome to the asteroids!
CONTENT

  header("Overview")
  paragraph <<-CONTENT
Balance mining, upgrading, and contracts to earn points until contracts run out!
CONTENT
  list([
    "<b>Setup:</b> Setup shared locations and distribute components to players.",
    "<b>Rounds:</b> Rounds contain many actions and then a <b>Refresh</b>.",
    [
      "<b>Actions</b>: Players place crew disks to take actions.",
      [
        "<b>Asteroids</b>: Take a chance to gain resources.",
        "<b>Reserve Contracts</b>: Get more options of contracts to fulfill for points.",
        "<b>Fulfill Contracts</b>: Trade resources for points.",
        "<b>Lounge</b>: Avoid risk or expense but get no more actions for the round.",
        "<b>Upgrades</b>: Trade resources for improved capabilities."
      ],
      "<b>Refresh</b>: Retrieve crew disks, reveal new contracts, and pass first player rocket."
    ],
      "<b>Game End:</b> Play a final round when no contracts remain after <b>Refresh</b>, then calculate scores."
  ])

  header("Setup")
  image("#{File.dirname(__FILE__)}/setup.png", :position => :center, :fit => [480, 360])
  move_down(10)
  list([
    "Gather upgrades by type, then give each player two <i>Crew</i> upgrades and one <i>Mining</i> upgrade.",
    "Gather crew disks near the upgrade piles, each player should choose a different color and take two.",
    "First player will be whomever has spent the least time on Earth (or choose how you like).",
    "First player: take one <i>Copper</i> and the first player rocket.",
    "Second player in clockwise order: take two <i>Copper</i>.",
    "Third player in clockwise order: take one <i>Copper</i> and one <i>Silver</i>.",
    "Fourth player in clockwise order: take one <i>Copper</i> and one <i>Gold</i>.",
    "Shuffle remaining resources and form a draw pile near the asteroids.",
    "Shuffle contract cards, and set aside the card, it will not be used this game.",
    "Deal two of the remaining contracts to each player.",
    "Players may discard from these contracts, but must keep at least one each.",
    "Arrange the asteroids by their number from lowest to highest.",
  ])

  header("Actions")
  paragraph <<-CONTENT
Starting with the first player, take turns in clockwise order, playing actions. To play an action, place a crew disk on an empty action circle and follow the instructions for that location. The next player in clockwise order with remaining crew disks will take their turn. When all crew disks have been placed, the round ends. <b>Refresh</b> and begin the next round.
CONTENT

  subheader("Asteroids")
  flavor <<-CONTENT
Getting out to the frontier may have been a struggle, but out in them asteroids it gets real sketchy. Insurance can save you when disaster strikes, and believe me it will. They'll tow your ship's bits in to get patched up, but not your cargo... So keep your eyes open when chasin' them big scores.
CONTENT
  list([
    "Place a crew disks on the next open action circle of the lowest available asteroid.",
    "Roll the die, add your number of <i>Armor</i> cards and compare:",
    "If your total is greater than the number on the asteroid:",
    [
      "You successfully mined! Draw resources equal to your number of <i>Mining</i> cards.",
      "If resources run out, shuffle discarded resources to form a new draw pile."
    ],
    "If your total is less than or equal to the number on the asteroid:",
    [
      "You crashed! Discard half of your resources, rounding down.",
      "Place your remaining crew disk on open action circles starting with the lowest number asteroid.",
    ]
  ])
  example <<-EXAMPLE
David places a crew disks on the first asteroid space. He rolls a 4, which is greater than the 1 on the asteroid. He draws one resource card, matching his one mining card.

Susan places a crew disk on the next asteroid space. She rolls a 2, which only ties the 2 on the asteroid. Armor may have added to her roll, but she has none and crashes. She places her remaining crew disk on the next available action circle and discards half her resources, rounding down. She will have to wait until next round to take further actions.
EXAMPLE

  subheader("Reserve Contracts")
  flavor <<-CONTENT
Contracts get resources to people who'll pay good for 'em, but miss too many deliveries and you'll be outta business.
CONTENT
  list([
    "Draw two contract cards and place a crew disk in their place.",
    "From the drawn contracts, choose at least one to add to your reserved contracts.",
    "Be careful, when the game ends remaining reserved contracts reduce your score."
  ])
  example <<-EXAMPLE
Morgan draws two contracts and places a crew disk on the contract pile. He draws 'Copper + Silver', and 'Three Silver'. He keeps 'Three Silver' as it is worth more points, but discards 'Copper + Silver' to limit his total risk.
EXAMPLE

  subheader("Fulfill Contracts")
  flavor <<-CONTENT
Promises are well and good, but no rest for the wicked; least not until you deliver.
CONTENT
  list([
    "When the game ends your fufilled contracts will be added to your score.",
    "Reveal one of your reserved contracts and pay the matching resources to place your crew disk on it.",
  ])
  example <<-EXAMPLE
Teresa reveals a 'Silver + Gold' contract from her reserved contracts, discards Silver and Gold from her hand and places a crew disk on the contract. When the game ends she will now have an additional 14 points.
EXAMPLE

  subheader("Lounge")
  flavor <<-CONTENT
If you can't stand the heat, sometimes you just as well stay outta the kitchen.
CONTENT
  list([
    "Using the lounge allows you to avoid risky or expensive actions.",
    "Place all of your remaining crew disks onto an empty <i>Lounge</i> action circle.",
    "You will take no further actions this round, but will play as normal again in subsequent round."
  ])
  example <<-EXAMPLE
Morgan has two silver in hand which he hopes to use toward his 'Three Silver' reserved contract. Seeing that the asteroids have become risky, he places his remaining crew disks on the lounge and hopes his caution will pay off.
EXAMPLE

  subheader("Upgrades")
  flavor <<-CONTENT
That hunk-a-junk might get you out and back, but you best visit the mechanics if you wanna be major league.
CONTENT
  list([
    "There are several available upgrades, each providing different bonuses:",
    [
      "<i>Armor</i>:   Add one to your asteroids die roll for each armor upgrade card.",
      "<i>Crew</i>:    Use one crew disks each round for each crew upgrade card.",
      "<i>Mining</i>:  Draw one resource for each mining upgrade card when succeeding on asteroids."
    ],
    "Pay the cost on the upgrade card to collect it and place your crew disk in its place.",
    "Costs are for the first, second, third, and forth upgrade of this type that you purchase.",
    "You may pay by discarding any combination of resources from your hand, but recieve no change.",
    "Upgrades are collected immediately and start benefitting you right away.",
    "Each type (<i>Armor</i>, <i>Crew</i> or <i>Mining</i>) may only be used by one player per round.",
    "If a type of upgrades runs out, that upgrade remains unavailable for the rest of this game."
  ])
  example <<-EXAMPLE
David decides to upgrade from his initial Mining card, so he must pay the second cost of 2. He pays a Silver from his hand, takes a Mining card and places a crew disk. He will draw two resources when succeeding on asteroids for the rest of the game.

Susan decides to play it safe after crashing and upgrade Armor. The first Armor only costs 1, but the cheapest resource she has is a Silver. She decides to pay this, losing the change, takes an Armor card and places a crew disk. She will add one to her die rolls for the rest of the game.

Teresa also decides to upgrade, but Armor and Mining are taken, leaving only Crew. With two starting Crew, she must pay the third cost of 4. She pays Gold and Copper together, takes a Crew card and places a crew disk. She will have this extra crew disk to use for the rest of the game.
EXAMPLE

  header("Refresh")
  list([
    "If the contracts do not have a crew disk on them, discard the next two contracts face up.",
    "All players recollect the crew tokens the used last turn.",
    "Pass the first player rocket clockwise to the next player.",
    "If the contract draw pile is empty, the next round will be the final round of the game."
  ])

  header("Game End")
  flavor <<-CONTENT
It's been fun, but all good things must end. You did a smidge too well, and MegaCorp got interested. They snatched up rights faster than a speeding asteroid. Thanks be, there's more asteroids, so maybe we'll see you again real soon.
CONTENT
  paragraph <<-CONTENT
If the contract draw pile is empty after <b>Refresh</b>, play one final round. Then players add the value of their resources and fulfilled contracts together and subtract the value of their reserved contracts to get a final score. The player with the highest score wins. In a tie the player with the most fulfilled contracts wins. If a tie remains, play again!
CONTENT
pad_bottom(8) do
  text("<b>Final Score</b> = <i>resources</i> + <i>fulfilled contracts</i> - <i>reserved contracts</i>", :align => :center, :inline_format => true)
end

# text('<color rgb="999999"><b>Components:</b> die; first player rocket, 4x4 crew disks (blue, green, orange, purple); 6x Asteroids (1-5); 27 Contracts 3x(Copper + Silver, Silver + Gold, Silver + Platinum, Copper + Gold + Platinum, Silver + Gold + Platinum, Two Gold, Three Copper, Three Silver, Four Copper), 60x Resources (21x <i>Copper</i>, 17x <i>Silver</i>, 13x <i>Gold</i>, 9x <i>Platinum</i>); 33x Upgrades (15x <i>Crew</i>, 11x <i>Mining</i>, 7x <i>Armor</i>)</color>', :inline_format => true, :size => 10)

  number_pages(
    '<page>/<total>',
    :align => :center,
    :at    => [0, bounds.bottom]
  )

end
