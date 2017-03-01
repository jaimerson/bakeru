class Game < Gosu::Window
  def self.start(settings={})
    new(default_settings.merge(settings)).show
  end

  attr_reader :options

  def initialize(options={})
    width = options.delete(:width)
    height = options.delete(:height)

    super(width, height, options)
  end

  def update

  end

  def draw

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
