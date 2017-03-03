require 'gosu'
require 'src/animation'

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

  def initialize(x=0, y=0, opts={})
    options = default_options.merge(opts)
    @color = options[:color]
    @weapon = options[:weapon]
    @direction = options[:direction]
    @moving = false
    @game = options[:game]
    @current_action = :walk

    self.vel_x = self.vel_y = 0

    setup_animations

    @x, @y = x, y
  end

  def update
    @x = (@x + self.vel_x) % game.width
    @y = (@y + self.vel_y) % game.height
  end

  def walk(direction)
    @direction = direction
    @moving = true

    {
      up: ->() { self.vel_y -= SPEED },
      down: ->() { self.vel_y += SPEED },
      left: ->() { self.vel_x -= SPEED },
      right: ->() { self.vel_x += SPEED },
    }.fetch(direction).call
  end

  def attack
    @current_action = :attack
    @moving = true
  end

  def stop
    @moving = false
    @current_action = :walk
    self.vel_x = self.vel_y = 0
  end

  def shuffle_color_and_weapon
    @color = COLORS.sample
    @weapon = WEAPONS.sample
    setup_animations
  end

  def draw
    if moving
      current_animation.start.draw @x, @y, 1, SCALE, SCALE
    else
      current_animation.stop.draw @x, @y, 1, SCALE, SCALE
    end
  end

  private

  def current_animation
    animations[current_action][direction]
  end

  def setup_animations
    @animations = {
      walk: load_animation(:walk),
      attack: load_animation(:attack)
    }
  end

  def load_animation(action, duration=0.2)
    sprite_path = "assets/sprites/imp/#{@color}/#{action}_#{@weapon}.png"
    sprites = Gosu::Image.load_tiles(sprite_path, SPRITE_WIDTH, SPRITE_HEIGHT)

    {
      up: Animation.new(sprites[0..3], duration),
      left: Animation.new(sprites[4..7], duration),
      down: Animation.new(sprites[8..11], duration),
      right: Animation.new(sprites[12..15], duration)
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
