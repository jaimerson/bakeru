require 'gosu'
require 'bakeru/zorder'
require 'bakeru/scenes/base_scene'
require 'bakeru/scenes/world'
require 'bakeru/scenes/create_character'
require 'bakeru/ui/menu'

module Bakeru
  module Scenes
    class MainMenu < BaseScene
      attr_reader :menu, :font
      FONT_SIZE = 50

      def initialize(*args)
        super
        character = Character.first_or_initialize(color: 'red', weapon: 'pitchfork_shield')
        options = {
          'New Game' => -> { game.go_to_scene(CreateCharacter) },
          'Load Game' => -> { game.go_to_scene(World, character: character) },
          'Options' => -> { puts 'Options' },
          'Quit' => -> { game.close }
        }
        @menu = UI::Menu.new(options)
      end

      def setup
        @font = Gosu::Font.new(FONT_SIZE, name: 'Courier')
      end

      def button_down(key_id)
        case key_id
        when Gosu::KbReturn
          menu.execute
        when Gosu::KbDown
          menu.next_option
        when Gosu::KbUp
          menu.previous_option
        end
      end

      def draw
        menu.options_with_colors.each_with_index do |(option, color), index|
          x = (game.width / 2) - FONT_SIZE * option.title.length / 4
          y = (game.height / 2) + FONT_SIZE * index
          font.draw(option.title, x, y, ZOrder::UI, 1, 1, color)
        end
      end
    end
  end
end
