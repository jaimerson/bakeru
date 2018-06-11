require 'bakeru/models/item'

module Bakeru
  class Weapon < Item
    DEFAULT_DAMAGE = 0

    def weapon_type
      data['weapon_type'] || DEFAULT_WEAPON_TYPE
    end

    def weapon_type=(value)
      data['weapon_type'] = value
    end

    def damage
      data['damage'] || DEFAULT_DAMAGE
    end

    def damage=(value)
      data['damage'] = value
    end
  end
end
