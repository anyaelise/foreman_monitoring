require File.expand_path('../lib/foreman_monitoring/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman_monitoring"
  s.version     = ForemanMonitoring::VERSION
  s.date        = Date.today.to_s
  s.authors     = ["Anya Marshall"]
  s.email       = ["anya.elise.marshall@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ForemanMonitoring."
  s.description = "TODO: Description of ForemanMonitoring."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "deface"
  #s.add_development_dependency "sqlite3"
end
