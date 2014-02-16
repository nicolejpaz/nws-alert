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
end