module Bakeru
  module UI
    class Menu
      class Option < Struct.new(:title, :action)
        attr_accessor :previous, :current, :next

        def execute
          action.call
        end
      end

      attr_reader :options, :selected_option, :selected_color, :default_color

      # @param [Hash] options - { title => callable }
      def initialize(options, default_color: 0xff_ececff, selected_color: 0xffaa0a00)
        @selected_color, @default_color = selected_color, default_color

        @options = options.map { |k, v| Option.new(k, v) }

        @options.each_cons(3) do |(previous, current, following)|
          previous.next = current
          current.previous = previous
          current.next = following
          following.previous = current
        end

        @options.first.previous = @options.last
        @options.last.next = @options.first

        @selected_option = @options.first
      end

      def next_option
        @selected_option = selected_option.next
      end

      def previous_option
        @selected_option = selected_option.previous
      end

      def execute
        selected_option.execute
      end

      def options_with_colors
        options.map { |o| [o, color_for(o)] }
      end

      private

      def color_for(option)
        return selected_color if option == selected_option
        default_color
      end
    end
  end
end
