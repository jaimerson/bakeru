class Player
  def initialize(x, y, color=:red, weapon=:unarmed)
    sprite_path = "assets/sprites/imp/#{color}/walk_#{weapon}.png"
    @sprites = Gosu::Image.load_tiles(sprite_path, 65, 70)
    @x, @y = x, y
  end

  def draw
    @sprites.first.draw @x, @y, 1
  end
end
