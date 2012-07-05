require 'spec_helper'
require 'gmaps-coordinates-helper'

DELTA = 1e-8

describe "Google Maps coordinates helper" do

  it "should convert lat/lng to Google Maps world coordinates" do
    p = GmapsCoordinatesHelper::LatLng.new(0, 0).to_world_coordinates
    p.x.should be_within(DELTA).of(128)
    p.y.should be_within(DELTA).of(128)
  end

  it "should work at lat/lng (0, -180)" do
    p = GmapsCoordinatesHelper::LatLng.new(0, -180).to_world_coordinates
    p.x.should be_within(DELTA).of(0)
    p.y.should be_within(DELTA).of(128)
  end

  it "should bound the furthest point south to (y = 256.0)" do
    # The cut-off for latitudes representable is between -85 degrees and -86 degrees
    p1 = GmapsCoordinatesHelper::LatLng.new(-85, 0).to_world_coordinates
    p2 = GmapsCoordinatesHelper::LatLng.new(-86, 0).to_world_coordinates
    p3 = GmapsCoordinatesHelper::LatLng.new(-87, 0).to_world_coordinates

    p1.y.should_not == p2.y
    p2.y.should be_within(DELTA).of(256.0)
    p3.y.should be_within(DELTA).of(256.0)
  end

  it "should bound the furthest point north to (y = 0.0)" do
    p1 = GmapsCoordinatesHelper::LatLng.new(85, 0).to_world_coordinates
    p2 = GmapsCoordinatesHelper::LatLng.new(86, 0).to_world_coordinates
    p3 = GmapsCoordinatesHelper::LatLng.new(87, 0).to_world_coordinates

    p1.y.should_not == p2.y
    p2.y.should be_within(DELTA).of(0.0)
    p3.y.should be_within(DELTA).of(0.0)
  end

  CHICAGO = [ 41.850033,-87.6500523 ]

  it "should give the correct tile coordinates for Chicago at zoom level 0" do
    t = GmapsCoordinatesHelper::LatLng.new(*CHICAGO).to_tile_coordinates(0)
    t.x.should == 0
    t.y.should == 0
  end

  it "should give the correct tile coordinates for Chicago at zoom level 21" do
    t = GmapsCoordinatesHelper::LatLng.new(*CHICAGO).to_tile_coordinates(21)
    t.x.should == 537977
    t.y.should == 779672
  end

end
