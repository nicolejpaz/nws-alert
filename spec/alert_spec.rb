require 'spec_helper'

describe Nws::Alert, :vcr do
  let(:response) do
    {
      'status' => 'Actual',
      'note' => 'Alert for test note',
      'info' => {
        'event' => 'Fake Alert',
        'urgency' => 'Bland',
        'severity' => 'Catastrophic',
        'certainty' => 'Likely',
        'effective' => '2014-02-15T18:04:00-05:00',
        'expires' => '2014-02-15T18:04:00-05:00',
        'senderName' => 'Me',
        'headline' => 'Fake Alert for Everywhere',
        'description' => '...FAKE ALERT FOR EVERYWHERE. CATASTROPHIC DAMAGE EVERYWHERE.',
        'area' => {
          'areaDesc' => 'Everywhere'
        }
      }
    }
  end

  subject { Nws::Alert.new(response) }

  its(:status)        { should_not be_empty }
  its(:note)          { should_not be_empty }
  its(:event)         { should_not be_empty }
  its(:urgency)       { should_not be_empty }
  its(:severity)      { should_not be_empty }
  its(:certainty)     { should_not be_empty }
  its(:effective)     { should be_an_instance_of DateTime }
  its(:expires)       { should be_an_instance_of DateTime }
  its(:sender_name)   { should_not be_empty }
  its(:headline)      { should_not be_empty }
  its(:description)   { should_not be_empty }
  its(:affected_area) { should_not be_empty }
end
