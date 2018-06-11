require 'gosu'
require 'bakeru/scenes/base_scene'
require 'bakeru/background'
require 'bakeru/player'
require 'bakeru/map_templates'
require 'bakeru/models/location'

module Bakeru
  module Scenes
    class World < BaseScene
      attr_reader :player, :background, :bg_sound, :location

      def initialize(game, options={})
        super
        character = options.fetch(:character)
        @player = Player.new(game, character, game.width / 2, game.height / 2)
        @location = character.last_location || create_location
        update_character_last_location(character, location)
        @background = Background.new(game, @location, @player)
      end

      def setup
        @bg_sound = Gosu::Song.new('assets/sounds/muffled_wind.ogg')
        @bg_sound.play(true)
      end

      def button_down(key_id)
        player.button_down(key_id)
      end

      def button_up(key_id)
        player.button_up(key_id)
      end

      def update
        player.update
        background.update
      end

      def draw
        player.draw
        background.draw
      end

      private

      def create_location
        Location.build(Bakeru::MapTemplates::DungeonOfDespair).tap(&:save!)
      end

      def update_character_last_location(character, location)
        character.update(last_location: location)
      end
    end
  end
end
