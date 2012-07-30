Gem::Specification.new do |s|
  s.name = 'american_date'
  s.version = '1.1.0'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options += ["--quiet", '--inline-source', '--line-numbers', '--title', 'american_date: American style month/day/year date parsing for ruby 1.9', '--main', 'README.rdoc']
  s.summary = "American style month/day/year date parsing for ruby 1.9"
  s.description = s.summary
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "https://github.com/jeremyevans/ruby-american_date"
  s.files = %w(MIT-LICENSE CHANGELOG README.rdoc Rakefile) + Dir["{spec,lib}/american_date*.rb"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'debugger'
end
