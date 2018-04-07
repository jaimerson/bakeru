module Bakeru
  class BaseScene
  attr_reader :game

  def initialize(game, options={})
    @game = game
    @game.lazy_add_observer(self)
    setup
  end

  def setup
  end

  def on_update
  end

  # Called when a key is pressed
  # @param [Symbol] event - :key_down or :key_up
  # @param [Fixnum] key_id - id of the key pressed.
  #   Use convenience Gosu::Kb* constants to access
  def update(event, key_id)
  end

  def draw
    raise NotImplementedError
  end
  end
end
