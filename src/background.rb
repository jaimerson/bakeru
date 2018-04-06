require 'gosu'
require 'zorder'

class Background
  attr_reader :game
  TILE_SIZE = 64

  def initialize(game)
    @game = game

    number_of_x_tiles = 20
    number_of_y_tiles = (game.height / TILE_SIZE.to_f).ceil
    available_tiles = Dir.glob('assets/sprites/tiles/floor/*').map do |file|
      [file.split('/').last.split('.').first, Gosu::Image.new(file)]
    end.to_h

    @tiles = Array.new(number_of_x_tiles) do
      Array.new(number_of_y_tiles) do
        available_tiles['0036_floor_default']
      end
    end

    @tiles[5][5] = available_tiles['0014_floor_default']
    @tiles[6][5] = available_tiles['0015_floor_default']
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
