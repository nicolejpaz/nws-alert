require 'httparty'
require 'date'

module Nws
  class Alert
    attr_reader :status, 
                :note, 
                :event, 
                :urgency, 
                :severity, 
                :certainty, 
                :effective, 
                :expires, 
                :sender_name, 
                :headline, 
                :description, 
                :affected_area

    def initialize(entry)
      @entry = entry
    end

    def status
      @entry['status']
    end

    def note
      @entry['note']
    end

    def event
      @entry['info']['event']
    end

    def urgency
      @entry['info']['urgency']
    end

    def severity
      @entry['info']['severity']
    end

    def certainty
      @entry['info']['certainty']
    end

    def effective
      parse_time(@entry['info']['effective'])
    end

    def expires
      parse_time(@entry['info']['expires'])
    end

    def sender_name
      @entry['info']['senderName']
    end

    def headline
      @entry['info']['headline']
    end

    def description
      @entry['info']['description']
    end

    def affected_area
      @entry['info']['area']['areaDesc']
    end

    private

    def parse_time(raw_datetime)
      DateTime.parse(raw_datetime)
    end
  end

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