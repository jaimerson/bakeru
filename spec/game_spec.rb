require 'spec_helper'
require 'src/game'
require 'src/background'
require 'src/player'

RSpec.describe Game do
  it 'inherits from Gosu::Window' do
    expect(described_class.ancestors).to include(Gosu::Window)
  end

  describe '.start' do
    let(:default_settings) do
      {
        fullscreen: false,
        height: 480,
        width: 640
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
    let(:game) { Game.new(width: 500, height: 500) }

    it 'calls the player#on_update' do
      expect(game.player).to receive(:on_update)
      game.update
    end
  end

  describe '#draw' do
    let(:game) { Game.new(width: 500, height: 500) }
    let(:player) { instance_double(Player, draw: nil) }
    let(:background) { instance_double(Background, draw: nil) }

    before do
      allow(Background).to receive(:new).and_return(background)
      allow(Player).to receive(:new).and_return(player)
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
