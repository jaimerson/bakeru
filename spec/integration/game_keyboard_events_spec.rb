require 'spec_helper'
require 'bakeru/game'
require 'bakeru/scenes/world'
require 'bakeru/scenes/main_menu'
require 'bakeru/models/character'

RSpec.describe 'Keyboard events' do
  let(:game) { Bakeru::Game.new(width: 500, height: 500) }
  let(:scene) { game.current_scene }

  before do
    character = Bakeru::Character.new(color: 'red', weapon: 'unarmed')
    game.go_to_scene(Bakeru::Scenes::World, character: character)
    game.update
  end

  context 'when it is a key down' do
    it 'goes to main menu when key is ESC' do
      expect(game).to receive(:go_to_scene).with(Bakeru::Scenes::MainMenu)
      game.button_down(Gosu::KB_ESCAPE)
    end

    it 'makes the player walk left when key is KbLeft' do
      expect(scene.player).to receive(:walk)
        .with(:left)
      game.button_down(Gosu::KbLeft)
    end

    it 'makes the player walk right when key is KbRight' do
      expect(scene.player).to receive(:walk)
        .with(:right)
      game.button_down(Gosu::KbRight)
    end

    it 'makes the player walk up when key is KbUp' do
      expect(scene.player).to receive(:walk)
        .with(:up)
      game.button_down(Gosu::KbUp)
    end

    it 'makes the player walk down when key is KbDown' do
      expect(scene.player).to receive(:walk)
        .with(:down)
      game.button_down(Gosu::KbDown)
    end

    it 'makes the player attack when key is KbA' do
      expect(scene.player).to receive(:attack)
      game.button_down(Gosu::KbA)
    end
  end

  context 'when event is key up' do
    it 'makes the player stop walking left when key if KbLeft' do
      expect(scene.player).to receive(:stop_walking)
        .with(:left)
      game.button_up(Gosu::KbLeft)
    end

    it 'makes the player stop walking up when key if KbUp' do
      expect(scene.player).to receive(:stop_walking)
        .with(:up)
      game.button_up(Gosu::KbUp)
    end

    it 'makes the player stop walking right when key if KbRight' do
      expect(scene.player).to receive(:stop_walking)
        .with(:right)
      game.button_up(Gosu::KbRight)
    end

    it 'makes the player stop walking down when key if KbDown' do
      expect(scene.player).to receive(:stop_walking)
        .with(:down)
      game.button_up(Gosu::KbDown)
    end
  end
end
