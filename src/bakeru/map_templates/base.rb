module Bakeru
  module MapTemplates
    class Base
      class << self
        attr_accessor :map, :item_locations

        def define_map(x_tiles, y_tiles, &block)
          map = Map.new(x_tiles, y_tiles)
          map.instance_eval(&block)
          self.map = map.tile_names
          self.item_locations = map.item_locations
        end
      end

      class Map
        attr_reader :number_of_x_tiles, :number_of_y_tiles, :item_locations

        def initialize(number_of_x_tiles, number_of_y_tiles)
          @number_of_x_tiles = number_of_x_tiles
          @number_of_y_tiles = number_of_y_tiles
          @custom_tiles = {}
          @item_locations = []
        end

        def default_tile(tile)
          @default_tile = tile
        end

        def tile_names
          tiles = Array.new(number_of_x_tiles) do
            Array.new(number_of_y_tiles) do
              @default_tile
            end
          end

          apply_custom_tiles(tiles)
        end

        def apply_custom_tiles(tiles)
          return tiles if @custom_tiles.empty?
          @custom_tiles.each do |(i, j), value|
            tiles[i][j] = value
          end
          tiles
        end

        def item(item_type, map_location:, **kwargs)
          @item_locations << {
            map_location: map_location,
            item_attributes: {
              type: ITEM_TYPES[item_type], **kwargs
            }
          }
        end

        def tiles(list_of_tiles, value)
          list_of_tiles.each do |tile|
            @custom_tiles[tile] = value
          end
        end

        private

        ITEM_TYPES = {
          weapon: 'Bakeru::Weapon',
          shield: 'Bakeru::Shield',
          consumable: 'Bakeru::Consumable'
        }
      end
    end
  end
end
