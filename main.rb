require 'rubygems'
require 'bundler/setup'

Bundler.setup(:default)
require 'gosu'

$LOAD_PATH << '.'

require 'src/game'

Game.start
