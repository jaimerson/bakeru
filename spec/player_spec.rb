require 'spec_helper'
require 'src/player'

RSpec.describe Player do
  let(:game) { instance_double(Game, add_observer: nil) }

  describe '.new' do
    let(:frames) { Array.new(16) }

    it 'has default options' do
      expected_color = :red
      expected_weapon = :unarmed

      allow(Gosu::Image).to receive(:load_tiles)
        .and_return(frames)

      player = Player.new(game)

      expect(player.color).to eq(expected_color)
      expect(player.weapon).to eq(expected_weapon)
    end

    it 'adds itself to the game event subscribers' do
      expect(game).to receive(:add_observer)
        .with(an_instance_of(Player))
      Player.new(game)
    end

    it 'loads the right tiles' do
      width, height = Player::SPRITE_WIDTH, Player::SPRITE_HEIGHT

      expect(Gosu::Image).to receive(:load_tiles)
        .once
        .with('assets/sprites/imp/red/walk_unarmed.png', width, height)
        .and_return(frames)

      expect(Gosu::Image).to receive(:load_tiles)
        .once
        .with('assets/sprites/imp/red/attack_unarmed.png', width, height)
        .and_return(frames)

      Player.new(game)
    end

    describe 'animations setup' do
      let(:frames) { Array.new(16) { rand(1..10) } }

      before do
        allow(Gosu::Image).to receive(:load_tiles).and_return(frames)
      end

      let(:expected) do
        a_hash_including({
          walk: {
            up: an_instance_of(Animation),
            left: an_instance_of(Animation),
            down: an_instance_of(Animation),
            right: an_instance_of(Animation)
          },
          attack: {
            up: an_instance_of(PlayOnceAnimation),
            left: an_instance_of(PlayOnceAnimation),
            down: an_instance_of(PlayOnceAnimation),
            right: an_instance_of(PlayOnceAnimation)
          }
        })
      end

      it 'sets up the animations as expected' do
        animations = Player.new(game).animations
        expect(animations).to match(expected)
      end
    end
  end
end
