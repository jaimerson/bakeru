require 'gosu'

class Animation
  attr_reader :frames, :time, :type

  def initialize(frames, time_in_secs, type: :continuous)
    raise ArgumentError, 'Frames cannot be empty' if frames.empty?
    raise ArgumentError, 'Time must be > 0' if time_in_secs.to_f <= 0

    @frames = frames
    @time = time_in_secs * 1000
  end

  def start
    frames[Gosu::milliseconds / time % frames.size]
  end

  def stop
    frames[0]
  end
end
