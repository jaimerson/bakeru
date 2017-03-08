require 'gosu'
require 'observer'
require 'src/player'

class Game < Gosu::Window
  include Observable

  def self.start(settings={})
    new(default_settings.merge(settings)).show
  end

  attr_reader :width, :height, :player

  def initialize(options={})
    @width = options.delete(:width)
    @height = options.delete(:height)
    @player = Player.new(self, @width / 2, @height / 2)

    super(@width, @height, options)
  end

  def update
    @player.on_update
  end

  def draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      changed
      notify_observers(:key_down, id)
    end
  end

  def button_up(id)
    changed
    notify_observers(:key_up, id)
  end

  private

  DEFAULT_SETTINGS = {
    fullscreen: false,
    height: 480,
    width: 640
  }.freeze

  def self.default_settings
    DEFAULT_SETTINGS
  end
end
