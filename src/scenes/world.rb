require 'gosu'
require 'scenes/base_scene'
require 'background'
require 'player'

class World < BaseScene
  attr_reader :player, :background, :bg_sound

  def initialize(*args)
    super
    @player = Player.new(game, game.width / 2, game.height / 2)
    @background = Background.new(game)
  end

  def setup
    @bg_sound = Gosu::Song.new('assets/sounds/muffled_wind.ogg')
    @bg_sound.play(true)
  end

  def on_update
    player.on_update
    background.update
  end

  def draw
    player.draw
    background.draw
  end
end
