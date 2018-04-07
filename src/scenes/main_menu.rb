require 'gosu'
require 'zorder'
require 'scenes/base_scene'

class MainMenu < BaseScene
  attr_reader :selected_option, :font, :available_options
  FONT_SIZE = 50

  def initialize(*args)
    super
    @available_options = ['New Game', 'Quit']
    @selected_option = 0
  end

  def setup
    @font = Gosu::Font.new(FONT_SIZE, name: 'Courier')
  end

  def update(event, key_id)
    if event == :key_down && key_id == Gosu::KbReturn
      game.go_to_scene(:world)
    end
  end

  def draw
    available_options.each_with_index do |option, index|
      x = (game.width / 2) - FONT_SIZE * option.length / 4
      y = (game.height / 2) + FONT_SIZE * index
      font.draw(option, x, y, ZOrder::UI)
    end
  end
end
