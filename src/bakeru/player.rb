require 'gosu'
require 'bakeru/animation'
require 'bakeru/animation/play_once_animation'
require 'bakeru/zorder'
require 'bakeru/models/character'
require 'bakeru/models/imp'

module Bakeru
  class Player
    SCALE = 1.5
    SPEED = 3
    SOUND_SPEEDS = { sword: 2.5, pitchfork: 0.5, sword_shield: 2.5, pitchfork_shield: 0.5 }.freeze

    extend Forwardable

    attr_reader :animations, :direction, :moving, :game, :current_action, :x, :y

    def_delegators :@character, :color, :weapon

    attr_accessor :vel_x, :vel_y

    def initialize(game, character, x=0, y=0, options={})
      @game = game
      @character = character

      @direction = options[:direction]
      @moving = false
      @current_action = :walk

      self.vel_x = self.vel_y = 0

      setup_animations
      setup_sounds

      @x, @y = x, y
    end

    def update
      @x = (@x + self.vel_x)
      @y = (@y + self.vel_y)

      @x = 0 if @x < 0
      @x = game.width - Imp::SPRITE_WIDTH if @x + Imp::SPRITE_WIDTH > game.width
      @y = 0 if @y < 0
      @y = game.height - Imp::SPRITE_HEIGHT if @y + Imp::SPRITE_HEIGHT > game.height
    end

    def button_down(key_id)
      handle_key_down(key_id)
    end

    def button_up(key_id)
      handle_key_up(key_id)
    end

    def walk(direction)
      @current_action = :walk
      @direction = direction
      @moving = true

      {
        up: ->() { self.vel_y -= SPEED },
        down: ->() { self.vel_y += SPEED },
        left: ->() { self.vel_x -= SPEED },
        right: ->() { self.vel_x += SPEED },
      }.fetch(direction).call
    end

    def stop_walking(direction)
      if [:left, :right].include? direction
        self.vel_x = 0
      elsif [:up, :down].include? direction
        self.vel_y = 0
      end

      stop if self.vel_x == 0 && self.vel_y == 0
    end

    def attack
      @current_action = :attack
      @sword.play 0.5, SOUND_SPEEDS.fetch(@weapon, 0.9)
      @moving = true
    end

    def stop
      @moving = false
    end

    def draw
      if moving
        current_animation.start.draw @x, @y, ZOrder::PLAYER, SCALE, SCALE
      else
        current_animation.stop do
          @current_action = :walk
          @moving = walking?
        end.draw @x, @y, 1, SCALE, SCALE
      end
    end

    private

    def walking?
      self.vel_x != 0 || self.vel_y != 0
    end

    def handle_key_down(id)
      handler = {
        Gosu::KbLeft => ->() { self.walk :left },
        Gosu::KbRight => ->() { self.walk :right },
        Gosu::KbUp => ->() { self.walk :up },
        Gosu::KbDown => ->() { self.walk :down },
        Gosu::KbA => ->() { self.attack }
      }[id]

      handler && handler.call
    end

    def handle_key_up(id)
      handler = {
        Gosu::KbLeft  => ->() { stop_walking(:left) },
        Gosu::KbUp    => ->() { stop_walking(:up) },
        Gosu::KbRight => ->() { stop_walking(:right) },
        Gosu::KbDown  => ->() { stop_walking(:down) },
        Gosu::KbA     => ->() { stop }
      }[id]

      handler && handler.call
    end

    def current_animation
      animations[current_action][direction]
    end

    def setup_animations
      @animations = {
        walk: load_animation(:walk),
        attack: load_animation(:attack, animation_entity: PlayOnceAnimation)
      }
    end

    def setup_sounds
      @sword = Gosu::Sample.new('assets/sounds/swing_sword.wav')
    end

    def load_animation(action, duration=0.5, animation_entity: Animation)
      sprites = Imp.load_sprites(action, weapon: weapon&.weapon_type || :unarmed, color: color)

      {
        up: animation_entity.new(sprites[0..3], duration),
        left: animation_entity.new(sprites[4..7], duration),
        down: animation_entity.new(sprites[8..11], duration),
        right: animation_entity.new(sprites[12..15], duration)
      }
    end
  end
end
