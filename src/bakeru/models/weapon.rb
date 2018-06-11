require 'bakeru/models/item'

module Bakeru
  class Weapon < Item
    DEFAULT_DAMAGE = 0
    DEFAULT_WEAPON_TYPE = 'sword'.freeze

    validates :weapon_type, presence: true, inclusion: { in: ::Bakeru::Imp::WEAPONS }

    before_validation :set_default_weapon_type, unless: -> { weapon_type.present? }

    def weapon_type
      data['weapon_type']
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

    private

    def set_default_weapon_type
      data['weapon_type'] = DEFAULT_WEAPON_TYPE
    end
  end
end
