require 'gosu'
require 'bakeru/zorder'
require 'bakeru/scenes/base_scene'

module Bakeru
  class MainMenu < BaseScene
    attr_reader :selected_option, :font, :available_options
    FONT_SIZE = 50

    def initialize(*args)
      super
      @available_options = ['New Game', 'Load Game', 'Options', 'Quit']
      @selected_option = 0
    end

    def setup
      @font = Gosu::Font.new(FONT_SIZE, name: 'Courier')
    end

    def update(event, key_id)
      return unless event == :key_down

      case key_id
      when Gosu::KbReturn
        game.go_to_scene(:world)
      when Gosu::KbDown
        next_option
      when Gosu::KbUp
        previous_option
      end
    end

    def draw
      available_options.each_with_index do |option, index|
        x = (game.width / 2) - FONT_SIZE * option.length / 4
        y = (game.height / 2) + FONT_SIZE * index
        font.draw(option, x, y, ZOrder::UI, 1, 1, color_for(index))
      end
    end

    private

    def next_option
      if @selected_option + 1 >= available_options.length
        @selected_option = 0
      else
        @selected_option += 1
      end
    end

    def previous_option
      if @selected_option - 1 < 0
        @selected_option = available_options.length - 1
      else
        @selected_option -= 1
      end
    end

    def color_for(index)
      return 0xff_ececff if index != selected_option
      0xff_aa0a00
    end
  end
end
