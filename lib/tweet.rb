require "geocoder"
require "twitter"
require "rest-client"

class Tweet < SimpleDelegator
  def to_pajat_hash
    {
      report: {
        latitude: latitude,
        longitude: longitude,
        description: full_text,
        agent: 'standout-twitter-bot v1',
        reporter_network: 'twitter',
        reporter_username: user.screen_name,
        source_url: uri.to_s,
        image_url: image_uri.to_s
      }
    }
  end

  def to_json
    to_pajat_hash.to_json
  end

  def send_to_pajat!
    endpoint = "http://api.pajat.se"
    RestClient.post "#{endpoint}/reports", to_json,
                    content_type: :json, accept: :json
  end

  def longitude
    coordinates["lng"]
  end

  def latitude
    coordinates["lat"]
  end

  def image_uri
    image = Array(media).find { |m| m.is_a?(Twitter::Media::Photo) }
    image.media_uri_https if image
  end

  private

  def coordinates
    return {} unless place?
    @coordinates ||= google_geo.data.fetch("geometry", {})["location"]
  end

  def google_geo
    Geocoder.search(place.full_name).find do |result|
      result.is_a? Geocoder::Result::Google
    end
  end
end
