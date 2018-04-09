module Bakeru
  module Scenes
    class BaseScene
      attr_reader :game

      def initialize(game, options={})
        @game = game
        setup
      end

      def setup
      end

      def on_update
      end

      # Called when a key is pressed
      # @param [Fixnum] key_id - id of the key pressed.
      #   Use convenience Gosu::Kb* constants to access
      def button_down(key_id)
      end

      # Called when a key is released
      # @param [Fixnum] key_id - id of the key pressed.
      #   Use convenience Gosu::Kb* constants to access
      def button_up(key_id)
      end

      def draw
        raise NotImplementedError
      end
    end
  end
end
