require 'gosu'
require 'bakeru/scenes/base_scene'
require 'bakeru/scenes/world'
require 'bakeru/zorder'
require 'bakeru/models/imp'
require 'bakeru/animation'

module Bakeru
  module Scenes
    class LoadCharacter < BaseScene

      FONT_SIZE = 30

      attr_reader :characters, :selected_character, :font, :animations

      def setup
        @font = Gosu::Font.new(FONT_SIZE, name: 'Courier')
        @animations = load_animations
        @characters = Character.all
        @selected_character = @characters.first
      end

      def draw
        selected_character.attributes.each_with_index do |(key, value), index|
          font.draw("#{key}:", 10, 20 * index + FONT_SIZE, ZOrder::UI, 1, 1, 0xff_bf0a0a)
          font.draw(value, font.text_width(key) + 30, 20 * index + FONT_SIZE, ZOrder::UI, 1, 1, 0xff_bfbb30)
        end
        current_animation.start.draw 200, 200, ZOrder::UI, 5, 5
      end

      def button_down(key_id)
        case key_id
        when Gosu::KbReturn
          submit
        when Gosu::KbDown
          next_character
        when Gosu::KbUp
          previous_character
        end
      end

      def teardown
        game.text_input = nil
      end

      private

      def current_animation
        animations[selected_character[:color]][selected_character.weapon&.weapon_type || 'unarmed']
      end

      def load_animations
        Imp::COLORS.product(Imp::WEAPONS).reduce({}) do |acc, (color, weapon)|
          sprites = Imp.load_sprites(:walk, color: color, weapon: weapon)
          animation = Animation.new(sprites[8..11], 0.5) # walking down, 0.5 seconds per loop
          (acc[color] ||= {})[weapon] = animation
          acc
        end
      end

      def next_character
        return @selected_character = characters.first if selected_character == characters.last
        @selected_character = characters[characters.index(selected_character) + 1]
      end

      def previous_character
        return @selected_character = characters.last if selected_character == characters.first
        @selected_character = characters[characters.index(selected_character) - 1]
      end

      def submit
        game.go_to_scene(World, character: selected_character)
      end
    end
  end
end
