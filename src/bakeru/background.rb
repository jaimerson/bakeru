require 'gosu'
require 'bakeru/zorder'

module Bakeru
  class Background
    attr_reader :location
    TILE_SIZE = 64

    def initialize(location)
      @location = location

      available_tiles = Dir.glob('assets/sprites/tiles/floor/*').map do |file|
        [file.split('/').last.split('.').first, Gosu::Image.new(file)]
      end.to_h

      @tiles = location.tiles.map do |line|
        line.map do |tile_name|
          available_tiles[tile_name]
        end
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
end
