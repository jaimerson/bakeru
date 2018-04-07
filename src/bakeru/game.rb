require 'gosu'
require 'observer'
require 'bakeru/scenes/main_menu'
require 'bakeru/scenes/world'

module Bakeru
  class Game < Gosu::Window
    include Observable

    AVAILABLE_SCENES = {
      main_menu: MainMenu,
      world: World
    }.freeze

    def self.start(settings={})
      new(default_settings.merge(settings)).show
    end

    attr_reader :width, :height, :current_scene

    def initialize(options={})
      @width = options.delete(:width)
      @height = options.delete(:height)
      @observers_to_add = []
      @current_scene = setup_scene(AVAILABLE_SCENES.values.first)

      super(@width, @height, options)
    end

    def update
      current_scene.on_update
      @observers_to_add.each do |observer|
        self.add_observer(observer)
      end
      @observers_to_add = []
    end

    def draw
      current_scene.draw
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

    def go_to_scene(key)
      previous_scene = current_scene
      scene_class = AVAILABLE_SCENES.fetch(key)
      @current_scene = setup_scene(scene_class)
      delete_observer(previous_scene)
    end

    def lazy_add_observer(observer)
      @observers_to_add |= [observer]
    end

    private

    DEFAULT_SETTINGS = {
      fullscreen: false,
      height: 720,
      width: 1080
    }.freeze

    def setup_scene(scene_class)
      scene_class.new(self)
    end

    def self.default_settings
      DEFAULT_SETTINGS
    end
  end
end
