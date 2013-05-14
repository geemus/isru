# encoding: utf-8

require "prawn"

def header(title)
  pad_bottom(10) do
    table(
      [[title]],
      :cell_style => {
        :border_color => "666666",
        :font_style   => :bold,
        :padding      => 10,
        :size         => 12,
        :text_color   => "666666",
        :width        => 540
      },
      :row_colors => ["CCCCCC"]
    )
  end
end

def subheader(title)
  pad_bottom(10) do
    table(
      [[title]],
      :cell_style => {
        :border_color => "CCCCCC",
        :font_style   => :bold,
        :padding      => 8,
        :size         => 10,
        :text_color   => "CCCCCC",
      },
      :row_colors => ["666666"]
    )
  end
end

def flavor(content)
  pad_bottom(10) do
    table(
      [[content]],
      :cell_style => {
        :border_color => "CCCCCC",
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

def example(content)
  pad_bottom(8) do
    text("<color rgb=\"999999\">\n#{content}</color>\n", :inline_format => true, :size => 10, :style => :italic)
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
It was only a matter of time before somebody figured out how to snatch up them resources that were floating about. Just don't be fooled into think'n they figured how to do safe like. Risk comes with reward though, least til MegaCorp buys up the rights... Best strike while the iron's hot, welcome to the asteroids!
CONTENT

  header("Overview")
  paragraph <<-CONTENT
Balance mining, upgrading, and fulfilling contracts to earn the most points before contracts run out!
CONTENT

  header("Game Flow")
  list([
    "<b>Shared Setup</b>",
    "<b>Each Player Setup</b>",
    "<b>Rounds</b>",
    [
      "<b>Actions</b>: Players take turns placing crew disks to take actions.",
      [
        "<b>Asteroids</b>: Take a chance to gain resources.",
        "<b>Reserve Contracts</b>: Get more options of contracts to fulfill for points.",
        "<b>Fulfill Contracts</b>: Trade resources for points.",
        "<b>Pass</b>: Avoid risk or expense but get no more actions for the round.",
        "<b>Upgrades</b>: Trade resources for improved capabilities."
      ],
      "<b>Refresh</b>: Retrieve crew disks, reveal new contracts, and pass first player rocket."
    ],
    "<b>Game End</b>",
    "<b>Scoring</b>"
  ])

  header("Shared Setup")
  image("#{File.dirname(__FILE__)}/setup.jpg", :position => :center, :fit => [320, 240])
  move_down(10)
  list([
    "Gather upgrades in piles by type (<i>Armor</i>, <i>Crew</i>, <i>Mining</i>).",
    "Set aside two <i>Copper</i>, and three <i>Silver</i>.",
    "Shuffle remaining resources and form a draw pile near the asteroids.",
    "Shuffle contracts to form a draw pile.",
    "Arrange the asteroids by their number from lowest to highest."
  ])

  header("Each Player Setup")
  list([
    "Take all crew disks of the same color.",
    "Keep two crew disks and set aside the rest near the upgrade piles.",
    "Place two <i>Crew</i> cards in front of you to indicate how many crew disks you may use each round.",
    "Place one <i>Mining</i> card in front of you to indicate how many resources to draw when mining.",
    "The person who has spent the least time on Earth may take the first player rocket.",
    "The first player should take one <i>Copper</i> from those set aside during setup.",
    "The second player should take one <i>Silver</i> from those set aside during setup.",
    "The third player should take one <i>Copper</i>, and one <i>Silver</i> from those set aside during setup.",
    "The fourth player should take two <i>Silver</i> from those set aside during setup.",
    "Draw three contract cards and choose at least one to keep."
  ])

  header("Rounds")

  subheader("Actions")
  paragraph <<-CONTENT
Starting with the player holding the first player rocket, players take turns playing actions or passing. To play an action, place a crew disk on an empty action circle and follow the instructions for that location. To pass, place your remaining crew disks on the <i>Lounge</i> location. After taking an action or passing, the next player in clockwise order with remaining crew disks will take their turn. When all crew disks have been placed, the round ends and you <b>Refresh</b> to prepare for the next round.
CONTENT

  subheader("Refresh")
  list([
    "If the contracts do not have a crew disk on them, discard the next three face up.",
    "All players recollect their crew tokens.",
    "Pass the first player rocket to the next player in clockwise order.",
  ])

  subheader("Game End")
  paragraph <<-CONTENT
The game ends on the turn in which there are no contracts left in the draw pile, regardless of whether they were drawn or discarded.
CONTENT

  subheader("Scoring")
  paragraph <<-CONTENT
Players add the values of their fulfilled contracts and remaining resources together and subtract reserved contracts still in their hand to get their final score. The player with the highest score is the winner. In the event of a tie, play again in a new asteroid field!
CONTENT
  paragraph <<-CONTENT
<b>Final Score</b> = <i>resources</i> + <i>fulfilled contracts</i> - <i>reserved contracts</i>
CONTENT

  header("Actions")

  subheader("Asteroids")
  flavor <<-CONTENT
Getting yourself out to the frontier may have been a struggle, but out in the asteroids it gets real sketchy. Insurance comes to the rescue when disaster strikes and believe me, it will. They'll tow your ship's bits in to get patched up, but not your cargo... So keep your eyes open, but don't be too scared to chase them big scores.
CONTENT
  list([
    "Find the asteroid with the lowest number and place a crew disks on the next open circle.",
    "Roll the die, add your number of <i>Armor</i> cards and compare against the number:",
    "If your total is greater than the number:",
    [
      "You successfully mined! Draw resources equal to your number of <i>Mining</i> cards.",
      "If the resources run out, shuffle discarded resources to form a new draw pile."
    ],
    "If your total is less than or equal to the number:",
    [
      "You crashed! Discard your hand.",
      "Place your remaining crew disk on the next open circles on the lowest number asteroids.",
    ]
  ])
  example <<-EXAMPLE
David got the platinum, so he will go first. He decides to mine and places one of his crew disks on the first asteroid space, which has the number 2. He rolls a 4, which beats the number. Since he has one mining upgrade, he draws one resource card and ends his turn.

Susan got gold and so she will go second. She also decides to mine and places one crew disk on the next asteroid space, which has the number 3. She rolls a 3, which does not beat the number. Armor would add one to her roll for each upgrade, but she has none. She crashes, placing her remaining crew disk on the next available spot and discarding her gold. This ends her turn and she will have to wait to reclaim her crew disks during <i>Refresh</i> before she will be able to take additional actions.
EXAMPLE

  subheader("Reserve Contracts")
  flavor <<-CONTENT
Contracts get resources to people who'll pay good for 'em, but miss too many deliveries and you'll be outta business.
CONTENT
  list([
    "Your score increases by the amount listed on face up, fulfilled contracts.",
    "Draw 3 contract cards and then place a crew disk in their place.",
    "From the drawn contracts, choose at least one to add to your hand of reserved contracts.",
    "Be careful, when the game ends remaining reserved contracts reduce your score."
  ])
  example <<-EXAMPLE
Morgan chooses to draws three contracts and places a crew disk on the contract pile. He draws <i>CS</i>, <i>GG</i>, and <i>SSS</i>. He decides that since it is still early in the game, he keeps <i>SSS</i> as it is worth the most points if he can complete it. He decides not take too many contracts at once though, so he discards <i>CS</i> and <i>GG</i>.

Teresa would like to draw more contracts also, but must wait until the following turn when contracts are once again available. When her turn comes up she draws three contracts and places a crew disk. She draws <i>CS</i>, <i>CS</i> and <i>GG</i>. She keeps one <i>CS</i> and discards the other <i>CS</i> and the <i>GG</i>.
EXAMPLE

  subheader("Fulfill Contracts")
  flavor <<-CONTENT
Promises are well and good, but no rest for the wicked; least not until you deliver.
CONTENT
  list([
    "Reveal one of your reserved contracts and pay the matching resources to place your crew disk on it.",
    "When the game ends your score will be:",
    [
      "Increased by the total amount shown on your fulfilled contracts.",
      "Decreased by the total amount on your remaining reserved contracts."
    ]
  ])
  example <<-EXAMPLE
Teresa previously drew <i>SG</i> from the discarded contracts. As she has both <i>Silver</i> and <i>Gold</i>, she chooses to fulfill this contract with her next action. She reveals the contract, discards the matching resources and places a crew disk on it. When the game ends she will now have that many more points.
EXAMPLE

  subheader("Lounge")
  flavor <<-CONTENT
If you can't stand the heat, sometimes you just as well avoid the fire.
CONTENT
  list([
    "Passing allows you to avoid risky or expensive actions.",
    "Place all of your remaining crew disks onto the <i>Lounge</i> to indicate you are finished for this round.",
    "You will take no further actions this round, but will play as normal again in the following round."
  ])
  example <<-EXAMPLE
Morgan has resources in hand which he hopes to use to fulfill his valuable Three Silver reserved contract. He sees that the asteroids are nearly full late in the round after several actions. Since he does not want to spend or risk these resources and does not want to take another unfulfilled contract, he instead passes his remaining actions by placing his crew disks on the Lounge and hoping that next turn his caution will pay off.
EXAMPLE

  subheader("Upgrades")
  flavor <<-CONTENT
That hunk-a-junk might get you out and back, but you best visit the mechanics if you wanna be major league.
CONTENT
  list([
    "There are several available upgrades, each providing a different bonus.",
    [
      "<i>Armor</i>:   Add one to your asteroids die roll for each armor upgrade card.",
      "<i>Crew</i>:    Use one crew disks each round for each crew upgrade card.",
      "<i>Mining</i>:  Draw one resource for each mining upgrade card when asteroids roll succeeds."
    ],
    "Pay the cost on the upgrade card to collect it and place your crew disk on it.",
    "Costs are for the first, second, third, and forth upgrade of this type that you purchase.",
    "You may pay by discarding any combination of resources from your hand, but recieve no change.",
    "Upgrades are collected immediately and start benefitting you right away.",
    "When a type of upgrades runs out, that upgrade remains unavailable for the rest of this game."
  ])
  example <<-EXAMPLE
David decides to upgrade his Mining ability. Since he already has a starting mining upgrade he must pay the second cost of two. He pays a silver from his hand, takes a Mining card and places a crew disk on the Mining pile. He will now draw one additional resource when mining successfully for the rest of the game and no one else will be able to upgrade mining this turn.

Susan decides to play it safe after a crash and upgrade Armor. The first Armor only costs one, but the cheapest resource she has is a silver. She decides to pay this, despite not getting change back, takes an Armor card and places a crew disk on the Armor pile. She will add one to her die rolls for the rest of the game and no one else will be able to upgrade mining this turn.

Teresa also decides to upgrade, but Armor and Mining are taken so Crew is her only option. Since she has two starting Crew, she must pay the third cost of four. She pays a gold and a copper together to cover the cost, takes a Crew card and places a crew disk on the Crew pile. She will have this extra crew disk to take actions with for the rest of the game and no one else will be able to upgrade crew this turn.

Morgan will not be able to purchase any upgrades this turn, but is hopeful that he can use resources he gathers this turn to get better upgrades next turn.
EXAMPLE

  flavor <<-CONTENT
It's been fun, but all good things must end. You did a smidge too well, and MegaCorp got interested. They snatched up rights faster than a speeding asteroid. Thanks be, there's more asteroids, so maybe we'll see you again real soon.
CONTENT

  text('<color rgb="999999"><b>Components:</b> die; first player rocket, 4x4 crew disks (blue, green, orange, purple); 6x Asteroids (1-5); 24 Contracts 3x(CG, SS, CCC, SG, GG, CCCC, PP, SSS), 60x Resources (21x <i>Copper</i>, 17x <i>Silver</i>, 13x <i>Gold</i>, 9x <i>Platinum</i>); 33x Upgrades (15x <i>Crew</i>, 11x <i>Mining</i>, 7x <i>Armor</i>)</color>', :inline_format => true, :size => 10)
end
