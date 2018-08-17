Gem::Specification.new do |s|
  s.name = 'maxemail_gem'
  s.version = '1.0.0'
  s.date = '2018-07-11'
  s.summary = 'Maxemails API wrapped in a gem'
  s.authors = ['Murray Catto']
  s.files = [
    'lib/maxemail_api.rb'
  ]
  s.require_paths = ['lib']
  s.add_dependency 'http', '>= 3.3.0'
end
