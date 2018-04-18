require 'gosu'
require 'bakeru/zorder'
require 'gl'
require 'glu'
require 'glut'

module Bakeru
  class Background
    include Gl
    include Glu

    attr_reader :location, :game
    TILE_SIZE = 1

    def initialize(game, location)
      @game = game
      @location = location

      available_tiles = Dir.glob('assets/sprites/tiles/floor/*').map do |file|
        [file.split('/').last.split('.').first, Gosu::Image.new(file)]
      end.to_h

      @tiles = location.tiles.map do |line|
        line.map do |tile_name|
          available_tiles[tile_name]
        end
      end
    end

    def update

    end

    def draw
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT) # clear the screen and the depth buffer

      #glMatrixMode(matrix) indicates that following [matrix] is going to get used
      glMatrixMode(GL_PROJECTION) # The projection matrix is responsible for adding perspective to our scene.
      glLoadIdentity # Resets current modelview matrix

      # Calculates aspect ratio of the window. Gets perspective  view. 45 is degree viewing angle, (0.1, 100) are ranges how deep can we draw into the screen
      gluPerspective(45.0, game.width / game.height, 0.1, 100.0)
      glMatrixMode(GL_MODELVIEW) # The modelview matrix is where object information is stored.
      glLoadIdentity
      # Think 3-d coordinate system (x,y,z). +- on each movies on that axis
      glTranslate(-10, -10.0, -15) # Moving function from the current point by x,y,z change
      #glTranslate(-1, -1, -1) # Moving function from the current point by x,y,z change

      glEnable(GL_TEXTURE_2D) # enables two-dimensional texturing to perform
      @tiles.each_with_index do |tiles, line|
        tiles.each_with_index do |tile, column|
          #tile.draw line * TILE_SIZE, column * TILE_SIZE, ZOrder::BACKGROUND
          tex_info = tile.gl_tex_info
          glBindTexture(GL_TEXTURE_2D, tex_info.tex_name) # bing named texture to a target

          glBegin(GL_QUADS) # begin drawing model
            glTexCoord2d(tex_info.left, tex_info.top) #sets texture coordinates
            glVertex3d(column, line, 0) # place a point at (x,y,z) location from the current point
            glTexCoord2d(tex_info.right, tex_info.top)
            glVertex3d(column + TILE_SIZE, line, 0)
            glTexCoord2d(tex_info.right, tex_info.bottom)
            glVertex3d(column + TILE_SIZE, line + TILE_SIZE, 0)
            glTexCoord2d(tex_info.left, tex_info.bottom)
            glVertex3d(column, line + TILE_SIZE, 0)
          glEnd
        end
      end
    end
  end
end
