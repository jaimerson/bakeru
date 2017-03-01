require 'spec_helper'
require 'src/game'

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
end
