Gem::Specification.new do |s|
  s.name        = 'draw_static'
  s.version     = '1.0.2'
  s.date        = '2019-04-20'
  s.summary     = 'Draw static routes'
  s.add_runtime_dependency 'rails', '~> 5.0', '> 5.0'
  s.description = 'A gem to avoid repitition in your rails routes file'
  s.authors     = ['Inou Ridder']
  s.email       = 'inouridder@gmail.com'
  s.files       = ['lib/draw_static.rb', 'lib/static_routes.rb', 'lib/module_finder.rb']
  s.homepage    =
    'https://github.com/InouRidder/draw_static'
  s.license = 'MIT'
end
