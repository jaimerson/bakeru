require 'gosu'
require 'bakeru/scenes/base_scene'
require 'bakeru/background'
require 'bakeru/player'

module Bakeru
  module Scenes
    class World < BaseScene
      extend Forwardable

      attr_reader :player, :background, :bg_sound

      def_delegators :@player, :button_down, :button_up

      def initialize(game, options={})
        super
        character = options.fetch(:character)
        @player = Player.new(game, character, game.width / 2, game.height / 2)
        @background = Background.new(game)
      end

      def setup
        @bg_sound = Gosu::Song.new('assets/sounds/muffled_wind.ogg')
        @bg_sound.play(true)
      end

      def on_update
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
