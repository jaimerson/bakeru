module Bakeru
  module Builders
    class CharacterBuilder
      BUILDS = [
        {
          color: 'red',
          weapon: 'unarmed',
          vitality: 10,
          strength: 15,
          magic: 5,
          endurance: 10
        },
        {
          color: 'green',
          weapon: 'unarmed',
          vitality: 10,
          strength: 10,
          magic: 10,
          endurance: 10
        },
        {
          color: 'blue',
          weapon: 'unarmed',
          vitality: 10,
          strength: 7,
          magic: 15,
          endurance: 8
        }
      ].freeze
    end
  end
end
