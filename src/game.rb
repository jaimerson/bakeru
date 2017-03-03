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
    @player = Player.new(@width / 2, @height / 2, game: self)

    super(@width, @height, options)
  end

  def update
    @player.update
  end

  def draw
    @player.draw
  end

  def button_down(id)
    {
      Gosu::KB_ESCAPE => ->() { close },
      Gosu::KbLeft => ->() { @player.walk :left },
      Gosu::KbRight => ->() { @player.walk :right },
      Gosu::KbUp => ->() { @player.walk :up },
      Gosu::KbDown => ->() { @player.walk :down },
      Gosu::KbSpace => ->() { @player.shuffle_color_and_weapon }
    }.fetch(id, ->() { super }).call
  end

  def button_up(id)
    movement_keys = [Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight]
    if movement_keys.include?(id)
      @player.stop
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
