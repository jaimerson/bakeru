require 'bakeru/map_templates/base'

module Bakeru
  module MapTemplates
    class DungeonOfDespair < Base
      define_map(20, 20) do
        default_tile '0036_floor_default'
        tiles [[5, 5]], '0014_floor_default'
        tiles [[6, 5]], '0015_floor_default'
      end
    end
  end
end
