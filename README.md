# NWS Alert

A gem to access the NOAA alerts service.

## Usage

``` ruby
  # Create a new connection
  nws = Nws::Connect.new('ri')

  # Get a list of alerts
  nws.alerts #=> #<Nws::Connect:0x00000101e79850 @alerts=[#<Nws::Alert:0x000001012a6460 @entry={"xmlns"=>"urn:oasis:names:tc:emergency:cap:1.1", "identifier"=>"NOAA-NWS-ALERTS-RI1251425F7454.WinterStormWarning.1251426D24A0RI.BOXWSWBOX.8a7ff60225f58d63dd3a8eb8d8fa5b0b", "sender"=>"w-nws.webmaster@noaa.gov", "sent"=>"2014-02-15T15:29:00-05:00", "status"=>"Actual", "msgType"=>"Alert", "scope"=>"Public", "note"=>"Alert for Bristol; Eastern Kent; Newport; Northwest Providence; Southeast Providence; Washington; Western Kent (Rhode Island) Issued by the National Weather Service", "info"=>{"category"=>"Met", "event"=>"Winter Storm Warning", "urgency"=>"Expected", "severity"=>"Moderate", "certainty"=>"Likely", "eventCode"=>{"valueName"=>"SAME", "value"=>"WSW"}, "effective"=>"2014-02-15T15:29:00-05:00", "expires"=>"2014-02-16T05:00:00-05:00", "senderName"=>"NWS Boston (Southeast New England)", "headline"=>"Winter Storm Warning issued February 15 at 3:29PM EST until February 16 at 5:00AM EST by NWS Boston", "description"=>"DESCRIPTION OF THE WEATHER ADVISORY", "parameter"=>[{"valueName"=>"WMOHEADER", "value"=>nil}, {"valueName"=>"UGC", "value"=>"MAZ013>017-020-RIZ001>007"}, {"valueName"=>"VTEC", "value"=>"/O.CON.KBOX.WS.W.0007.000000T0000Z-140216T1000Z/"}, {"valueName"=>"TIME...MOT...LOC", "value"=>nil}], "area"=>{"areaDesc"=>"Bristol; Eastern Kent; Newport; Northwest Providence; Southeast Providence; Washington; Western Kent", "polygon"=>nil, "geocode"=>[{"valueName"=>"FIPS6", "value"=>"044001"}, {"valueName"=>"FIPS6", "value"=>"044003"}, {"valueName"=>"FIPS6", "value"=>"044005"}, {"valueName"=>"FIPS6", "value"=>"044007"}, {"valueName"=>"FIPS6", "value"=>"044009"}, {"valueName"=>"UGC", "value"=>"RIZ001"}, {"valueName"=>"UGC", "value"=>"RIZ002"}, {"valueName"=>"UGC", "value"=>"RIZ003"}, {"valueName"=>"UGC", "value"=>"RIZ004"}, {"valueName"=>"UGC", "value"=>"RIZ005"}, {"valueName"=>"UGC", "value"=>"RIZ006"}, {"valueName"=>"UGC", "value"=>"RIZ007"}]}}}>

  # Get status of alert
  nws.alerts.first.status #=> "Actual"

  # Get expiry date of alert
  nws.alerts.first.expires #=> #<DateTime: 2014-02-16T05:00:00-05:00 ((2456705j,36000s,0n),-18000s,2299161j)>
```

### Full Alert Methods

`status`: Status of the alert

`note`: Note of alert. Describes the affected locations and that it was issued by the NWS.

`event`: Alert type (e.g., Winter Storm Warning).

`urgency`: Urgency of alert.

`severity`: Severity of the alert.

`certainty`: Likelihood of the events described in the alert.

`effective`: Effective date of the alert. Returns DateTime instance.

`expires`: Expiry date of the alert. Returns DateTime instance.

`sender_name`: Returns the name of the NWS office that issued the alert.

`headline`: Returns the event, date of issue, and NWS office that issued the alert.

`description`: Full description of the alert.

`affected_area`: Names all of the areas affected by the alert.

## License

MIT