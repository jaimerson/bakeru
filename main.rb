require 'rubygems'
require 'bundler/setup'

Bundler.setup(:default)
require 'gosu'

$LOAD_PATH << './src'

require 'bakeru'

Bakeru::Game.start
