AMERICAN_DATE_GEMSPEC = Gem::Specification.new do |s|
  s.name = 'american_date'
  s.version = '1.3.0'
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options += ["--quiet", '--inline-source', '--line-numbers', '--title', 'american_date: American style month/day/year date parsing for ruby 1.9+', '--main', 'README.rdoc']
  s.summary = "American style month/day/year date parsing for ruby 1.9+"
  s.description = s.summary
  s.license = "MIT"
  s.metadata = {
    'bug_tracker_uri'   => 'https://github.com/jeremyevans/ruby-american_date/issues',
    'changelog_uri'     => 'https://github.com/jeremyevans/ruby-american_date/blob/master/CHANGELOG',
    'source_code_uri'   => 'https://github.com/jeremyevans/ruby-american_date'
  }
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "https://github.com/jeremyevans/ruby-american_date"
  s.files = %w(MIT-LICENSE CHANGELOG README.rdoc lib/american_date.rb)
  s.add_development_dependency "minitest", '>=5'
  s.add_development_dependency "minitest-global_expectations"
end
