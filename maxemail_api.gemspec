Gem::Specification.new do |s|
  s.name = 'maxemail_api'
  s.version = '2.0.11'
  s.date = '2018-07-11'
  s.summary = 'Maxemails API wrapped in a gem'
  s.authors = ['Murray Catto']
  s.files = [
    'lib/maxemail_api.rb',
    'lib/maxemail_api/shared.rb',
    'lib/maxemail_api/response.rb',
    'lib/maxemail_api/triggered.rb',
    'lib/maxemail_api/subscriptions.rb'
  ]
  s.require_paths = ['lib']
  s.add_dependency 'http', '>= 3.3.0'
end
