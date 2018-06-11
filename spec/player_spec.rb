require 'spec_helper'
require 'bakeru/animation'
require 'bakeru/game'
require 'bakeru/player'
require 'bakeru/models/imp'

RSpec.describe Bakeru::Player do
  let(:character) { Bakeru::Character.new(color: 'red') }
  let(:game) { instance_double(Bakeru::Game) }

  describe '.new' do
    let(:frames) { Array.new(16) }

    it 'loads the right tiles' do
      width, height = Bakeru::Imp::SPRITE_WIDTH, Bakeru::Imp::SPRITE_HEIGHT

      expect(Gosu::Image).to receive(:load_tiles)
        .once
        .with('assets/sprites/imp/red/walk_unarmed.png', width, height)
        .and_return(frames)

      expect(Gosu::Image).to receive(:load_tiles)
        .once
        .with('assets/sprites/imp/red/attack_unarmed.png', width, height)
        .and_return(frames)

      described_class.new(game, character)
    end

    describe 'animations setup' do
      let(:frames) { Array.new(16) { rand(1..10) } }

      before do
        allow(Gosu::Image).to receive(:load_tiles).and_return(frames)
      end

      let(:expected) do
        a_hash_including({
          walk: {
            up: an_instance_of(Bakeru::Animation),
            left: an_instance_of(Bakeru::Animation),
            down: an_instance_of(Bakeru::Animation),
            right: an_instance_of(Bakeru::Animation)
          },
          attack: {
            up: an_instance_of(Bakeru::PlayOnceAnimation),
            left: an_instance_of(Bakeru::PlayOnceAnimation),
            down: an_instance_of(Bakeru::PlayOnceAnimation),
            right: an_instance_of(Bakeru::PlayOnceAnimation)
          }
        })
      end

      it 'sets up the animations as expected' do
        animations = described_class.new(game, character).animations
        expect(animations).to match(expected)
      end
    end
  end
end
