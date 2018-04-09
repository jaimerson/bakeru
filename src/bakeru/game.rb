require 'gosu'
require 'bakeru/scenes/main_menu'

module Bakeru
  class Game < Gosu::Window
    def self.start(settings={})
      new(default_settings.merge(settings)).show
    end

    attr_reader :width, :height, :current_scene

    def initialize(options={})
      @width = options.delete(:width)
      @height = options.delete(:height)
      @current_scene = setup_scene(Scenes::MainMenu)

      super(@width, @height, options)
    end

    def update
      current_scene.on_update
    end

    def draw
      current_scene.draw
    end

    def button_down(id)
      if id == Gosu::KB_ESCAPE
        close
      else
        current_scene.button_down(id)
      end
    end

    def button_up(id)
      current_scene.button_up(id)
    end

    def go_to_scene(scene_class, options={})
      @current_scene = setup_scene(scene_class, options)
    end

    private

    DEFAULT_SETTINGS = {
      fullscreen: false,
      height: 720,
      width: 1080
    }.freeze

    def setup_scene(scene_class, options={})
      scene_class.new(self, options)
    end

    def self.default_settings
      DEFAULT_SETTINGS
    end
  end
end
