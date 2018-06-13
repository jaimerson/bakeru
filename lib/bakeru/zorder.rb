module Bakeru
  # This module defines the order in which things should be drawn.
  # Higher number is drawn last and therefore is the top layer.
  # Only used by things drawn with Gosu instead of OpenGl.
  module ZOrder
    BACKGROUND = 0
    ITEM = 1
    PLAYER = 2
    UI = 3
  end
end
