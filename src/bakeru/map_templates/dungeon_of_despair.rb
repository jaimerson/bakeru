require 'bakeru/map_templates/base'

module Bakeru
  module MapTemplates
    class DungeonOfDespair < Base
      define_map(20, 20) do
        default_tile '0036_floor_default'
        tiles [[5, 5]], '0014_floor_default'
        tiles [[5, 6]], '0015_floor_default'

        item :weapon, weapon_type: 'sword', name: 'Sword of Eternal Evil', damage: 100,
          map_location: '7,7'
      end
    end
  end
end
