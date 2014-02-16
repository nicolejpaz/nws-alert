require 'httparty'
require 'nokogiri'
require 'open-uri'
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
      unless /\d{5}/.match(location).nil?
        xml = parse_weather_alerts_by_zone(location)
      else
        xml = HTTParty.get("http://alerts.weather.gov/cap/#{location}.php?x=0", format: :xml)
      end
      parse_entries(xml)
    end

    def parse_weather_alerts_by_zone(location)
      lat_long = get_lat_long(location)
      lat = lat_long.gsub(/,.{7,}/, '')
      long = lat_long.gsub(/.{7,},/, '')

      zone = scrape_for_zone(lat, long)
      
      HTTParty.get("http://alerts.weather.gov/cap/wwaatmget.php?x=#{zone}&y=1", format: :xml)
    end

    def scrape_for_zone(lat, long)
      doc = Nokogiri::HTML(open("http://forecast.weather.gov/MapClick.php?lat=#{lat}&lon=#{long}#.UwAsUmRdXue"))
      div_containing_zone = doc.css('.current-conditions-extra')
      anchor_containing_zone = div_containing_zone.css('a')
      anchor_containing_zone.first.first[1].scan(/[A-Z]{3}\d{3}/).first
    end

    def get_lat_long(location)
      date = Time.now.to_s.gsub(/\s.{1,}/, '')
      HTTParty.get("http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=LatLonListZipCode&lat=&lon=&listLatLon=&lat1=&lon1=&lat2=&lon2=&resolutionSub=&listLat1=&listLon1=&listLat2=&listLon2=&resolutionList=&endPoint1Lat=&endPoint1Lon=&endPoint2Lat=&endPoint2Lon=&listEndPoint1Lat=&listEndPoint1Lon=&listEndPoint2Lat=&listEndPoint2Lon=&zipCodeList=&listZipCodeList=#{location}&centerPointLat=&centerPointLon=&distanceLat=&distanceLon=&resolutionSquare=&listCenterPointLat=&listCenterPointLon=&listDistanceLat=&listDistanceLon=&listResolutionSquare=&citiesLevel=&listCitiesLevel=&sector=&gmlListLatLon=&featureType=&requestedTime=&startTime=&endTime=&compType=&propertyName=&product=time-series&begin=#{date}T00%3A00%3A00&end=#{date}T00%3A00%3A00&Unit=e&wwa=wwa&Submit=Submit", format: :xml)['dwml']['latLonList']
    end

    def parse_entries(xml)
      entries = xml['feed']['entry']
      unless entries['title'] == "There are no active watches, warnings or advisories"
        get_alerts_at_location(entries)
      else
        no_alerts_available
      end
    end

    def get_alerts_at_location(entries)
      # entries.each do |entry|
        # item = HTTParty.get(entry[1], format: :xml)['alert']
        item = HTTParty.get(entries['id'], format: :xml)['alert']
        alert = Alert.new(item) unless item.nil?
        @alerts << alert
      # end
    end

    def no_alerts_available
      begin
        raise StandardError, "There are no active watches or warnings in the area specified"
      rescue Exception => e
        puts e.message
      end
    end
  end
end