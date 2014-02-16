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

      find_status_and_notes_on_event
      find_severity_and_likelihood_of_alert
      find_sender_and_area_information
      get_text_of_alert
    end

    private

    def effective
      parse_time(@entry['info']['effective'])
    end

    def expires
      parse_time(@entry['info']['expires'])
    end

    def find_status_and_notes_on_event
      @status = @entry['status']
      @note = @entry['note']
      @event = @entry['info']['event']
    end

    def find_severity_and_likelihood_of_alert
      @urgency = @entry['info']['urgency']
      @severity = @entry['info']['severity']
      @certainty = @entry['info']['certainty']
    end

    def find_sender_and_area_information
      @sender_name = @entry['info']['senderName']
      @affected_area = @entry['info']['area']['areaDesc']
    end

    def get_text_of_alert
      @headline = @entry['info']['headline']
      @description = @entry['info']['description']
    end

    def parse_time(raw_datetime)
      DateTime.parse(raw_datetime)
    end
  end
end