require 'spec_helper'
require 'bakeru/models'
require 'bakeru/map_templates/base'

RSpec.describe Bakeru::Location do
  describe '.build' do
    subject(:build) { described_class.build(MyTerrificDungeon) }
    let(:location) { build }

    before do
      stub_const('MyTerrificDungeon', Class.new(Bakeru::MapTemplates::Base) do
        define_map(10, 10) do
          default_tile '0036_floor_default'
          item :weapon,
            map_location: '5,5',
            weapon_type: 'pitchfork',
            name: 'Blessed Pitchfork of Glory',
            damage: 30
        end
      end)
    end

    it 'adds the template name' do
      expect(location.template).to eq('MyTerrificDungeon')
    end

    it 'adds the tiles' do
      expect(location.tiles[0].first).to eq('0036_floor_default')
    end

    it 'creates item location' do
      expect { location.save }.to change(Bakeru::Weapon, :count)
      weapon = location.items.first
      expect(weapon.weapon_type).to eq('pitchfork')
      expect(weapon.damage).to eq(30)
      expect(weapon.name).to eq('Blessed Pitchfork of Glory')
      expect(location.item_locations.first.map_location).to eq('5,5')
    end
  end
end
