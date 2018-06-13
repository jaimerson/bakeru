require 'gosu'
require 'bakeru/builders/character_builder'
require 'bakeru/scenes/base_scene'
require 'bakeru/scenes/world'
require 'bakeru/zorder'
require 'bakeru/models/imp'
require 'bakeru/animation'

module Bakeru
  module Scenes
    class CreateCharacter < BaseScene
      class TextInput < Gosu::TextInput
        def filter(text_in)
          text_in.gsub(/[^A-Za-z0-9]/, '')
        end
      end

      FONT_SIZE = 30

      attr_reader :character, :builds, :selected_build, :font, :name_text_input, :animations

      def setup
        @character = Character.new
        @builds = Builders::CharacterBuilder::BUILDS
        @selected_build = @builds.first
        @font = Gosu::Font.new(FONT_SIZE, name: 'Courier')
        @game.text_input = @name_text_input = TextInput.new
        @animations = load_animations
        @message = nil
      end

      def draw
        font.draw('Name:', 10, 10, ZOrder::UI, 1, 1, 0xff_bf0a0a)
        font.draw(name_text_input.text, font.text_width('Name:') + 20, 10, ZOrder::UI, 1, 1, 0xff_bfbb30)
        if @message
          font.draw(@message, font.text_width(name_text_input.text) + 200, 10, ZOrder::UI, 1, 1, 0xff_bfbbff)
        end
        selected_build.each_with_index do |(key, value), index|
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
          next_build
        when Gosu::KbUp
          previous_build
        end
      end

      def teardown
        game.text_input = nil
      end

      private

      def current_animation
        animations[selected_build[:color]]
      end

      def load_animations
        Imp::COLORS.map do |color|
          sprites = Imp.load_sprites(:walk, color: color)
          animation = Animation.new(sprites[8..11], 0.5) # walking down, 0.5 seconds per loop
          [color, animation]
        end.to_h
      end

      def next_build
        return @selected_build = builds.first if selected_build == builds.last
        @selected_build = builds[builds.index(selected_build) + 1]
      end

      def previous_build
        return @selected_build = builds.last if selected_build == builds.first
        @selected_build = builds[builds.index(selected_build) - 1]
      end

      def submit
        character.attributes = selected_build
          .merge(name: name_text_input.text)
        if character.save
          game.go_to_scene(World, character: character)
        else
          @message = character.errors.full_messages.join(';')
        end
      end
    end
  end
end
