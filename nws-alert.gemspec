Gem::Specification.new do |s|
  s.name        = 'nws-alert'
  s.version     = '0.0.1'
  s.date        = '2010-04-28'
  s.summary     = "Obtain NOAA weather alerts."
  s.description = "Obtain weather alerts from NOAA. Look up information by zip code or state."
  s.authors     = ["Nicole Paz"]
  s.email       = 'me@nicolejpaz.com'
  s.files       = ['lib/nws-alert.rb']
  s.homepage    = 'https://github.com/nicolejpaz/nws-alert'
  s.license     = 'MIT'

  s.add_dependency "httparty", "~> 0.13"

  s.add_development_dependency "rspec", "~> 2.14"
  s.add_development_dependency "vcr", "~> 2.8"
  s.add_development_dependency "webmock", "~> 1.17"
end