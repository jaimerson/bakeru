require 'spec_helper'
require 'bakeru/game'
require 'bakeru/scenes/world'
require 'bakeru/models/character'

RSpec.describe Bakeru::Game do
  let(:character) { Bakeru::Character.new(color: 'red', weapon: Bakeru::Weapon.new) }

  it 'inherits from Gosu::Window' do
    expect(described_class.ancestors).to include(Gosu::Window)
  end

  describe '.start' do
    let(:default_settings) do
      {
        fullscreen: false,
        height: 720,
        width: 1080
      }
    end

    it 'has default settings' do
      game = double(show: nil)

      expect(described_class).to receive(:new)
        .with(default_settings)
        .and_return(game)

      described_class.start
    end

    it 'allows default settings override' do
      game = double(show: nil)
      title = 'Knights who say ni'
      updated_settings = default_settings.merge(caption: title)

      expect(described_class).to receive(:new)
        .with(updated_settings)
        .and_return(game)

      described_class.start(caption: title)
    end
  end

  describe '#update' do
    let(:game) { described_class.new(width: 500, height: 500) }

    before do
      game.go_to_scene(Bakeru::Scenes::World, character: character)
    end

    it 'calls the player#on_update' do
      expect(game.current_scene.player).to receive(:update)
      game.update
    end
  end

  describe '#draw' do
    let(:game) { described_class.new(width: 500, height: 500) }
    let(:player) { instance_double(Bakeru::Player, draw: nil) }
    let(:background) { instance_double(Bakeru::Background, draw: nil) }

    before do
      allow(Bakeru::Background).to receive(:new).and_return(background)
      allow(Bakeru::Player).to receive(:new).and_return(player)
      allow(game).to receive(:gl).and_yield
      game.go_to_scene(Bakeru::Scenes::World, character: character)
    end

    it 'calls background#draw' do
      expect(background).to receive(:draw)
      game.draw
    end

    it 'calls player#draw' do
      expect(player).to receive(:draw)
      game.draw
    end
  end
end
