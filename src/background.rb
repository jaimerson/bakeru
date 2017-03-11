require 'gosu'
require 'src/zorder'

class Background
  attr_reader :game, :player
  TILE_SIZE = 64

  def initialize(game, player)
    @game = game
    @player = player
    @image = Gosu::Image.new('assets/sprites/tiles/floor/0000_floor_default.bmp')

    number_of_x_tiles = (game.width / TILE_SIZE.to_f).ceil
    number_of_y_tiles = (game.height / TILE_SIZE.to_f).ceil
    @tiles = Array.new(number_of_x_tiles) do
      Array.new(number_of_y_tiles) { @image }
    end
  end

  def update

  end

  def draw
    @tiles.each_with_index do |tiles, line|
      tiles.each_with_index do |tile, column|
        tile.draw line * TILE_SIZE, column * TILE_SIZE, ZOrder::BACKGROUND
      end
    end
  end
end
