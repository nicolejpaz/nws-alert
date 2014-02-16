require 'httparty'
require 'alert'

module Nws
  class Connect
    attr_reader :alerts

    def initialize(location)
      @alerts = []
      fetch(location)
    end

    private

    def fetch(location)
      xml = HTTParty.get("http://alerts.weather.gov/cap/#{location}.php?x=0", format: :xml)
      parse_entries(xml)
    end

    def parse_entries(xml)
      entries = xml['feed']['entry']
      entries.each do |entry|
        item = HTTParty.get(entry['id'], format: :xml)['alert']
        alert = Alert.new(item)
        @alerts << alert
      end
    end
  end
end