require 'gosu'
require 'src/player'

class Game < Gosu::Window
  def self.start(settings={})
    new(default_settings.merge(settings)).show
  end

  attr_reader :width, :height

  def initialize(options={})
    @width = options.delete(:width)
    @height = options.delete(:height)
    @player = Player.new(@width / 2, @height / 2)

    super(@width, @height, options)
  end

  def update

  end

  def draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
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
