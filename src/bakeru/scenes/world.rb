require 'gosu'
require 'bakeru/scenes/base_scene'
require 'bakeru/background'
require 'bakeru/player'
require 'bakeru/map_templates'
require 'bakeru/models/location'

module Bakeru
  module Scenes
    class World < BaseScene
      attr_reader :player, :background, :bg_sound

      def initialize(game, options={})
        super
        character = options.fetch(:character)
        @player = Player.new(game, character, game.width / 2, game.height / 2)
        location = Location.build(Bakeru::MapTemplates::DungeonOfDespair)
        @background = Background.new(game, location, @player)
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
    end
  end
end
