require 'gosu'
require 'bakeru/scenes/main_menu'
require 'gl'

module Bakeru
  # Main entry point for the game.
  # This class manages the current scene which can be changed with the `#go_to_scene` method.
  # It delegates the main events of `Gosu::Window`, such as drawing, updating and
  # handling keystrokes, to the current scene.
  #
  # By default it starts with the scene `Bakeru::Scenes::MainMenu`
  class Game < Gosu::Window
    include Gl

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
      current_scene.update
    end

    def draw
      # Enable OpenGL rendering
      gl do
        current_scene.draw
      end
    end

    # @param [Integer] id - the id of the key pressed
    # @see https://www.rubydoc.info/github/gosu/gosu/Gosu for reference of key values
    def button_down(id)
      if id == Gosu::KB_ESCAPE
        go_to_scene(Scenes::MainMenu)
      else
        current_scene.button_down(id)
      end
    end

    def button_up(id)
      current_scene.button_up(id)
    end

    def go_to_main_scene
      go_to_main_scene(Scenes::MainMenu)
    end

    # @param [Bakeru::Scene::Base] scene_class - the scene class to setup
    # @param [Hash] options - the options to pass to scene initialization
    def go_to_scene(scene_class, options={})
      previous_scene = current_scene
      @current_scene = setup_scene(scene_class, options)
      previous_scene.teardown
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
