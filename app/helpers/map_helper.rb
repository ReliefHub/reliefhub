module MapHelper
  def google_map_image(size, address)
    image_tag "http://maps.google.com/maps/api/staticmap?size=#{size}&zoom=12&markers=#{URI.escape(address)}&sensor=false",
              :alt => address
  end
end
