require 'spec_helper'

RSpec.describe 'Keyboard events' do
  let(:game) { Game.new(width: 500, height: 500) }

  context 'when it is a key down' do
    it 'closes the game when key is ESC' do
      expect(game).to receive(:close)
      game.button_down(Gosu::KB_ESCAPE)
    end

    it 'makes the player walk left when key is KbLeft' do
      expect(game.player).to receive(:walk)
        .with(:left)
      game.button_down(Gosu::KbLeft)
    end

    it 'makes the player walk right when key is KbRight' do
      expect(game.player).to receive(:walk)
        .with(:right)
      game.button_down(Gosu::KbRight)
    end

    it 'makes the player walk up when key is KbUp' do
      expect(game.player).to receive(:walk)
        .with(:up)
      game.button_down(Gosu::KbUp)
    end

    it 'makes the player walk down when key is KbDown' do
      expect(game.player).to receive(:walk)
        .with(:down)
      game.button_down(Gosu::KbDown)
    end

    # This will probably be removed, but test it anyway
    it 'shuffles the color and weapon when key is KbSpace' do
      expect(game.player).to receive(:shuffle_color_and_weapon)
      game.button_down(Gosu::KbSpace)
    end

    it 'makes the player attack when key is KbA' do
      expect(game.player).to receive(:attack)
      game.button_down(Gosu::KbA)
    end
  end

  context 'when event is key up' do
    it 'makes the player stop walking left when key if KbLeft' do
      expect(game.player).to receive(:stop_walking)
        .with(:left)
      game.button_up(Gosu::KbLeft)
    end

    it 'makes the player stop walking up when key if KbUp' do
      expect(game.player).to receive(:stop_walking)
        .with(:up)
      game.button_up(Gosu::KbUp)
    end

    it 'makes the player stop walking right when key if KbRight' do
      expect(game.player).to receive(:stop_walking)
        .with(:right)
      game.button_up(Gosu::KbRight)
    end

    it 'makes the player stop walking down when key if KbDown' do
      expect(game.player).to receive(:stop_walking)
        .with(:down)
      game.button_up(Gosu::KbDown)
    end
  end
end
