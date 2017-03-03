require 'spec_helper'
require 'src/animation'

RSpec.describe Animation do
  subject(:animation) { Animation.new(frames, time_in_secs) }
  let(:frames) { [1,2,3] }
  let(:time_in_secs) { 1 }

  describe 'validations' do
    context 'when frames are empty' do
      let(:frames) { [] }

      it 'raises argument error' do
        expect { animation }.to raise_error(ArgumentError, 'Frames cannot be empty')
      end
    end

    context 'when the time is negative' do
      let(:time_in_secs) { -2 }

      it 'raises argument error' do
        expect { animation }.to raise_error(ArgumentError, 'Time must be > 0')
      end
    end

    context 'when the time is zero' do
      let(:time_in_secs) { 0.0 }

      it 'raises argument error' do
        expect { animation }.to raise_error(ArgumentError, 'Time must be > 0')
      end
    end

    context 'when everything is fine' do
      it 'raises nothing :)' do
        expect { animation }.not_to raise_error
      end
    end
  end

  describe '#time' do
    let(:time_in_secs) { 3.2 }

    it 'multiplies given time in secs by 1000' do
      expect(animation.time).to eq(3200)
    end
  end

  describe '#start' do
    let(:time_in_secs) { 2 }

    before do
      allow(Gosu).to receive(:milliseconds).and_return(milliseconds)
    end

    context 'when Gosu.milliseconds is called for the first time and returns 0' do
      let(:milliseconds) { 0 }

      it 'brings the first frame' do
        expect(animation.start).to eq(frames.first)
      end
    end

    context 'when Gosu.milliseconds / time % frames.size = frames.size - 1' do
      let(:milliseconds) { 22_000 }

      it 'brings the last frame' do
        expect(animation.start).to eq(frames.last)
      end
    end

    context 'when Gosu.milliseconds is multiple of time' do
      let(:milliseconds) { 10 * time_in_secs * 1000 }

      it 'brings the second frame' do
        expect(animation.start).to eq(frames[1])
      end
    end

    context 'when Gosu.milliseconds is 3 times the time in secs' do
      let(:milliseconds) { 3 * time_in_secs * 1000 }

      it 'brings the first frame' do
        expect(animation.start).to eq(frames.first)
      end
    end
  end

  describe '#stop' do
    it 'brings the first frame' do
      expect(animation.stop).to eq(frames.first)
    end
  end
end
