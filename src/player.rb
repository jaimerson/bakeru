require 'gosu'
require 'src/animation'
require 'src/animation/play_once_animation'
require 'src/zorder'

class Player
  SPRITE_WIDTH = 64
  SPRITE_HEIGHT = 64
  SCALE = 1.5
  SPEED = 3
  COLORS = [:red, :blue, :green]
  WEAPONS = [:unarmed, :sword, :pitchfork, :sword_shield, :pitchfork_shield]

  attr_reader :color, :weapon, :animations,
    :direction, :moving, :game, :current_action

  attr_accessor :vel_x, :vel_y

  def initialize(game, x=0, y=0, opts={})
    @game = game
    @game.add_observer(self)

    options = default_options.merge(opts)
    @color = options[:color]
    @weapon = options[:weapon]
    @direction = options[:direction]
    @moving = false
    @current_action = :walk

    self.vel_x = self.vel_y = 0

    setup_animations
    setup_sounds

    @x, @y = x, y
  end

  def on_update
    @x = (@x + self.vel_x)
    @y = (@y + self.vel_y)

    @x = 0 if @x < 0
    @x = game.width - SPRITE_WIDTH if @x + SPRITE_WIDTH > game.width
    @y = 0 if @y < 0
    @y = game.height - SPRITE_HEIGHT if @y + SPRITE_HEIGHT > game.height
  end

  def update(event, key_id)
    handler = {
      key_down: ->(id) { handle_key_down(id) },
      key_up: ->(id) { handle_key_up(id) }
    }[event]

    handler && handler.call(key_id)
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
    sound_speeds = { sword: 2.5, pitchfork: 0.5, sword_shield: 2.5, pitchfork_shield: 0.5 }
    @sword.play 0.5, sound_speeds.fetch(@weapon, 0.9)
    @moving = true
  end

  def stop
    @moving = false
  end

  def shuffle_color_and_weapon
    @color = COLORS.sample
    @weapon = WEAPONS.sample
    setup_animations
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
      Gosu::KbSpace => ->() { self.shuffle_color_and_weapon },
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

  def load_animation(action, duration=0.2, animation_entity: Animation)
    sprite_path = "assets/sprites/imp/#{@color}/#{action}_#{@weapon}.png"
    sprites = Gosu::Image.load_tiles(sprite_path, SPRITE_WIDTH, SPRITE_HEIGHT)

    {
      up: animation_entity.new(sprites[0..3], duration),
      left: animation_entity.new(sprites[4..7], duration),
      down: animation_entity.new(sprites[8..11], duration),
      right: animation_entity.new(sprites[12..15], duration)
    }
  end

  def default_options
    {
      color: :red,
      weapon: :unarmed,
      direction: :down
    }
  end
end
