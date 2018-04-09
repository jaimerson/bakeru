require 'gosu'

module Bakeru
  class Animation
    attr_reader :frames, :time_per_frame, :current_frame, :type

    def initialize(frames, time_in_secs)
      raise ArgumentError, 'Frames cannot be empty' if frames.empty?
      raise ArgumentError, 'Time must be > 0' if time_in_secs.to_f <= 0

      @frames = frames
      @time_per_frame = time_in_secs / frames.size
      @current_frame = frames.first
    end

    def start
      now = Gosu::milliseconds

      if !@time
        @time = now
      elsif Gosu::milliseconds - @time >= time_per_frame * 1000
        @time = nil
        @current_frame = next_frame
      end
      current_frame
    end

    def next_frame
      return frames.first if current_frame == frames.last
      frames[frames.index(current_frame) + 1]
    end

    def stop
      frames[0]
    end
  end
end
