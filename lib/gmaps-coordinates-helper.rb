require "gmaps-coordinates-helper/version"

module GmapsCoordinatesHelper

  TILE_SIZE = 256.0 # width/height of Google Maps tile in pixels
  PIXELS_PER_LON_DEGREE = TILE_SIZE / 360.0
  PIXELS_PER_LON_RADIAN = TILE_SIZE / (2 * Math::PI)

  class Point
    attr_accessor :x, :y

    def initialize(x = 0.0, y = 0.0)
      self.x, self.y = x, y
    end

    def *(multiplicand)
      return Point.new(self.x * multiplicand, self.y * multiplicand)
    end

    def /(divisor)
      return Point.new(self.x / divisor, self.y / divisor)
    end

    def floor
      return Point.new(self.x.floor, self.y.floor)
    end
  end

  PIXEL_ORIGIN = Point.new(TILE_SIZE / 2, TILE_SIZE / 2)

  class LatLng
    attr_accessor :lat, :lng

    def initialize(lat, lng)
      self.lat, self.lng = lat, lng
    end

    def to_world_coordinates
      p = Point.new

      p.x = PIXEL_ORIGIN.x + lng * PIXELS_PER_LON_DEGREE

      # This bounding allows us about a third of a tile past the edge of the world
      # cf. https://developers.google.com/maps/documentation/javascript/maptypes#WorldCoordinates
      sinY = Math.sin(degrees_to_radians(lat))
      p.y = PIXEL_ORIGIN.y + 0.5 * Math.log((1 + sinY) / (1 - sinY)) * -PIXELS_PER_LON_RADIAN
      p.y = bound(p.y, 0, 256)

      return p
    end

    def to_tile_coordinates(zoom)
      tiles_along_edge = 1 << zoom
      pixel_point = (to_world_coordinates * tiles_along_edge).floor
      return (pixel_point / TILE_SIZE).floor
    end

    private

    def degrees_to_radians(deg)
      return deg * (Math::PI / 180)
    end

    def radians_to_degrees(rad)
      return rad / (Math::PI / 180)
    end

    def bound(value, min = nil, max = nil)
      value = [ value, min ].max unless min.nil?
      value = [ value, max ].min unless max.nil?
      return value
    end

  end

end
