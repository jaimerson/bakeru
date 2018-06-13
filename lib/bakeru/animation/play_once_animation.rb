require 'gosu'
require 'bakeru/animation'

module Bakeru
  class PlayOnceAnimation < Animation
    def initialize(*args)
      super(*args)
      @played_frames = []
    end

    def start
      frame = super
      @played_frames << frame
      frame
    end

    def stop
      return start unless (frames - @played_frames).empty?
      @played_frames = []
      yield if block_given?
      super
    end
  end
end
