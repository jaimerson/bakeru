module Bakeru
  class Imp
    COLORS = %w[red blue green].freeze
    WEAPONS = %w[unarmed sword pitchfork sword_shield pitchfork_shield].freeze
    SPRITE_WIDTH = 64
    SPRITE_HEIGHT = 64

    def self.load_sprites(action, weapon: nil, color: :red)
      weapon ||= :unarmed
      sprite_path = "assets/sprites/imp/#{color}/#{action}_#{weapon}.png"
      Gosu::Image.load_tiles(sprite_path, SPRITE_WIDTH, SPRITE_HEIGHT)
    end
  end
end
