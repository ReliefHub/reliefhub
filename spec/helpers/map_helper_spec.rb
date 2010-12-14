require 'spec_helper'

describe MapHelper, "#google_map_image" do
  it "creates a Google Maps static image using size and address" do
    size    = "100x100"
    address = "Boston, MA"
    src     = "http://maps.google.com/maps/api/staticmap?size=#{size}&zoom=12&markers=#{URI.escape(address)}&sensor=false"

    image = google_map_image(size, address)

    parsed = Nokogiri::HTML.parse(image).at("img")
    parsed['src'].should == src
    parsed['alt'].should == address
  end
end
